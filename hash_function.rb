class HashFunction
  def initialize(val, mod)
    @val = val
    @mod = mod
  end
  
  def hash(string_array)
    total=0;
    string_array.each do |string|
      string.each_byte do |byte| 
        total += @val*byte
      end
    end
    total % @mod
  end
  
end