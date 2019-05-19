# Assignment: Build a 'select' method

def select(array)
  selected_items = []
  counter = 0
  while counter < array.size
    element = array[counter]
    selected_items << element if yield(element)
    counter += 1
  end

  selected_items
end


# Examples:

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }      # => [1, 3, 5]
p select(array) { |num| puts num }      # => [], because "puts num" returns nil and evaluates to false
p select(array) { |num| num + 1 }       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true
