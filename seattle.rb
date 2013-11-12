#!/usr/bin/env ruby

class City
  attr_reader :traits

  def initialize
    @traits = []
  end

  def trait description
    @traits << description
  end

  def space needle
    "space needle, for knitting space socks."
  end

  def grunge music
    "smells like teen spirit"
  end

  def emerald city, usa
    trait space :needle
    trait grunge :music
  end
end

city = City.new
city.emerald :city, :usa
city.traits.each { |t| puts "* #{t}" }
