require 'faker'
require_relative '../../lib/models/book'

class BookFiller
    class << self
        def create_books
            100.times do
                title = Faker::Book.title
                author = Faker::Book.author
                genre = Faker::Book.genre
                description = Faker::Quote.matz
                isbn = rand(1000000000000..9999999999999)
                price = rand(9.99..999.99)
                Book.create(title: title, author: author, genre: genre, isbn: isbn, price: price, description: description)
            end
        end
    end
end

BookFiller.create_books
