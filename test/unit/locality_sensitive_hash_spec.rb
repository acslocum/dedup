require 'locality_sensitive_hash'

describe LocalitySensitiveHash do
  let(:lsh) {LocalitySensitiveHash.new :bucket_count => 10}
  let(:input) {["some","string array"]}
  let(:input_2) {["some","string array", "2"]}
  
  context "hashed?" do
    it "contains an entry if it has been added" do
      lsh.put input
      lsh.hashed?(input).should eq(true)
    end

    it "does not contain an entry if it has not been added" do
      lsh.hashed?(input).should eq(false)
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
      lsh.put(input_2)
      lsh.size.should eq(2)
    end
  end
  
  context "neighbor_histogram" do
    context "provides a map of the number of buckets that a given value shares with the input string" do
      context "when there is a single hash function" do
        it "for the case where the map is empty" do
          histogram = lsh.neighbor_histogram input
          histogram.should eq({})
          histogram.should be_empty
        end
      
        it "equals one entry with the input itself when only one value has been hashed" do
          lsh.put input
          histogram = lsh.neighbor_histogram input
          histogram[input].should eq(1)
        end

        it "equals the number of buckets when two values have been hashed to a one-bucket hash" do
          single_lsh = LocalitySensitiveHash.new({:bucket_count => 1})
          single_lsh.put input
          second_input = input_2
          single_lsh.put second_input
          histogram = single_lsh.neighbor_histogram input
          histogram.should eq({input => 1, second_input => 1})
        end
        
        it "excludes values that are not in the same bucket" do
          dual_lsh = LocalitySensitiveHash.new({:bucket_count => 2})
          dual_lsh.put ["1"]
          dual_lsh.put ["2"]
          dual_lsh.put ["3"]
          dual_lsh.put ["3"]
          dual_lsh.put ["4"]
          histogram = dual_lsh.neighbor_histogram ["1"]
          histogram.should eq({["1"] => 1, ["3"] => 2})
          dual_lsh.size.should eq(5)
        end
      end
      context "multiple hash functions" do
        it "counts a single entry as many times as it shows up across all hashes" do
          multiple_lsh = LocalitySensitiveHash.new({:bucket_count => 1, :hash_function_count => 5})
          multiple_lsh.put input
          histogram = multiple_lsh.neighbor_histogram input
          histogram[input].should eq(5)
        end
      end
    end
  end
  
  context "bucket_count" do
    it "reflects the number of buckets desired" do
      lsh = LocalitySensitiveHash.new :bucket_count => 5
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
  
  context "hash" do
    it "produces a hash constrained by the number of buckets" do
      lsh = LocalitySensitiveHash.new(:bucket_count => 10)
      30.times do |i|
        (lsh.hash(i.to_s) < 10).should eq(true)
      end
    end
    
  end
end