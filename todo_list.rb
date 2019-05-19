# Assignment: TodoList

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # ---- Adding to the list -----
  def add(task)
    raise TypeError.new("Can only add Todo objects") if task.class != Todo
    @todos << task
  rescue TypeError => error
    puts error.message
  end

  def <<(task)
    add(task)
  end

  # ---- Interrogating the list -----
  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  # ---- Retrieving an item in the list ----
  def item_at(index)
    @todos.fetch(index)
  rescue IndexError => error
    puts error.class
  end

  # ---- Marking items in the list -----
  def mark_done_at(index)
    @todos.fetch(index).done!
  rescue IndexError => error
    puts error.class
  end

  def mark_undone_at(index)
    @todos.fetch(index).undone!
  rescue IndexError => error
    puts error.class
  end

  # ---- Deleting from the the list -----
  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    raise IndexError if !(-@todos.size...@todos.size).cover?(index)
    @todos.delete_at(index)
  rescue IndexError => error
    puts error.class
  end

  # ---- Outputting the list -----
  def to_s
    list = ''
    @todos.each do |task|
      list << task.to_s + "\n"
    end
    list
  end
end

# Example / Testing

# given
todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

# ---- Adding to the list -----

# add
list.add(todo1)                 # adds todo1 to end of list, returns list
list.add(todo2)                 # adds todo2 to end of list, returns list
list.add(todo3)                 # adds todo3 to end of list, returns list
list.add(1)                     # raises TypeError with message "Can only add Todo objects"

# <<
# same behavior as add

# ---- Interrogating the list -----

# size
list.size                       # returns 3

# first
list.first                      # returns todo1, which is the first item in the list

# last
list.last                       # returns todo3, which is the last item in the list

# ---- Retrieving an item in the list ----

# item_at
begin
  list.item_at                  # raises ArgumentError
rescue ArgumentError => error
  puts error.class
end
list.item_at(1)                 # returns 2nd item in list (zero based index)
list.item_at(100)               # raises IndexError

# ---- Marking items in the list -----

# mark_done_at
begin
  list.mark_done_at             # raises ArgumentError
rescue ArgumentError => error
  puts error.class
end
list.mark_done_at(1)            # marks the 2nd item as done
list.mark_done_at(100)          # raises IndexError

# mark_undone_at
begin
  list.mark_undone_at           # raises ArgumentError
rescue ArgumentError => error
  puts error.class
end
list.mark_undone_at(1)          # marks the 2nd item as not done,
list.mark_undone_at(100)        # raises IndexError

# ---- Deleting from the the list -----

# shift
list.shift                      # removes and returns the first item in list

# pop
list.pop                        # removes and returns the last item in list

# remove_at
begin
  list.remove_at                # raises ArgumentError
rescue ArgumentError => error
  puts error.class
end
list.remove_at(1)               # removes and returns the 2nd item
list.remove_at(100)             # raises IndexError

# ---- Outputting the list -----

# to_s
list.to_s                       # returns string representation of the list

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)
puts ""

puts "---- #{list.title} ----"
puts list
# ---- Today's Todos ----
# [ ] Buy milk
# [ ] Clean room
# [ ] Go to gym

puts ""
# or, if any todos are done
list.mark_done_at(1)

puts "---- #{list.title} ----"
puts list
# ---- Today's Todos ----
# [ ] Buy milk
# [X] Clean room
# [ ] Go to gym