require 'faker'
require_relative '/Users/Abe/Documents/Library/lib/books/book'

class BookFiller

    def create_book
        100.times do
            title = Faker::Book.title
            author = Faker::Book.author
            description = Faker::Quote.matz
            isbn = rand(1000000000000..9999999999999)
            price = rand(9.99..999.99)
            Book.create(title: title, author: author, isbn: isbn, price: price, description: description)
        end
    end
end
BookFiller.new.create_book
