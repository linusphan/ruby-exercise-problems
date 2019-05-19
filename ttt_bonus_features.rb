FIRST_TO_MOVE = "choose" # valid options: "player", "computer", or "choose"
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
end

INITIAL_MARKER = ' '

case FIRST_TO_MOVE
when 'player'
  PLAYER_MARKER = 'X'
  COMPUTER_MARKER = 'O'
when 'computer'
  PLAYER_MARKER = 'O'
  COMPUTER_MARKER = 'X'
end

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'cls'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts "First to 5 wins the game."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{joinor(empty_squares(brd))}"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |k, v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  end
end

def computer_places_piece!(brd)
  square = nil

  # offense first
  WINNING_LINES.each do |line|
    square = find_at_risk_square(line, brd, COMPUTER_MARKER)
    break if square
  end

  # defense
  if !square
    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, brd, PLAYER_MARKER)
      break if square
    end
  end

  # pick square #5 if available
  if !square
    if brd[5] == INITIAL_MARKER
      square = 5
    end
  end

  # just pick a square
  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def display_score(player, computer)
  puts "=> Player score: #{player}, Computer score: #{computer}"
end

def place_piece!(brd, current_player)
  case current_player
  when 'player' then player_places_piece!(brd)
  when 'computer' then computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  case current_player
  when 'player'
    'computer'
  else
    'player'
  end
end

loop do
  player_score = 0
  computer_score = 0

  if FIRST_TO_MOVE == 'choose'
    loop do
      prompt "Who goes first? ('player' or 'computer')"
      answer = gets.chomp
      if answer == 'player'
        PLAYER_MARKER = 'X'
        COMPUTER_MARKER = 'O'
        break
      elsif answer == 'computer'
        PLAYER_MARKER = 'O'
        COMPUTER_MARKER = 'X'
        break
      end
      prompt "That is not a valid option. Please try again."
    end
  end

  while player_score < 5 && computer_score < 5
    board = initialize_board
    case PLAYER_MARKER
    when 'X' then current_player = 'player' # player is first to go
    when 'O' then current_player = 'computer' # computer is first to go
    end

    # gameplay loop
    loop do
      display_board(board)
      display_score(player_score, computer_score)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      case detect_winner(board)
      when 'Player' then player_score += 1
      when 'Computer' then computer_score += 1
      end
    end
  end
  display_score(player_score, computer_score)
  prompt "#{detect_winner(board)} is the grand winner!"
  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good bye!"
