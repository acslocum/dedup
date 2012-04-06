class LocalitySensitiveHash
  attr_reader :bucket_count
  
  
  def initialize bucket_count
    @bucket_count = bucket_count
    @hash_function = HashFunction.new
    @buckets = {}
  end
  
  def put string_array
    key = @hash_function.hash string_array
    @buckets[key] = [] if !@buckets.include? key
    @buckets[key] << string_array
    key
  end
  
  def include? key
    @buckets.include? key
  end
  
  def hashed? string_array
    false
  end
  
  def keys
    @buckets.keys
  end
  
  def values
    @buckets.values
  end
  
  def buckets_for string_array
    key = @hash_function.hash string_array
    [@buckets[key]]
  end
  
  def [] key
    @buckets[key]
  end
  
  def neighbor_histogram string_array
    []
  end
  
  def size
    @buckets.size
  end
  
end