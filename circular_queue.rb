=begin
input: size of the buffer
output: buffer object

rules:
  - obtain buffer size with an arg provided to CircularQueue::new
  - adding obj's: when empty, follows most recently added obj
  - adding obj's: when full, replce oldest with new obj
  - removing obj's: always removes the oldest obj
  - none of the values stored in the queue are nil
  - nil can be used to designat empty spots in the buffer

  - two methods: enqueue and dequeue
  - enqueue -- add an obj to the queue
  - dequeue -- remove (and return) the oldest object in the queue
    - return nil if the queue is empty

data structure/type:
  - Array's. I don't see a need for a Set
  - No need for hash
  - objects inside buffer can be any object except nil
    - nil is used to represent empty spots/positions

Algorithm:
  - set a start_data pointer to position/index 0
  - set end_data pointer to position/index 0
    - this is the oldest obj addded
  - pointers increment the same way: (pointer + 1) % size
  - define full? method

  - behaviors: enqueue, dequeue, full?, incrementor
  - state: array, start and end pointers

  - constructor takes a size
=end

class CircularQueue
  attr_accessor :start_position, :end_position

  def initialize(size)
    @buffer = Array.new(size)
    @start_position = 0
    @end_position = 0
  end

  def enqueue(data)
    dequeue if full?
    buffer[start_position] = data
    self.start_position = increment(start_position)
  end

  def dequeue
    data_removed = buffer[end_position]
    buffer[end_position] = nil
    if !data_removed.nil?
      self.end_position = increment(end_position)
    end
    data_removed
  end

  private

  attr_accessor :buffer

  def increment(position)
    position = (position + 1) % buffer.size
  end

  def full?
    buffer.count(nil) == 0
  end
end

# Examples / Test cases
queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
