class Library
  attr_reader :name,
              :authors,
              :checked_out_books

  def initialize(name)
    @name = name
    @authors = []
    @checked_out_books = []
    @popularity = Hash.new(0)
  end

  def add_author(author)
    @authors << author
  end

  def books_by_author
    books_by_author = {}
    @authors.each do |author|
      book_titles = author.books.map do |book|
        book.title
      end
      books_by_author[author.name] = book_titles
    end
    books_by_author
  end

  def books
    @authors.map do |author|
      author.books
    end.flatten
  end

  def publication_time_frame_for(author)
    first_book = author.books.min_by do |book|
      book.publication_year
    end
    last_book = author.books.max_by do |book|
      book.publication_year
    end
    {
      start: first_book.publication_year,
    end: last_book.publication_year
    }
  end

  def checkout(book)
    if !@checked_out_books.include?(book) && books.include?(book)
      @checked_out_books << book
      @popularity[book] += 1
      return true
    end
    return false
  end

  def return(book)
    @checked_out_books.delete(book)
  end

  def most_popular_book
    @popularity.max_by do |book, times_checked_out|
      times_checked_out
    end.first
  end
end
