require_relative 'spec_helper'

describe "HashSyntax" do
  it "has a version" do
    HashSyntax::Version::STRING.should be >= "1.0.0"
  end
end
