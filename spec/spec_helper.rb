$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'hash_syntax'
require 'rspec'
require 'rspec/autorun'

RSpec::Matchers.define :transform_to do |output, target|
  match do |input|
    @result = HashSyntax::Transformer.transform(input, target => true)
    @result == output
  end
  
  failure_message_for_should do |input|
    "expected '#{input}' to correct to #{output}, not #{@result}"
  end
  
  diffable
end

RSpec.configure do |config|
  
end
