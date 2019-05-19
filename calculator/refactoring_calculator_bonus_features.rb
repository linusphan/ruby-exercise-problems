require 'yaml'
LANGUAGE = 'es'

# Bonus Features
# 1. integer validation - allow input of '0', even '00'
# 2. number validation - account for inputs that include decimals
# 3. operation_to_message method adjustment
# 4. extracting messages in the program to a configuration file
# 5. internationalize the messages in the calculator

MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(key, lang='en')
  MESSAGES[lang][key]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def integer?(input)
  input.match(/^\d+$/)
end

def float?(input)
  input.match(/\d/) && input.match(/^\d*\.?\d*$/)
end

def number?(input)
  # verify that only valid numbers--integers or floats are entered
  integer?(input) || float?(input)
end

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

prompt('welcome')

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt('valid_name')
  else
    break
  end
end

Kernel.puts("=> Hi #{name}!")

loop do # main loop
  number1 = ''
  loop do
    prompt('first_num')
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt('invalid_num')
    end
  end

  number2 = ''
  loop do
    prompt('second_num')
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt('invalid_num')
    end
  end

  prompt('operator_prompt')

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['operator_error'])
    end
  end

  Kernel.puts("=> #{operation_to_message(operator)} the two numbers...")

  result = case operator
           when '1'
             number1.to_f() + number2.to_f()
           when '2'
             number1.to_f() - number2.to_f()
           when '3'
             number1.to_f() * number2.to_f()
           when '4'
             number1.to_f() / number2.to_f()
           end

  Kernel.puts("=> The result is #{result}")

  prompt('calculate_again')
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

prompt('exiting')
