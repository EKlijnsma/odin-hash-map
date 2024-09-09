# frozen_string_literal: true

require_relative 'linked_list'
require_relative 'node'

class HashMap
  def initialize(capacity = 8, load_factor = 0.85)
    self.capacity = capacity
    self.load_factor = load_factor
    self.buckets = Array.new(capacity) { LinkedList.new }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @capacity
  end

  def set(key, value)
    # generate hash
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    # If key exists already, remove it. Then add new key-value pair
    remove(key) if has?(key)
    buckets[index].append(key, value)
    # expand if required
    expand if length > capacity * load_factor
  end

  def expand
    puts "expanding HashMap from #{capacity} to #{2 * capacity} buckets"
    content = entries
    self.capacity = capacity * 2
    self.buckets = Array.new(capacity) { LinkedList.new }
    content.each { |entry| set(entry[0], entry[1]) }
    self
  end

  def get(key)
    # generate hash and identify bucket
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = buckets[index]

    # Return value or nil
    list_index = bucket.find(key)
    list_index.nil? ? nil : bucket.at(list_index).value
  end

  def has?(key)
    get(key).nil? ? false : true
  end

  def remove(key)
    # generate hash and identify bucket
    index = hash(key)
    raise IndexError if index.negative? || index >= @buckets.length

    bucket = buckets[index]

    # Find the key in the bucket, return nil if it cant be found
    list_index = bucket.find(key)
    return nil if list_index.nil?

    # Remove the node and return its value
    removed_node = bucket.remove_at(list_index)
    removed_node.value
  end

  def length
    counter = 0
    # Add the size of the linked list in each bucket to the counter
    buckets.each { |list| counter += list.size }
    # Return the counter
    counter
  end

  def clear
    self.buckets = Array.new(capacity) { LinkedList.new }
  end

  def keys
    keys = []
    # for each bucket, get the nodes, get their corresponding keys and add them to the keys array
    buckets.each do |list|
      current_nodes = list.nodes
      current_keys = current_nodes.map(&:key)
      keys.concat(current_keys)
    end
    keys
  end

  def values
    values = []
    # for each bucket, get the nodes, get their corresponding values and add them to the values array
    buckets.each do |list|
      current_nodes = list.nodes
      current_values = current_nodes.map(&:value)
      values.concat(current_values)
    end
    values
  end

  def entries
    entries = []
    # for each bucket, get the nodes, get their corresponding entries and add them to the entries array
    buckets.each do |list|
      current_nodes = list.nodes
      current_entry = current_nodes.map { |node| [node.key, node.value] }
      entries.concat(current_entry)
    end
    entries
  end

  attr_accessor :capacity, :load_factor, :buckets
end
