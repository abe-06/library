require_relative '../db/connection'
require_relative './models/book'
require 'active_record'

class Main

  def user_interface
    system('cls')
    puts 'Welcome to DotAlexandria, please select an option'
    puts '1-Add a new Book'
    puts '2-Request Information about a book'
    puts '3-Delete a book'
    puts '4-Exit'
    ops = gets.chomp.to_i
    initial_options(ops)
  end

  def initial_options(ops)
    case ops
    when 1
      system('cls')
      puts "You will be required to input the Book's title, author, genre, isbn number, and price, please have it on hand"
      Book.create_book
      puts "Hit any key to continue"
      gets.chomp
      user_interface
    when 2
      system('cls')
      puts '1-Search for a book'
      puts '2-Search for a collection'
      puts '3-Back'
      ops = gets.chomp.to_i
      case ops
      when 1
        system('cls')
        puts '1-Search by title'
        puts '2-Search by isbn'
        puts '3-Back'
        ops = gets.chomp.to_i
        until ops == 1 || ops == 2 || ops == 3
          puts 'Wrong option, please select 1 for title, 2 for isbn, or 3 to go back'
          ops = gets.chomp.to_i
        end
        if ops == 1
          Book.search_by_title
          user_interface
        elsif ops == 2
          Book.search_by_isbn
          user_interface
        elsif ops == 3
          user_interface
        end
        system('cls')
      when 2
        system('cls')
        Book.search_collection
        user_interface
      when 3
        user_interface
      end
    when 3
      system('cls')
      puts "Please enter the book's id number or its isbn code"
      puts '1-For id'
      puts '2-For isbn'
      puts '3-To go back'
      ops = gets.chomp.to_i
      until ops == 1 || ops == 2 || ops == 3
        puts 'Wrong option, please select 1 for id, 2 for isbn, or 3 to go back'
        ops = gets.chomp.to_i
      end
      if ops == 1
        Book.delete_book_by_id
        user_interface
      elsif ops == 2
        Book.delete_book_by_isbn
        user_interface
      elsif ops == 3
        user_interface
      end
      system('cls')
    when 4
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