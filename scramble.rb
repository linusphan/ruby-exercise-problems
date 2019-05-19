require 'minitest/autorun'

class Session7TestSecondProblem < Minitest::Test
  # Different solutions:
  #
  def scramble(string_of_characters, target_string)
    characters = string_of_characters.chars
    permutations = characters.permutation(target_string.size)
    permutations.map(&:join).include? target_string
  end

  def scramble(str1, str2)
    str2.each_char do |char|
      return false if str2.count(char) > str1.count(char)
    end

    true
  end

  def scramble(str1, str2)
    str1_array = str1.chars
    substring = str2.chars.inject('') do |string, letter|
      idx = str1_array.index(letter)
      string += str1_array.delete_at(idx) if str1_array.include?(letter)
      string
    end
    substring == str2
  end

  def test_1
    assert(scramble('rkqodlw','world'))
  end

  def test_2
    assert(scramble('cedewaraaossoqqyt','codewars'))
  end

  def test_3
    refute(scramble('katas','steak'))
  end

  def test_4
    assert(scramble('scriptjava','javascript'))
  end

  def test_5
    refute(scramble('scriptingjava','javascripts'))
  end

  def test_6
    refute(scramble('abceflxyztghlte','telltale'))
  end

  def test_7
    assert(scramble('abcleflxyztghlte','telltale'))
  end

  def test_simple_match_cases
    assert(scramble('rkqodlw','world'))
    assert(scramble('kataes', 'steak'))
  end

  def test_simple_mismatch_cases
    refute(scramble('katas','steak'))
    refute(scramble('', 'string'))
  end
end