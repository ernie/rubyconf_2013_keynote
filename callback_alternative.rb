#!/usr/bin/env ruby

require 'active_support/callbacks'

class Base

  include ActiveSupport::Callbacks

  define_callbacks :auto_arming

  set_callback :auto_arming, :before, :arm_weapons,
    :if => :not_armed?, :unless => :training_mode?

  def initialize(training_mode = false)
    @training_mode = training_mode
  end

  def training_mode?
    !!@training_mode
  end

  def not_armed?
    !@weapons_armed
  end

  def arm_weapons
    @weapons_armed = true
  end

  def fire_lasers
    run_callbacks :auto_arming do
      puts 'PEW PEW PEW!' if @weapons_armed
    end
  end

end

class SecretBase < Base

  # This base shouldn't go making loud PEW PEW PEW noises
  # unless it really, really needs to.
  skip_callback :auto_arming, :before, :arm_weapons,
    :unless => :under_attack?

  def under_attack?
    true
  end

end

puts "CALLBACKS"
base = SecretBase.new
base.fire_lasers # => PEW PEW PEW!

Object.send :remove_const, :Base
Object.send :remove_const, :SecretBase

module AutoArming

  def fire_lasers
    @weapons_armed = true if should_autoarm?
    super
  end

  def should_autoarm?
    true
  end

end

class Base

  def fire_lasers
    puts 'PEW PEW PEW!' if @weapons_armed
  end

end

puts "EXTEND"
base = Base.new
base.extend AutoArming
puts base.singleton_class.ancestors.inspect
# => [AutoArming, Base, Object, Kernel, BasicObject]
base.is_a?(AutoArming) # => true
base.fire_lasers # => PEW PEW PEW!

Object.send :remove_const, :Base

class Base

  prepend AutoArming

  def fire_lasers
    puts 'PEW PEW PEW!' if @weapons_armed
  end

end

class SecretBase < Base

  def should_autoarm?
    under_attack?
  end

  def under_attack?
    true
  end

end

puts "PREPEND"
base = SecretBase.new
puts Base.ancestors.inspect
# => [AutoArming, Base, Object, Kernel, BasicObject]
puts base.is_a?(AutoArming)
base.fire_lasers # => PEW PEW PEW!
