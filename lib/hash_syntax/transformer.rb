module HashSyntax
  module Transformer
    MATCH_18 = ObjectRegex.new('symbeg (ident | kw) sp? hashrocket')
    MATCH_19 = ObjectRegex.new('label')
    
    extend self
    
    def transform(input_text, options)
      tokens = extract_tokens(input_text)
      if options[:to_18]
        transform_to_18(input_text, tokens, options)
      elsif options[:to_19]
        transform_to_19(input_text, tokens, options)
      else
        raise ArgumentError.new('Either :to_18 or :to_19 must be specified.')
      end
    end
    
  private
    
    def extract_tokens(text)
      swizzle_parser_flags do
        Ripper.lex(text).map { |token| Token.new(token) }
      end
    end
    
    def swizzle_parser_flags
      old_w = $-w
      old_v = $-v
      old_d = $-d
      $-w = $-v = $-d = false
      yield
    ensure
      $-w = old_w
      $-v = old_v
      $-d = old_d
    end
    
    def transform_to_18(input_text, tokens, options)
      lines = input_text.lines.to_a  # eagerly expand lines
      matches = MATCH_19.all_matches(tokens)
      line_adjustments = Hash.new(0)
      matches.each do |label_list|
        label = label_list.first
        lines[label.line - 1][label.col + line_adjustments[label.line],label.width] = ":#{label.body[0..-2]} =>"
        line_adjustments[label.line] += 3  # " =>" is inserted and is 3 chars
      end
      lines.join
    end
    
    def transform_to_19(input_text, tokens, options)
      lines = input_text.lines.to_a  # eagerly expand lines
      matches = MATCH_18.all_matches(tokens)
      line_adjustments = Hash.new(0)
      matches.each do |match_tokens|
        symbeg, ident, *spacing_and_comments, rocket = match_tokens
        lines[symbeg.line - 1][symbeg.col + line_adjustments[symbeg.line],1] = ''
        lines[ident.line - 1].insert(ident.col + line_adjustments[ident.line] + ident.width - 1, ':')
        lines[rocket.line - 1][rocket.col + line_adjustments[rocket.line],2] = ''
        if spacing_and_comments.last != nil && spacing_and_comments.last.type == :on_sp
          lines[rocket.line - 1][rocket.col + line_adjustments[rocket.line] - 1,1] = ''
          line_adjustments[rocket.line] -= 3  # chomped " =>"
        else
          line_adjustments[rocket.line] -= 2  # only chomped the "=>"
        end
      end
      lines.join
    end
  end
end