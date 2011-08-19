class Array
  def +@
    map do |element|
      element + 1
    end
  end

  def -@
    map do |element|
      element - 1
    end
  end
end
