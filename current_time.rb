class CurrentTime
  #returns the current hour/minute in pacific standard time offset with daylight savings
  # in which user runs the program
  def self.pacific
    now = Time.now.utc.localtime("-07:00").to_s
    return now[11..15]
  end
end
