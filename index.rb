#! /usr/bin/env ruby

require 'nokogiri'
require 'open-uri'

# read html file 
doc = File.open("./meet.html") { |f| Nokogiri::HTML(f) }

names = []
# get name's span by its class
doc.css('span.ZjFb7c').each do |name|
    names << name.content
end

messages = []
# get message's div by its class
doc.css('div.GDhqjd').each do |msg|
    name = msg.children[0].children.children[0].text
    time = msg.children[0].children.children[1].text
    msg_text = msg.children[1].content
    messages << [name, time, msg_text]
end

# generate json from messages' array 
messages = messages.map{|msg| {name: msg[0], time: msg[1], msg_text: msg[2]} }