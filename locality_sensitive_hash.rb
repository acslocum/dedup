class LocalitySensitiveHash
  attr_reader :bucket_count
  
  def initialize options
    @bucket_count = options[:bucket_count] || 10000
    hash_function_count = options[:hash_function_count] || 1
    @hash_function = []
    @buckets = []
    hash_function_count.times do
      @hash_function << HashFunction.new(20001)
      @buckets << {}
    end
  end
  
  def put string_array
    key = hash string_array
    @buckets[0][key] = [] if !include? key
    @buckets[0][key] << string_array
    key
  end
  
  def include? key
    @buckets[0].include? key
  end
  
  def hashed? string_array
    include? hash(string_array)
  end
  
  def hash string_array
    @hash_function[0].hash(string_array) % @bucket_count
  end
  
  def keys
    @buckets[0].keys
  end
  
  def values
    @buckets[0].values
  end
  
  def buckets_for string_array
    key = hash(string_array)
    self[key]
  end
  
  def [] key
    @buckets[0][key]
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
    total=0
    @buckets[0].keys.each { |key| total += @buckets[0][key].size }
    total
  end
  
end