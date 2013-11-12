#!/usr/bin/env ruby

require 'erb'

class PersonalHomePage
  def array(*args)
    Hash === args.first ? args.first : Array(args)
  end

  def implode(*args)
    array_join(*args.reverse)
  end

  Array.instance_methods.each do |method_name|
    define_method "array_#{method_name}", ->(array, *args, &block) {
      array.to_a.send(method_name, *args, &block)
    }
  end

  String.instance_methods.each do |method_name|
    define_method "str_#{method_name}", ->(string, *args, &block) {
      string.send(method_name, *args, &block)
    }
  end

  alias sort array_sort!

  def str_split(string, length = 1)
    string.scan(/.{1,#{length}}/)
  end

  def render(template)
    ERB.new(template, nil, '<>').run(binding)
  end
end

PersonalHomePage.new.render(DATA.read)

__END__
<% $fruits = array('banana', 'apple', 'orange') %>
A sorted list of fruits:

<% sort($fruits) %>
<% for $fruit in $fruits %>
  * <%= $fruit %>
<% end %>

<%= $fruits[0] %> is spelled:
  <%= implode(' ', str_split($fruits[0])) %>
<%
  $rubies = array(
    '1.8' => 'unsupported',
    '1.9' => 'supported',
    '2.0' => 'supported'
  )
%>
Important note regarding Ruby versions:

<% for ($ruby, $status) in $rubies %>
  * <%= implode(' is ', array($ruby, $status)) %>
<% end %>
