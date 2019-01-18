require 'minitest/autorun'
require 'minitest/pride'
require './lib/library'
require './lib/book'
require './lib/author'

class LibraryTest < Minitest::Test
  def test_it_exists
    dpl = Library.new("Denver Public Library")

    assert_instance_of Library, dpl
  end

  def test_it_has_a_name
    dpl = Library.new("Denver Public Library")

    assert_equal "Denver Public Library", dpl.name
  end

  def test_it_starts_with_no_authors
    dpl = Library.new("Denver Public Library")

    assert_equal [], dpl.authors
  end

  def test_it_can_add_authors
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal [charlotte_bronte, harper_lee], dpl.authors
  end

  def test_it_can_get_a_list_of_books
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    assert_equal [jane_eyre, professor, villette, mockingbird], dpl.books
  end

  def test_it_can_get_the_time_frame_of_an_authors_publications
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    expected = {start: "1847", end: "1857"}
    assert_equal expected, dpl.publication_time_frame_for(charlotte_bronte)

    expected = {start: "1960", end: "1960"}
    assert_equal expected, dpl.publication_time_frame_for(harper_lee)
  end

  # def test_it_can_list_books_by_author
  #   dpl = Library.new("Denver Public Library")
  #
  #   charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
  #   jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
  #   villette = charlotte_bronte.write("Villette", "1853")
  #
  #   harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
  #   mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  #
  #   dpl.add_author(charlotte_bronte)
  #   dpl.add_author(harper_lee)
  #
  #   expected = {
  #     "Charlotte Bronte" => ["Jane Eyre", "Villette"],
  #     "Harper Lee" => ["To Kill a Mockingbird"]
  #   }
  #
  #   assert_equal expected, dpl.books_by_author
  # end

  def test_it_can_checkout_a_book
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    dpl.add_author(charlotte_bronte)

    assert_equal true, dpl.checkout(jane_eyre)
    assert_equal [jane_eyre], dpl.checked_out_books
  end

  def test_it_cant_checkout_a_book_that_the_library_doesnt_have
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    assert_equal false, dpl.checkout(jane_eyre)
    assert_equal [], dpl.checked_out_books
  end

  def test_it_cannot_check_out_a_book_twice
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    dpl.add_author(charlotte_bronte)

    dpl.checkout(jane_eyre)
    assert_equal false, dpl.checkout(jane_eyre)
    assert_equal [jane_eyre], dpl.checked_out_books
  end

  def test_it_can_return_a_book
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    dpl.add_author(charlotte_bronte)

    dpl.checkout(jane_eyre)
    dpl.return(jane_eyre)

    assert_equal [], dpl.checked_out_books
  end

  def test_it_can_find_the_book_that_has_been_checked_out_the_most_times
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    dpl.checkout(jane_eyre)
    dpl.return(jane_eyre)
    dpl.checkout(jane_eyre)
    dpl.checkout(villette)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)

    assert_equal mockingbird, dpl.most_popular_book
  end
end
