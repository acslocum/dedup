require 'hash_function'

describe HashFunction do
  it "maps an array of strings to a single value" do
    function = HashFunction.new(3,10)
    input = ["Homer Simpson", "123 Fake St", "Springfield", "Mo"]
    function.hash(input).should_not eq(nil)
  end
  
  it "produces a hash constrained by the number of buckets" do
    function = HashFunction.new(3, 10)
    30.times do |i|
      (function.hash(i.to_s) < 10).should eq(true)
    end
  end
end