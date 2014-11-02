class Train

  def initialize(number_of_carriages = 1)
    @capacity = number_of_carriages.to_i * carriage_capacity
  end

  def capacity
    @capacity
  end

  def carriage_capacity(number = 40)
    number.to_i
  end

end