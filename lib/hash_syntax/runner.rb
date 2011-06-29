module HashSyntax
  class Runner
    
    def run!
      options = gather_options
      validate_options(options)
      files = gather_files
      files.each do |name|
        transformed_file = Transformer.transform(File.read(name), options)
        File.open(name, 'w') { |fp| fp.write(transformed_file) }
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
        opt :"to-18", 'Convert to Ruby 1.8 syntax (:key => value)', :short => '-o'
        opt :"to-19", 'Convert to Ruby 1.9 syntax (key: value)', :short => '-n'
      end
    end
    
    def validate_options(opts)
      Trollop::die 'Must specify --to-18 or --to-19' unless opts[:"to-18"] or opts[:"to-19"]
    end
    
    AUTO_SUBDIRS = %w(app ext features lib spec test)
    
    def gather_files
      if ARGV.empty?
        AUTO_SUBDIRS.map { |dir| Dir["#{Dir.pwd}/#{dir}/**/*.rb"] }.flatten
      else
        ARGV
      end
    end
  end
end