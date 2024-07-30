require_relative 'node'

class LinkedList
  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  attr_accessor :size, :head, :tail

  def append(value)
    new_node = Node.new
    new_node.value = value

    if size.positive?
      tail.next_node = new_node
    else
      self.head = new_node
    end

    self.tail = new_node
    self.size += 1
  end

  def prepend(value)
    new_node = Node.new
    new_node.value = value

    if size.positive?
      new_node.next_node = head
    else
      self.tail = new_node
    end

    self.head = new_node
    self.size += 1
  end

  def at(index)
    index = self.size + index if index.negative?

    current_node = head
    current_node_index = 0

    until current_node.nil?
      return current_node if current_node_index == index

      current_node = current_node.next_node
      current_node_index += 1
    end

    current_node
  end

  def pop
    self.tail = at(-2)
    tail.next_node = nil
    self.size -= 1
  end

  def shift
    self.head = at(1)
    self.size -= 1
  end

  def contains?(value)
    current_node = head

    until current_node.nil?
      return true if current_node.value == value

      current_node = current_node.next_node
    end

    false
  end

  def find(value)
    current_node = head
    current_node_index = 0

    until current_node.nil?
      return current_node_index if current_node.value == value

      current_node = current_node.next_node
      current_node_index += 1
    end

    current_node
  end

  def to_s
    string_representation = ''
    current_node = head

    until current_node.nil?
      string_representation += "( #{current_node.value} ) -> "
      string_representation += 'nil' if current_node.next_node.nil?

      current_node = current_node.next_node
    end

    string_representation
  end

  def insert_at(value, index)
    index = self.size + index if index.negative?

    return if index > (self.size - 1)
    return append(value) if index == (self.size - 1)
    return prepend(value) if index.zero?

    new_node = Node.new
    new_node.value = value

    previous_node = at(index - 1)
    new_node.next_node = previous_node.next_node
    previous_node.next_node = new_node

    self.size += 1
  end

  def remove_at(index)
    index = self.size + index if index.negative?

    return if index > (self.size - 1)
    return pop if index == (self.size - 1)
    return shift if index.zero?

    current_node = at(index)
    previous_node = at(index - 1)

    previous_node.next_node = current_node.next_node

    self.size -= 1
  end
end
