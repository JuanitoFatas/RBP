require 'prawn'

class Prawn::Document::Text

  module StyleParser
    extend self

    TAG_PATTERN = %r{(</?[ib]>)}

    def process(text)
      (style_tag? text) ? text.split(TAG_PATTERN).delete_if {|x| x.empty? } : text
    end

    def style_tag?(text)
      !!(text =~ TAG_PATTERN) ## !! is to conv match index to boolean.
    end
  end
end