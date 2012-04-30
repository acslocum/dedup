class HashFunction
  attr_reader :function
  
  def initialize(random_seed)
    generate_hash_array(random_seed)
  end
  
  def hash(string_array)
    total=0
    index=0
    string_array.each do |string|
      string.each_byte do |byte| 
        total += scale(index)*byte
        index += 1
      end
    end
    total
  end
  
  private
  
  def generate_hash_array(seed)
    srand seed
    @function = []
    128.times { @function << rand(256) }
  end
  
  def scale(index)
    function[index%function.length]
  end
  
end