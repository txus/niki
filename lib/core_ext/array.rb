class Array
  def sharp
    map do |element|
      element + 1
    end
  end

  def flat
    map do |element|
      element - 1
    end
  end
end
