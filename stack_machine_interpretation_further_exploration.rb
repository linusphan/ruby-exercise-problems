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

  def eval(format_arg='')
    program = format(@program, format_arg)
    begin
      program.split.each do |token|
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

# Examples / Test Cases
#-------------------------------

# # Centigrade to fahrenheit minilang program:
# CENTIGRADE_TO_FAHRENHEIT =
#   '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# # 212
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# # 32
# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# # -40

# minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
# minilang.eval(degrees_c: 100)
# # 212
# minilang.eval(degrees_c: 0)
# # 32
# minilang.eval(degrees_c: -40)
# # -40

# # Fahrenheit to centigrade minilang program:
# FAHRENHEIT_TO_CENTIGRADE =
#   '9 PUSH 32 PUSH %<degrees_f>d SUB PUSH 5 MULT DIV PRINT'
# minilang = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)
# minilang.eval(degrees_f: 212)
# # 100
# minilang.eval(degrees_f: 32)
# # 0
# minilang.eval(degrees_f: -40)
# # -40

# MPH_TO_KPH =
#   '3 PUSH 5 PUSH %<miles_per_hour>d MULT DIV PRINT' # an approximation
# minilang = Minilang.new(MPH_TO_KPH)
# minilang.eval(miles_per_hour: 70)
# # 116

# AREA_OF_RECTANGLE =
#   '%<side_1>d PUSH %<side_2>d MULT PRINT'
# minilang = Minilang.new(AREA_OF_RECTANGLE)
# minilang.eval(side_1: 10, side_2: 20)
# # 200