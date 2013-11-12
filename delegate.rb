#!/usr/bin/env ruby

class Module
  private

  def delegate(*args)
    dest, prefix = _extract_valid_delegation_options(args.pop)
    _define_delegators(caller_locations.first, prefix, dest, args)
  end

  def delegate_maybe(*args)
    dest, prefix = _extract_valid_delegation_options(args.pop)
    _define_delegators(
      caller_locations.first, prefix,
      "(_ = #{dest}; _.nil? ? NilDelegate.new : _)", args
    )
  end

  def _define_delegators(from, prefix, accessor, args)
    args.each do |arg|
      method_name = [prefix, arg].compact.join('_')
      module_eval(
        _delegator(accessor, arg, method_name),
        from.path, from.lineno - 2
      )
    end
  end

  def _delegator(accessor, destination_method, local_method)
    %{
      def #{local_method}(*args, &block)
        #{accessor}.__send__(:#{destination_method}, *args, &block)
      end
    }
  end

  def _extract_valid_delegation_options(opts)
    if Hash === opts && opts.has_key?(:to)
      [opts[:to].to_s.sub(/^([a-z])/, 'self.\1'), opts[:prefix]]
    else
      raise ArgumentError, 'Invalid delegation options. Delegate with :to.'
    end
  end
end

class NilDelegate < BasicObject
  delegate *(nil.methods - [:__send__, :object_id]), :to => :__nil__

  private

  def __nil__
    nil
  end

  def method_missing(method_id, *args, &block)
    nil
  end

  def respond_to_missing?(method_id, include_private = false)
    true
  end
end

class Owner
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def play
    puts 'ZOMG PLAYTIME!'
  end
end

class Cat
  attr_accessor :name, :owner
  delegate :name, :name=, :to => :owner, :prefix => 'servant'
  delegate_maybe :play, :to => :owner

  def initialize(name, owner = nil)
    @name, @owner = name, owner
  end
end

puts MyObject.new.size

ernie = Owner.new('Ernie')
esther = Cat.new('Esther', ernie)
p esther.name # => "Esther"
p esther.servant_name # => "Ernie"
esther.play # => "ZOMG PLAYTIME!"
p esther.servant_name = 'Ernest'
esther.owner = nil
esther.play # => nil
p esther.servant_name
# => undefined method `name' for nil:NilClass (NoMethodError)
