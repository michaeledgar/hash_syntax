module HashSyntax
  class Runner

    def run!
      options = gather_options
      validate_options(options)
      inputs = gather_inputs(options)
      inputs.each do |input, output|
        transformed_input = Transformer.transform(input, options)

        output.write(transformed_input)
        output.close
      end
    end

  private

    def gather_options
      Trollop::options do
        version HashSyntax::Version::STRING
        banner <<-EOF
hash_syntax #{HashSyntax::Version::STRING} by Michael Edgar (adgar@carboni.ca)

Automatically convert hash symbol syntaxes in your Ruby code.
EOF
        opt :"stdin", 'Convert from STDIN instead of a file', :short => '-s'
        opt :"to-18", 'Convert to Ruby 1.8 syntax (:key => value)', :short => '-o'
        opt :"to-19", 'Convert to Ruby 1.9 syntax (key: value)', :short => '-n'
      end
    end

    def validate_options(opts)
      Trollop::die 'Must specify --to-18 or --to-19' unless opts[:"to-18"] or opts[:"to-19"]
    end

    AUTO_SUBDIRS = %w(app ext features lib spec test)

    def gather_inputs(options)
      if options[:"stdin"]
        {STDIN.read => STDOUT}
      else
        gather_files
      end
    end

    def gather_files
      files = if ARGV.empty?
                AUTO_SUBDIRS.map { |dir| Dir["#{Dir.pwd}/#{dir}/**/*.rb"] }.flatten
              else
                ARGV
              end

      files.each_with_object({}) {|a, hash| hash[File.read(a)] = File.open(a, 'w')}
    end
  end
end
