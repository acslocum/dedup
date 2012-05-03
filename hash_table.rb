class HashTable
  def initialize bucket_count, seed
    @hash_function = HashFunction.new(seed)
    @buckets = {}
    @bucket_count = bucket_count
  end
  
  def put string_array
    key = hash string_array
    @buckets[key] = [] if !include? key
    @buckets[key] << string_array
    key
  end
  
  def include? key
    @buckets.include? key
  end
  
  def hashed? string_array
    include? hash(string_array)
  end
  
  def hash string_array
    @hash_function.hash(string_array) % @bucket_count
  end
  
  def keys
    @buckets.keys
  end
  
  def values
    @buckets.values
  end
  
  def [] key
    @buckets[key]
  end
  
  def bucket_for string_array
    @buckets[hash string_array]
  end
  
  def size
    total=0
    @buckets.keys.each { |key| total += @buckets[key].size }
    total
  end
  
end