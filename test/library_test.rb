require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'
require './lib/author'
require './lib/library'

class LibraryTest < Minitest::Test

  def setup
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
  end

  def test_it_exists
    assert_instance_of Library, @dpl
  end

  def test_it_initializes_with_name_books_authors
    assert_equal "Denver Public Library", @dpl.name
    assert_equal Array, @dpl.books.class
    assert_equal Array, @dpl.authors.class
  end
end
