require 'prawn'
require 'test/unit'
require 'active_support/all'
require './test_unit_extensions'

class Prawn::Document
  def parse_inline_styles(text)
    sc = StringScanner.new(text)
    output = []
    last_pos = 0
    loop do
      if sc.scan_until(/<\/?[ib]>/)
        pre = sc.pre_match[last_pos..-1]
        output << pre unless pre.empty?
        output << sc.matched
        last_pos = sc.pos
      else
        output << sc.rest if sc.rest?
        break output
      end
    end

    output.length == 1 ? output.first : output
  end
end

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

