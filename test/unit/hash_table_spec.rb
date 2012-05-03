require 'hash_table'

describe HashTable do
  let(:hash) {HashTable.new(5, 5)}
  let(:input) {["some","string array"]}
  let(:input_2) {["some","string array", "2"]}
  
  context "hashed?" do
    it "contains an entry if it has been added" do
      hash.put input
      hash.hashed?(input).should eq(true)
    end

    it "does not contain an entry if it has not been added" do
      hash.hashed?(input).should eq(false)
    end
  end

  context "include?" do
    it "contains a key if it something has been hashed to it" do
      key = hash.put input
      hash.include?(key).should eq(true)
    end

    it "does not contain a key if it has not been added" do
      hash.include?(1234).should eq(false)
    end
  end
  
  context "[]" do
    it "allows retrieval of bucket contents by passing in a valid key" do
      key = hash.put input
      bucket = hash[key]
      bucket.should eq([input])
    end
  end
  
  context "put" do
    it "allows multiple identical values to be added, creating two entries" do
      hash.put input
      hash.put input
      hash.size.should eq(2)
    end
  end
  
  context "size" do
    it "verifies that an entry increases size by one" do
      hash.size.should eq(0)
      hash.put input
      hash.size.should eq(1)
    end
    
    it "reports that two entries have been added" do
      hash.put input
      hash.put(input_2)
      hash.size.should eq(2)
    end
  end
  
  context "bucket_for" do
    it "returns the bucket containing an entry" do
      hash.put input
      hash.bucket_for(input).should eq([input])
    end
    
    it "returns nil if the hash hasn't seen the input yet" do
      hash.bucket_for(input).should eq(nil)
    end
  end
  
end