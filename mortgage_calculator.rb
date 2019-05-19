def integer?(input)
  input.match(/^\d+$/)
end

def float?(input)
  input.match(/\d/) && input.match(/^\d*\.?\d*$/)
end

def valid_number(input)
  integer?(input) || float?(input)
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

# starting program
welcome_msg = <<-MSG
Hello! This is the mortgage / car loan calculator.
Use this program to calculate your monthly payment.
Calculations are based on the following formula:

m = p * (j / (1 - (1 + j)**(-n)))

Now, let's begin!
MSG

prompt(welcome_msg)
Kernel.puts()

# big loop
loop do
  # getting the loan amount from user
  prompt('What is your loan amount? (valid numbers only)')
  amount = ''
  loop do
    amount = Kernel.gets().chomp()
    if valid_number(amount)
      amount = amount.to_f()
      break
    end
    prompt('That is not a valid loan amount. Please try again.')
  end

  # getting the APR from the user
  prompt('What is your loan APR? (input the percentage number)')
  apr = ''
  month_interest = ''
  loop do
    apr = Kernel.gets().chomp()
    if valid_number(apr)
      month_interest = ((apr.to_f() / 12) / 100)
      break
    end
    prompt('That is not a valid APR. Please try again.')
  end

  # GET loan_duration in years
  prompt('What is the loan duration in years?')
  year_dur = ''
  month_dur = ''
  loop do
    year_dur = Kernel.gets().chomp()
    if valid_number(year_dur)
      month_dur = year_dur.to_f() * 12
      break
    end
    prompt('That is not a valid loan duration. Please try again.')
  end

  month_pay = amount * (month_interest / (1 - (1 + month_interest)**-month_dur))

  prompt("Your monthly payment is $#{Kernel.format('%.2f', month_pay)}")

  prompt('Would you like to calculate again? (Y)')
  answer = Kernel.gets().chomp()
  break unless answer.downcase.start_with?('y')
end

Kernel.puts('Thanks for using the mortgage / car loan calculator. Good-bye!')
