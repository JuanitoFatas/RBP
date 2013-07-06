require './prawn'
require 'test/unit'
require '../test_unit_extensions'

class TestInlineStyleParsing < Test::Unit::TestCase

  def setup
    @parser = Prawn::Document::Text::StyleParser
  end

  must "simply return the string if styles are not found" do

    assert_equal "Hello World", @parser.process("Hello World")
  end

  must "parse italic tags" do

    assert_equal ["Hello ", "<i>", "Fine", "</i>", " World"],
                  @parser.process("Hello <i>Fine</i> World")
  end

  must "parse bold tags" do

    assert_equal ["Some very ", "<b>", "bold text", "</b>"],
                  @parser.process("Some very <b>bold text</b>")
  end

  must "parse mixed italic and bold tags" do

    assert_equal ["Hello ", "<i>", "Fine ", "<b>", "World", "</b>", "</i>"],
                  @parser.process("Hello <i>Fine <b>World</b></i>")
  end

  must "not split out other tags than <i>, <b>, </i>, </b>" do

    assert_equal ["Hello <ruby>Ch", "<b>", "arl", "</b>", "ie</ruby>"],
                  @parser.process("Hello <ruby>Ch<b>arl</b>ie</ruby>")
  end

  must "be able to check whether a string needs to be parsed" do

    assert ! @parser.style_tag?("Hello World")
    assert   @parser.style_tag?("Hello <i>Fine</i> World")
  end

end