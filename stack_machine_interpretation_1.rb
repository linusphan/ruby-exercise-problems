class MinilangError < StandardError; end
class InvalidTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  COMMANDS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
    @stack = []
    @register = 0
  end

  def eval
    begin
      @program.split.each do |token|
        if token =~ /\A[+-]?\d+\z/ then @register = token.to_i
        elsif COMMANDS.include?(token) then send token.downcase
        else
          raise InvalidTokenError.new("Invalid Token: #{token}")
        end
      end
    rescue MinilangError => e
      puts e.message
    end
  end

  private

  def push
    @stack.push(@register)
  end

  def add
    @register += pop
  end

  
  def sub
    @register -= pop
  end
  
  def mult
    @register *= pop
  end
  
  def div
    @register /= pop
  end
  
  def mod
    @register %= pop
  end
  
  def pop
    raise EmptyStackError.new('Empty stack!') if @stack.empty?
    topmost_item = @stack.pop
    @register = topmost_item
    topmost_item
  end
  
  def print
    puts @register
  end
end

# Examples / test cases
Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
