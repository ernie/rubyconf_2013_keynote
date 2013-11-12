#!/usr/bin/env ruby

class Greeter
      def initialize ( greeting )
            @greeting = greeting
      end
      def greet ( name, number_of_greetings = 1 )
            number_of_greetings.times do
                  puts ("#{ @greeting }, #{ name }!")
            end
      end
end

greeter = Greeter.new ( "HI2U" )
greeter.greet ( "RubyConf" )
