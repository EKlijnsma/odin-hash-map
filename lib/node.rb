# frozen_string_literal: true

class Node
  attr_accessor :key, :value, :next_node

  def initialize(key = nil, value = nil, next_node = nil)
    self.key = key
    self.value = value
    self.next_node = next_node
  end

  def to_s
    key
  end
end
