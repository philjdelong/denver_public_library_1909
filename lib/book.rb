class Book
  attr_reader :author_first_name, :author_last_name, :title, :publication_date

  def initialize(book_info)
    @author_first_name = book_info[:author_first_name]
    @author_last_name = book_info[:author_last_name]
    @title = book_info[:title]
    @publication_date = book_info[:publication_date]
  end
end
