# Assignment: Build a 'reduce' method

# [1, 2, 3]
def reduce(array, initial=nil)
  counter = initial ? 0 : 1
  memo = initial || array[0]
  while counter < array.size
    current_element = array[counter]
    memo = yield(memo, current_element)
    counter += 1
  end

  memo
end

# Examples:
array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                    # => 15
p reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
