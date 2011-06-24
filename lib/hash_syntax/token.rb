module HashSyntax
  Token = Struct.new(:type, :body, :line, :col) do
    # Unpacks the token from Ripper and breaks it into its separate components.
    #
    # @param [Array<Array<Integer, Integer>, Symbol, String>] token the token
    #     from Ripper that we're wrapping
    def initialize(token)
      (self.line, self.col), self.type, self.body = token
    end
    
    def width
      body.size
    end
    
    def reg_desc
      if type == :on_op && body == '=>'
        'hashrocket'
      else
        type.to_s.sub(/^on_/, '')
      end
    end
  end
end