[[1, 2], [3, 4]].each do |arr|
  puts arr.first
end
# 1
# 3
# => [[1, 2], [3, 4]]

# example 3
[[1, 2], [3, 4]].map do |arr|
  puts arr.first
  arr.first
end

# The first line has the map method call on the outer array object. No side effect. It returns a new array of [1, 3], but this is not used.
# From the 1st to the 4th line, there is a block execution on each sub-array. No side effect. Returns integer at index 0 of sub-array. This is used by map for transformation.
# The second line calls first on each sub-array. No side effect. It returns element at index 0 of sub-array. It is used by puts.
# Second line also calls puts on index 0 of each sub-array. It outputs a string representation of an integer in this case. It returns nil, which isn't used.
# Third line calls first on each sub-array. No side-effect. It returns again the first integer from each subarray and this is used to determine the return value of the block.
# This return value is then used by map to perform the transformation, replacing the inner array with an integer.
# map returns a new array with two integers in it (mentioned above).

# example 4
my_arr = [[18, 7], [3, 12]].each do |arr|
  arr.each do |num|
    if num > 5
      puts num
    end
  end
end

# variable assignment action. Object it acts on is not applicable. No side effects. Returns [[18, 7], [3, 12]], which is not used
# method call, each, for the outer array object. No side effect. Returns the calling object, which is used by variable assignment to my_arr
# lines 1 - 7 is the outer block execution that acts on each sub-array object. no sideeffect and it returns each sub-array. return value isn't used.
# line 2 has each method call on each sub array that has no side effect but returns the original object, that's used to determine the return value of the outer block
# lines 2 - 6 is the inner block execution on the element of the sub-array in that iteration with no side effect and returns nil, that's not used.
# line 3 is the comparison (>) on the element of the sub-array in that iteration that has no side-effect, returns a boolean, and is used to determine the return value of the inner block
# lines 3-5 is the conditional if on the elemenr of the sub-array in that iteration without a side effect and returns nil that's used to determine the return of the inner block
# line 4 is puts method call that displays element of inner-array that returns nil that is used to determine the return of the inner block.

# 18
# 7
# 12
# => [[18, 7], [3, 12]]

# example 5
[[1, 2], [3, 4]].map do |arr|
  arr.map do |num|
    num * 2
  end
end

# line 1: map method action acting on original array. no side effect. returns new array with transformations. Return is not used
# lines 1-5: outer block execuation acting on each sub-array. no side effect. returns new transformed array used by outer map for transformation
# line 2: map method action on sub-array. No side effect. Returns transformed sub-array that is used to determine outer block's return value.
# lines 2-4: inner block execution on the elements of each sub-array. No side effect. Returns the transformed elements used by inner map to determine transformation criteria
# line 3: num * 2 execution on (not applicable) without side effect and returns the expression evaluated (an integer). The return is used to determined return value of the inner block.

# example 6
[{ a: 'ant', b: 'elephant' }, { c: 'cat' }].select do |hash|
  hash.all? do |key, value|
    value[0] == key.to_s
  end
end
# => [{ :c => "cat" }]

# example 7
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]

arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end

# example 8
[[8, 13, 27], ['apple', 'banana', 'cantaloupe']].map do |arr|
  arr.select do |item|
    if item.to_s.to_i == item # if it's an integer
      item > 13
    else
      item.size < 6
    end
  end
end

# => [[27], ["apple"]]

# example 9
[[[1], [2], [3], [4]], [['a'], ['b'], ['c']]].map do |element1|
  element1.each do |element2|
    element2.partition do |element3|
      element3.size > 0
    end
  end
end
# => [[[1], [2], [3], [4]], [["a"], ["b"], ["c"]]]
# new array returned that matches the value of the calling object

# example 10
[[[1, 2], [3, 4]], [5, 6]].map do |arr|
  arr.map do |el|
    if el.to_s.size == 1 # if it's an integer
      el + 1
    else                 # if it's an array
      el.map do |n|
        n + 1
      end 
    end
  end
end
