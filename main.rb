# frozen_string_literal: true

require_relative 'lib/hash_map'
require_relative 'lib/node'
require 'random-word'

test = HashMap.new

# test.set('apple', 'red')
# test.set('banana', 'yellow')
# test.set('carrot', 'orange')
# test.set('dog', 'brown')
# test.set('elephant', 'gray')
# test.set('frog', 'green')
# test.set('grape', 'purple')
# test.set('hat', 'black')
# test.set('ice cream', 'white')
# test.set('jacket', 'blue')
# test.set('kite', 'pink')
# test.set('lion', 'golden')
# puts test.buckets
# test.set('moon', 'silver')
# puts test.buckets

desired_size = 50
desired_size.times { test.set(RandomWord.adjs.next, RandomWord.adjs.next) }

puts test.buckets
