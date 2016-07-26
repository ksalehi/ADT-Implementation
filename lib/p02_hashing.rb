class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.each_with_index.inject(0) do |accum, (el, idx)|
      accum ^ (el.hash + idx.hash)
    end
  end
end

class String
  def hash
    self.chars.map {|char| char.ord}.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort_by {|tuple| tuple.hash}.hash
  end
end
