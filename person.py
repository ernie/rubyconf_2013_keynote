#!/usr/bin/env python

class Person:
  def __init__(self, name, age):
    self.name = name
    self.age  = age

person = Person('Ernie', 36)

print person.name
print person.age
person.nonexistent_attribute = 'Seriously?'
print person.nonexistent_attribute
