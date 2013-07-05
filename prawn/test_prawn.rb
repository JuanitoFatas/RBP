require './prawn'
require 'test/unit'
require './test_unit_extensions'


class TestInlineStyleParsing < Test::Unit::TestCase

  must "simply return the string if styles are not found" do
    @pdf = Prawn::Document.new
    assert_equal "Hello World", @pdf.parse_inline_styles("Hello World")
  end

  must "parse italic tags" do
    @pdf = Prawn::Document.new
    assert_equal ["Hello ", "<i>", "Fine", "</i>", " World"],
                  @pdf.parse_inline_styles("Hello <i>Fine</i> World")
  end

  must "parse bold tags" do
    @pdf = Prawn::Document.new
    assert_equal ["Some very ", "<b>", "bold text", "</b>"],
                  @pdf.parse_inline_styles("Some very <b>bold text</b>")
  end

  must "parse mixed italic and bold tags" do
    @pdf = Prawn::Document.new
    assert_equal ["Hello ", "<i>", "Fine ", "<b>", "World", "</b>", "</i>"],
                  @pdf.parse_inline_styles("Hello <i>Fine <b>World</b></i>")
  end

end