class HashFunction
  def initialize(val)
    @val = val
    generate_hash_array(val)
  end
  
  def hash(string_array)
    total=0;
    string_array.each do |string|
      string.each_byte do |byte| 
        total += @val*byte
      end
    end
    total
  end
  
  def generate_hash_array(seed)
    
  end
  
  def function
    []
  end
  
end