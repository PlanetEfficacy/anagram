class MathNerd
  attr_reader :numbers
  def initialize(numbers)
    @numbers = numbers
  end

  def average
    numbers.sum / numbers.count.to_f
  end

  def median
    sorted = numbers.sort
    len = sorted.length
    (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
  end
end
