require 'locality_sensitive_hash'

describe LocalitySensitiveHash do
  let(:lsh) {LocalitySensitiveHash.new 10}
  let(:input) {["some","string array"]}
  
    context "hashed?" do
      it "contains an entry if it has been added" do
        lsh.put input
        lsh.hashed?(input).should eq(true)
      end

      it "does not contain an entry if it has not been added" do
        lsh.hashed?(input).should eq(false)
      end
    end

    context "include?" do
      it "contains a key if it something has been hashed to it" do
        key = lsh.put input
        lsh.include?(key).should eq(true)
      end

      it "does not contain a key if it has not been added" do
        lsh.include?(1234).should eq(false)
      end
    end

  context "[]" do
    it "allows retrieval of bucket contents by passing in a valid key" do
      key = lsh.put input
      bucket = lsh[key]
      bucket.should eq([input])
    end
  end
  
  context "put" do
    it "allows multiple identical values to be added, creating two entries" do
      lsh.put input
      lsh.put input
      lsh.size.should eq(2)
    end
  end
  
  context "size" do
    it "verifies that an entry increases size by one" do
      lsh.size.should eq(0)
      lsh.put input
      lsh.size.should eq(1)
    end
    
    it "reports that two entries have been added" do
      lsh.put input
      lsh.put(input.clone << "x")
      lsh.size.should eq(2)
    end
  end
  
  context "neighbor_histogram" do
    context "provides a map of the number of buckets that a given value shares with the input string" do
      context "when there is a single hash function" do
       it "for the case where the map is empty" do
        histogram = lsh.neighbor_histogram input
        histogram.should be_empty
      end
      
      it "equals one entry with the input itself when only one value has been hashed" do
        lsh.put input
        histogram = lsh.neighbor_histogram input
        histogram[input].should eq(1)
      end

      it "equals the number of buckets when two values have been hashed to a one-bucket hash" do
        single_lsh = LocalitySensitiveHash(1)
        lsh.put input
        second_input = input << "x"
        lsh.put second_input
        histoxgram = lsh.neighbor_histogram input
        histogram[input].should eq({input => 1, second_input => 1})
      end
      end
      context "multiple hash functions" do
        
      end
    end
  end
  
  context "bucket_count" do
    it "reflects the number of buckets desired" do
      lsh = LocalitySensitiveHash.new 5
      lsh.bucket_count.should eq(5)
    end
  end
  
  context "keys" do
    it "provides all keys added to the hash" do
      key = lsh.put input
      lsh.keys.should eq([key])
    end
  end

  context "values" do
    it "provides all buckets of values added to the hash" do
      key = lsh.put input
      lsh.values.should eq([[input]])
    end
  end
end