require 'active_record'

class Book < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :isbn
  validates_presence_of :price
  validates_presence_of :description
  validates_presence_of :genre
  validates_presence_of :collection
  validates_uniqueness_of :collection, scope: [:author, :title]
  validates_uniqueness_of :isbn
  validates_uniqueness_of :title, scope: :author
  
  validate :isbn_length

  class << self
    
    def show_book(book)
      puts "Book:"
      puts ""
      puts "id: #{book.id}"
      puts "Title: #{book.title}"
      puts "Author: #{book.author}"
      puts "Collection: #{book.collection}"
      puts "Isbn: #{book.isbn}"
      puts "Description: #{book.description}"
      puts ""
    end
    
    def search_by_title
      puts "Enter book's title"
      title = gets.chomp
      if Book.exists?(:title => title)
        book = Book.find_by title: title
        show_book(book)
        puts " "
        puts "Hit any key to continue"
        gets.chomp
      else
        puts " "
        puts "There is not a book with that title in the records, please try again"
        search_by_title
      end
    end

    def search_by_isbn
      puts "Enter book's isbn number"
      isbn = gets.chomp
      if Book.exists?(:isbn => isbn)
        book = Book.find_by isbn: isbn
        show_book(book)
        puts " "
        puts "Hit any key to continue"
        gets.chomp
      else
        puts " "
        puts "There is not a book with that isbn number in the records, please try again"
        search_by_isbn
      end
    end

    def create_book
      book = Book.new
      puts "Title"
      book.title = gets.chomp
      puts "Author"
      book.author = gets.chomp
      puts "Genre"
      book.genre = gets.chomp
      puts "Collection"
      book.collection = gets.chomp
      puts "Isbn"
      isbn = gets.chomp.to_i
      until isbn.to_s.length == 10 || isbn.to_s.length == 13
        puts "Isbn must have 10 or 13 numbers. Please try again"
        isbn = gets.chomp.to_i
      end
      book.isbn = isbn
      puts "Price"
      book.price = gets.chomp.to_f
      puts "Description"
      book.description = gets.chomp
      if book.save
        puts "Book successfully saved to the database"
      else
        puts "An error has occurred, please try again"
      end
    end

    def delete_book_by_id
      puts "Enter id number"
      id = gets.chomp.to_i
      if Book.exists?(:id => id)
        book = Book.find_by id: id
        show_book(book)
        puts "Is this the book you want to delete? (Y/N)"
        ops = gets.chomp
        until ops == 'Y' || ops == 'y' || ops == 'N' || ops == 'n'
          puts "Wrong option please typr Y for yes or N for no"
          ops = gets.chomp
        end
        if ops == 'Y' || ops == 'y'
          book.destroy
        elsif ops == 'N' || ops == 'n'
          delete_book_by_id
        end
        gets.chomp
      else
        puts " "
        puts "There is not a book with that id in the records, please try again"
        delete_book_by_id
      end
    end

    def delete_book_by_isbn
      puts "Enter isbn number"
      isbn = gets.chomp.to_i
      if Book.exists?(:isbn => isbn)
        book = Book.find_by isbn: isbn
        show_book(book)
        puts "Is this the book you want to delete? (Y/N)"
        ops = gets.chomp
        until ops == 'Y' || ops == 'y' || ops == 'N' || ops == 'n'
          puts "Wrong option please typr Y for yes or N for no"
          ops = gets.chomp
        end
        if ops == 'Y' || ops == 'y'
          book.destroy
        elsif ops == 'N' || ops == 'n'
          delete_book_by_isbn
        end
        gets.chomp
      else
        puts " "
        puts "There is not a book with that isbn in the records, please try again"
        delete_book_by_isbn
      end
    end
    def search_collection
      books = Book.all
      collections = books.group(:author, :collection)
      i = 1
      collections.each do |x|
        puts "#{i}-Author: #{x.author}"
        puts "     Collection: #{x.collection}"
        i += 1
      end
      puts ""
      puts "Type an author and then the collection of said author"
      puts "Author:"
      auth = gets.chomp
      puts "Collection:"
      col = gets.chomp
      books = books.where(["author = ? and collection = ?", "#{auth}", "#{col}"])
      if Book.exists?(:author => auth, :collection => col)
        books.each do |book|
          show_book(book)
          puts ""
          gets.chomp
        end
      else
        puts " "
        puts "There was an error, either author or collection was mispelled, please try again. Hit any key to continue"
        gets.chomp
        system('cls')
        search_collection
      end
    end

  end

  def isbn_length
    len = isbn.to_s.length
    if len != 10 && len != 13
      errors.add(:isbn, "isbn must have either 10 or 13 numbers") 
    end
  end

end