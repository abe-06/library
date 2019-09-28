require 'active_record'

class Book < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :author
  validates_presence_of :isbn
  validates_presence_of :price
  validates_presence_of :description
  validates_presence_of :genre

  validates_uniqueness_of :isbn
  validates_uniqueness_of :title, scope: :author
  
  validate :isbn_length

  def isbn_length
    len = isbn.to_s.length
    if len != 10 && len != 13
      errors.add(:isbn, "isbn must have either 10 or 13 numbers") 
    end
  end

  def create_new_book
    @book = Book.new
    puts "Title"
    @title = gets.chomp
    puts "Author"
    @author = gets.chomp
    puts "Isbn"
    @isbn = gets.chomp.to_i
    until isbn.to_s.length == 10 || isbn.to_s.length == 13
      puts "Isbn must have 10 or 13 numbers. Please try again"
      @isbn = gets.chomp.to_i
    end
    puts "Price"
    @price = gets.chomp.to_f
    puts "Description"
    @description = gets.chomp
  end

  def save_new_book
    create_new_book
    @book.title = @title
    @book.author = @author
    @book.isbn = @isbn
    @book.price = @price
    @book.description = @description
    @book.save
  end
end