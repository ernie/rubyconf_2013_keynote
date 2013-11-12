#!/usr/bin/env ruby

class Greeter
  # Initialize with a greeting, x.
  def initialize(x)
    @x = x
  end

  # Greet the person/group named x,
  # i times.
  def greet(x, i = 1)
    i.times { puts "#{@x}, #{x}!" }
  end
end

greeter = Greeter.new('Greetings')
greeter.greet('RubyConf', 3)
