# frozen_string_literal: true

require_relative 'node'

class LinkedList
  def initialize
    self.head = nil
    self.size = 0
  end

  def append(key, value)
    # Add new node as head if the list was empty.
    # Otherwise let the tail node point to a newly created node
    head.nil? ? self.head = Node.new(key, value) : tail.next_node = Node.new(key, value)
    # increment size of the list
    self.size += 1
  end

  def prepend(key, value)
    # Add new node as head, set next_node to the old head if the list was not empty
    self.head = (head.nil? ? Node.new(key, value) : Node.new(key, value, head))
    # increment size of the list
    self.size += 1
  end

  def tail
    node = head
    # Start from the head and keep moving to the next node until there is no next node anymore
    node = node.next_node until node.next_node.nil?
    node
  end

  def at(index)
    # Move 'index' times to the next node from the head of the list
    node = head
    index.times do
      node = node.next_node
    end
    node
  end

  def pop
    # store tail node
    popped = tail
    # set pointer of the second to last node to nil
    at(self.size - 2).next_node = nil
    # decrement size of the list
    self.size -= 1
    # return the popped node
    popped
  end

  def contains?(key)
    # if the find method returns 'nil' the value was not found
    find(key).nil? ? false : true
  end

  def find(key)
    # start at the head node, keep track of the index / number of nodes
    index = 0
    node = head
    until node.nil?
      # return the index if the current node contains the value we try to find
      return index if node.key == key

      # Otherwise move to the next node and increment the index
      node = node.next_node
      index += 1
    end
    # Loop ends if the whole list was traversed (node == nil) and value was not found
    nil
  end

  def to_s
    string = ''
    current = head
    until current.nil?
      string += "( #{current} ) -> "
      current = current.next_node
    end
    "#{string}nil"
  end

  def insert_at(key, value, index)
    if index.zero?
      # use prepend if index is zero
      prepend(key, value)
    elsif index == size
      # use append if index is list size
      append(key, value)
    else
      # Make a new node pointing at the current node at index
      new_node = Node.new(key, value, at(index))
      # Make the previous node point at the new node
      at(index - 1).next_node = new_node
      # increment size of the list
      self.size += 1
    end
  end

  def remove_at(index)
    # find target node
    target = at(index)
    if target == head
      # if target is the head node, make the next one the head node
      self.head = head.next_node
    elsif target == tail
      # if target is the tail node, pop it
      pop
    else
      # in all other cases, let the previous node point to the next one to unlink the target
      at(index - 1).next_node = target.next_node
    end
    # decrement size of the list and return target node
    self.size -= 1
    target
  end

  def nodes
    nodes = []
    current_node = head
    # Iterate over linked list from head to tail
    until current_node.nil?
      nodes.push(current_node)
      current_node = current_node.next_node
    end
    nodes
  end

  attr_accessor :size, :head
end
