class LocalitySensitiveHash
  attr_reader :bucket_count
  
  def initialize options
    @bucket_count = options[:bucket_count] || 10000
    hash_function_count = options[:hash_function_count] || 1
    @hash_tables = []
    hash_function_count.times do
      @hash_tables << HashTable.new(20001, @bucket_count)
    end
  end
  
  def put string_array
    @hash_tables.each {|table| table.put string_array}
    nil
  end
  
  def hashed? string_array
    @hash_tables[0].hashed? string_array
  end
  
  def buckets_for string_array
    @hash_tables.collect { |table| table.bucket_for(string_array)}
  end
  
  def neighbor_histogram string_array
    buckets = buckets_for string_array
    histogram = {}
    if !buckets.nil?
      buckets.each do |entry|
        if(histogram.include? entry)
          histogram[entry] = histogram[entry]+1
        else
          histogram[entry] = 1
        end
      end
    end
    histogram
  end
  
  def size
    @hash_tables[0].size
  end
  
end