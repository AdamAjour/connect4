require 'rainbow/refinement'
require 'securerandom'
using Rainbow

Rows = 6
Columns = 7

Player1 = ""
Player2 = ""
Coin = ["", ""]
CurrentPlayer = ""

GameOver = false
LetterNum = {
  "A" => 0,
  "B" => 1,
  "C" => 2,
  "D" => 3,
  "E" => 4,
  "F" => 5,
  "G" => 6
}

RedPiece = "█".red
GreenPiece = "█".green
PieceArray = [RedPiece, GreenPiece]
EmptySlot = "█"
Index = 0


@flip = SecureRandom.random_number(2)


Table = Array.new(Rows) { |i| Array.new(Columns) { |i| "█" }}


def nl()
  print("\n")
end

def players_name()
  print("Enter your name first to choose heads\n")
  print("Player 1 enter your name: ")
  @Player1 = gets.chomp
  print("Player 2 enter your name: ")
  @Player2 = gets.chomp
  @Coin = [@Player1 , @Player2]
  @CurrentPlayer = @Coin[@flip]
end

def player_banner(current_player)
  borders()
  empty_row_no_columns()
  players_turn_banner(current_player)
  empty_row_no_columns()
end

def switch_player()
  @flip = (@flip.to_i + 1) % 2
  @Index = (@Index.to_i + 1) % 2
  @CurrentPlayer = @Coin[@flip]
end

def empty_row_no_columns()
  print("█")
  for space_row in 0..6 do
    print("\t\t") 
  end
  print("█")
  nl()
end

def players_turn_banner(current_player)

  for space_row in 0..2 do
    print("\t\t") 
  end
  print("#{current_player}'s Turn")

  nl()
end


def empty_row()
  for space_row in 0..6 do
    print("█\t\t") 
  end
  print("█")
  nl()
end

def borders()
  for first_row in 0..55 do
    print("■■")
  end
  print("■")
  nl()
end

def table_row(index)
  Table[index].each { |num| print ("█\t#{num}\t") }
    print("█")
    nl()
end

def column_banner()
  borders()
  empty_row()
  LetterNum.each do |key,value|
    print("█\t#{key}\t")
  end
  print("█")
  nl()
  empty_row()
end

def initialBoard() 

  column_banner()

  borders()
  for i in 0..5 do
    empty_row()
    empty_row()
    table_row(i)
    empty_row()
    empty_row()
  end

  borders()

end

def four_connected(piece)
  for j in 0..(Rows - 1) do
    for i in 0..(Columns - 4) do
      if Table[j][i] == piece && Table[j][i+1] == piece && Table[j][i+2] == piece && Table[j][i+3] == piece
        return true
      end
    end
  end

  for i in 0..(Columns - 1) do
    for j in 0..(Rows - 4) do
      if Table[j][i] == piece && Table[j+1][i] == piece && Table[j+2][i] == piece && Table[j+3][i] == piece
        return true
      end
    end
  end

  for i in 3..(Rows - 1) do
    for j in 0..(Columns - 4) do
      if Table[i][j] == piece && Table[i-1][j+1] == piece && Table[i-2][j+2] == piece && Table[i-3][j+3] == piece
        return true
      end
    end
  end

  for i in 0..(Rows - 4) do
    for j in 0..(Columns - 4) do
      if Table[i][j] == piece && Table[i+1][j+1] == piece && Table[i+2][j+2] == piece && Table[i+3][j+3] == piece
        return true
      end
    end
  end

  return false
end

def take_input()
  print("Insert in Column : ")
  letter = gets.chomp
  full_flag = check_column_full(letter.capitalize)
  while(full_flag) do
    print("Insert another Column : ")
    letter = gets.chomp
    full_flag = check_column_full(letter.capitalize)
  end
  insert_piece(PieceArray[@Index.to_i],letter.capitalize)
  @GameOver = four_connected(PieceArray[@Index.to_i])
  if (@GameOver)
    initialBoard()
    print("The winner is #{@CurrentPlayer}")
  end
end

def check_column_full(column)
  column_number = LetterNum[column]
  if Table[0][column_number] != EmptySlot
    return true
  end
  return false
end

def insert_piece(piece, column)
  column_number = LetterNum[column]
  full = false
  for slot in (Rows-1).downto(0) do
    if Table[slot][column_number] == EmptySlot
      Table[slot][column_number] = piece
      break
    end
  end
  if(Table[0][column_number] != EmptySlot)
    full = true
  end
  return full
end


players_name()
nl()
while(!@GameOver)
  player_banner(@CurrentPlayer)
  initialBoard()
  take_input()
  switch_player()
end