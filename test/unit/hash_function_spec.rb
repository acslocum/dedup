require 'hash_function'

describe HashFunction do
  context "hashing" do
    it "maps an array of strings to a single value" do
      function = HashFunction.new(3)
      input = ["Homer Simpson", "123 Fake St", "Springfield", "Mo"]
      function.hash(input).should_not eq(nil)
    end
  
    it "generates a deterministic key based on the seed" do
      input = ["Homer"]
      key = HashFunction.new(1).hash(input)
      key2 = HashFunction.new(1).hash(input)    
      key.should eq(key2)
    
      key3 = HashFunction.new(255).hash(input)
      key4 = HashFunction.new(255).hash(input)
      key3.should eq(key4)
    end
  
    it "does not blow up when hashing a fairly large input" do
      input = ["Homer SimpsonHomer SimpsonHomer SimpsonHomer Simpson", "123 Fake St", "Springfield", "Mo"]
      HashFunction.new(255).hash(input).should_not eq(nil)
    end
  end
  
  context "generating a hash array" do
    it "makes an array of integers" do
      function = HashFunction.new(1).function
      function.size.should eq(128)
    end
  end
  
end