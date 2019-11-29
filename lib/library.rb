class Library
  attr_reader :name, :books, :authors

  def initialize(name)
    @name = name
    @books = []
    @authors = []
  end

  def add_author(author)
    @authors << author
    author.books.each do |book|
      @books << book
    end
  end

  def publication_time_frame_for(author)
    pub_years = author.books.map do |book|
      book.publication_year
    end
    return {start: pub_years.min, end: pub_years.max}
  end
end
