Rows = 6
Columns = 7
Coin = ["heads" , "tails"]
LetterNum = {
  "A" => 0,
  "B" => 1,
  "C" => 2,
  "D" => 3,
  "E" => 4,
  "F" => 5,
  "G" => 6
}

Table = Array.new(Rows) { |i| Array.new(Columns) { |i| "0" }}
one_row = [1, 2, 3, 4, 5, 6, 7]
def nl()
  print("\n")
end

def empty_row()
  for space_row in 0..6 do
    print("¦\t\t") 
  end
  print("¦")
  nl()
end

def borders()
  for first_row in 0..55 do
    print("·-")
  end
  nl()
end

def table_row(index)
  Table[index].each { |num| print ("¦\t#{num}\t") }
    print("¦")
    nl()
end

def column_banner()
  borders()
  empty_row()
  LetterNum.each do |key,value|
    print("¦\t#{key}\t")
  end
  print("¦")
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

initialBoard()
