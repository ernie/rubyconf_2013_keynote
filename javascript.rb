#!/usr/bin/env ruby

class Hash
  def method_missing(method_id, *args, &block)
    has_key?(method_id) ? self[method_id].(*args, &block) : super
  end

  def [](key)
    fetch(key) { fetch(key.to_sym) } # LOL GC
  end

  def respond_to_missing?(method_id, include_private = false)
    has_key?(method_id) || super
  end
end

class Fixnum
  alias to_str to_s
end

class Console
  def log(*args)
    puts *args
  end
end

console = Console.new

App = {
  say: ->(string) { console.log(string) },
  ifMultipleOf: ->(number, check, callback) {
    (check % number) == 0 ? callback.(check) : nil;
  },
  ifEven: ->(number, callback) {
    App.ifMultipleOf(2, number, callback);
  },
  proclaimEvenness: ->(number) {
    App.say("It would appear that "+number+" is an even number.");
  }
}
App.say("Hello, world!");
App.ifEven(42, App['proclaimEvenness']);
