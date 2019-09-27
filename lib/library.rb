class Main
  def user_interface
    system('cls')
    puts 'Welcome to AutoLibrarian, please select an option'
    puts '1-Add a new Book'
    puts '2-Search for a book'
    puts '3-Exit'
    ops = gets.chomp.to_i
    system('cls')
    initial_options(ops)
  end
  def initial_options(ops)
    case ops
    when 1
      system('cls')
      puts "You will be required to input the Book's title, author, isbn number, and price, please have it on hand"
    when 2
      puts '1-Search for a book'
      puts '2-Search for a collection'
    when 3
      system('cls')
      puts 'Exiting the system...'
      system('cls')
    else
      puts 'Wrong command, please select 1, 2, or 3'
      ops = gets.chomp.to_i
      initial_options(ops)
    end
  
  end

end
Main.new.user_interface