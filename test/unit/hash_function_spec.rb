require 'hash_function'

describe HashFunction do
  it "maps an array of strings to a single value" do
    function = HashFunction.new
    input = ["Homer Simpson", "123 Fake St", "Springfield", "Mo"]
    function.hash(input).should_not eq(nil)
  end
end