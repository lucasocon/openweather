module Openweather2
  class Temperature
    def initialize(kelvin)
      @kelvin = kelvin
    end

    def to_metric
     "#{(@kelvin - 273.15).round(2)}°C"
    end

    def to_imperial
      "#{(1.8 * (@kelvin - 273.15) + 32).round(2)}°F"
    end
  end
end