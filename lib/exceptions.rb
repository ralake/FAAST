class TrainIsFullError < Exception
  def message
    "This train is full."
  end
end

class NotTouchedInError < Exception
  def message
    "This passenger needs to touch in before boarding the train."
  end
end

class MustTouchOutError < Exception
  def message
    "Passenger must touch out before leaving the station."
  end
end

class NotEnoughCreditError < Exception
  def message
    "Passenger needs atleast 2GBP to touch in. Add credit to account."
  end
end

class NotInsideStationError < Exception
  def message
    "You are not inside the station."
  end
end

class StationFullError < Exception
  def message
    "This station is full."
  end
end

class NoPlatformAvailableError < Exception
  def message
    "The platforms are full. Wait for a train to leave the station"
  end
end