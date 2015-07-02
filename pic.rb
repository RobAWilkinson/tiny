#!/usr/bin/env ruby

require 'httparty'
require "tco"
require "rmagick"
require 'base64'
res = HTTParty.get('http://media.playdota.com/hero/105/icon.jpg')
img = Base64.encode64 res.parsed_response
img = Magick::Image::read_inline(img).first

img.each_pixel do |pixel, col, row|
  c = [pixel.red, pixel.green, pixel.blue].map { |v| 256 * (v / 65535.0) }
  pixel.opacity == 65535 ? print("  ") : print("  ".bg c)
  puts if col >= img.columns - 1
end
puts "TINY SMASH"
