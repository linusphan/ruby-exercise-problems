=begin
Stack Machine Interpretation

input: program is a string passed when creating instance of the class
output: prints value of the register whenever PRINT is called in the program

rules:
  - include all commands
  - Your program should produce an error if an unexpected item is
    present in the string, or if a required stack value is not
    on the stack when it should be (the stack is empty).
      - In all error cases, no further processing should be
        performed on the program.
  - initialize the register to 0.

data type/structure:
  - use array to represent the stack
  - instance variable as pointer for the register value

algorithm:
  - create custom exceptions for unexpected item in string and empty stack
  - create a class called Minilang
  - define constructor that takes in a single argument for the program
    - initialize the stack and register
  - define a method called eval that will evaluate the program
    - calls specific methods based on the commands
    - handle any exceptions that may arise
  - start creating private methods for the commands
=end

class StackMachineError < StandardError; end
class UnexpectedTokenError < StackMachineError; end
class EmptyStackError < StackMachineError; end

class Minilang
  def initialize(program)
    @program = program
    @stack = []
    @register = 0
  end

  def eval
    @program.split.each do |token|
      begin
        if token =~ /\A[+-]?\d+\z/ then send :place_in_register, token.to_i
        elsif token == 'PUSH' then send :minilang_push
        elsif token == 'ADD' then send :add
        elsif token == 'SUB' then send :sub
        elsif token == 'DIV' then send :div
        elsif token == 'MULT' then send :mult
        elsif token == 'MOD' then send :mod
        elsif token == 'POP' then send :minilang_pop
        elsif token == 'PRINT' then send :minilang_print
        else
          raise UnexpectedTokenError.new("Invalid Token: #{token}")
        end
      rescue StackMachineError => e
        abort(e.message)
      end
    end
  end

  private

  attr_accessor :register, :stack

  def place_in_register(number)
    self.register = number
  end

  def minilang_push
    stack.push(register)
  end

  def add
    self.register = stack.pop + register
  end

  def sub
    self.register = register - stack.pop
  end

  def div
    self.register = register / stack.pop
  end

  def mult
    self.register = stack.pop * register
  end

  def mod
    self.register = register % stack.pop
  end

  def minilang_pop
    raise EmptyStackError.new("Empty Stack!") if stack.empty?
    self.register = stack.pop
  end

  def minilang_print
    puts register
  end
end

# Examples/Test Cases
# Minilang.new('PRINT').eval
# 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

# Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

# Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
