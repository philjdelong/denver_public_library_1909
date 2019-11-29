class Author
  attr_reader :first_name, :last_name, :books

  def initialize(author_info)
    @first_name = author_info[:first_name]
    @last_name = author_info[:last_name]
    @books = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def write(title, publication_date)
    book_info = {
      first_name: @first_name,
      last_name: @last_name,
      title: title,
      publication_date: publication_date
    }
    @books << book = Book.new(book_info)
    return book
  end
end
