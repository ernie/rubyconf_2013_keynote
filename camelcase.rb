#!/usr/bin/env ruby

class AwesomeGreeter

  def initialize(theSalutation)
    @theSalutation = theSalutation
  end

  def greetPersonOrGroup(nameOfGreetable, numberOfTimesToGreet = 1)
    numberOfTimesToGreet.times do
      puts("#{@theSalutation}, #{nameOfGreetable}!")
    end
  end

end

greeter = AwesomeGreeter.new('Happy Hump Day')
greeter.greetPersonOrGroup('RubyConf')
