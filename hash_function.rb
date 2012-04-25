class HashFunction
  def initialize(val)
    @val = val
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
  
end