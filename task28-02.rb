class MyConditioner < Conditioner
  def change_tact new_tact
  	@tact = new_tact
  end
end


class MyHeater < Heater 

end


class MyClimateControl < ClimateControl

end


class MyReporter < Reporter

end


class MyWeather < Weather

end

class MyCyclon < Cyclon
  # MyCyclons = []
end

class MyGlasshouse < Glasshouse
  def set_glasshouse
    @conditioner0 = MyConditioner.new self
    @conditioner0.change_tact 0.4
    @heater = Heater.new self
    @climate_control = ClimateControl.new(self, 15, 25)
    @reporter = Reporter.new self
  end

  def list_of_processes
    all_system = [@weather, @conditioner0, @heater, @climate_control, @reporter]
    all_system.map { |syst| syst.get_runner }
  end

  def conditioner
    @conditioner0
  end

  def temperature
    # складывается как изменение температуры, вследствие погоды
    # минус изменение, сгенерированное кондиционером
    # плюс изменение, сгенерированное обогревателем
    @weather.temperature - @conditioner0.change + @heater.change
  end
end

