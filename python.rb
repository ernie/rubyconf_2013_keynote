#!/usr/bin/env ruby

class Object
  alias print puts

  def setter_block(name)
    ->(*args) { instance_variable_get(:@__attributes__)[name] = *args }
  end

  def getter_block(name)
    ->(*args) { instance_variable_get(:@__attributes__)[name] }
  end

  def method_missing(method_id, *args, &block)
    method_name = method_id.to_s
    if method_name.end_with?('=') &&
      self.instance_variable_defined?(:@__attributes__)
      attribute_name = method_name.chop
      define_singleton_method(method_name, setter_block(attribute_name))
      define_singleton_method(attribute_name, getter_block(attribute_name))
      send(method_name, *args, &block)
    elsif Object.const_defined?(method_id)
      obj = Object.const_get(method_id).allocate
      obj.instance_variable_set(:@__attributes__, {})
      obj.__init__(obj, *args, &block)
      obj
    else
      super
    end
  rescue NameError => e
    super
  end
end

class Person
  def __init__(se1f, name, age)
    se1f.name = name
    se1f.age  = age end end

person = Person('Ernie', 36)

print person.name
print person.age
person.nonexistent_attribute = 'Seriously?'
print person.nonexistent_attribute
