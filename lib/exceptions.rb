# Train Exceptions

class TrainIsFull < Exception
  def message
    "This train is full."
  end
end

class TrainNotAtStation < Exception
  def message
    "This train is not at the station"
  end
end

class TrainNotArrived < Exception
  def message
    "The train has not arrived yet"
  end
end

class TrainAtAnotherStation < Exception
  def message
    "This train is at another station"
  end
end

class PassengerAlreadyAtStation < Exception
  def message
    "Passenger is already at the station"
  end
end

class PassengerNotTouchedIn < Exception
  def message
    "The passenger is not touched in."
  end
end

class StationIsFull < Exception
  def message
    "The station is full."
  end
end

class PassengerTouchedOut < Exception
  def message
    "Passenger is already touched out"
  end
end

class PassengerAtAnotherStation < Exception
  def message
    "This passenger is at another station"
  end
end

class PassengerTouchedIn < Exception
  def message
    "Passenger is already touched in"
  end
end

class PassengerNotInsideStation < Exception
  def message
    "Passenger is not inside a station"
  end
end

class PassengerMustTouchOut < Exception
  def message
    "The passenger must touch out before leaving the station."
  end
end

class NotEnoughCredit < Exception
  def message
    "Passenger does not have enough credit. Please add credit."
  end
end