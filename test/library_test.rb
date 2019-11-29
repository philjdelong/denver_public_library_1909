require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'
require './lib/author'
require './lib/library'

class LibraryTest < Minitest::Test

  def setup
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  def test_it_exists
    assert_instance_of Library, @dpl
  end

  def test_it_initializes_with_name_books_authors
    assert_equal "Denver Public Library", @dpl.name
    assert_equal Array, @dpl.books.class
    assert_equal Array, @dpl.authors.class
  end

  def test_it_can_add_authors
    assert_equal [], @dpl.authors
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    assert_equal [@charlotte_bronte, @harper_lee], @dpl.authors
  end

  def test_it_can_tell_us_all_books
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    assert_equal [@jane_eyre, @professor, @villette, @mockingbird], @dpl.books
  end

  def test_it_can_tell_us_publication_time_frame_for_author
    expected_charlotte = {:start=>"1847", :end=>"1857"}
    expected_harper = {:start=>"1960", :end=>"1960"}
    assert_equal expected_charlotte, @dpl.publication_time_frame_for(@charlotte_bronte)
    assert_equal expected_harper, @dpl.publication_time_frame_for(@harper_lee)
  end
end
