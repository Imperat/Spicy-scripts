class MyConditioner < Conditioner
  def change_tact new_tact
  	@tact = new_tact
  end
end


class MyHeater < Heater 

end


class MyClimateControl < ClimateControl
  def check_conditioner
    if @home.temperature > @cond_start # если превышен темп. барьер
      @home.conditioner(0).set_on         # перевести в режим работы первый
      if @home.temperature - @cond_start >= 4
      	@home.conditioner(1).set_on
      end
    else
      @home.conditioner(0).set_off        # перевести в режим ожидания
      @home.conditioner(1).set_off        # перевести в режим ожидания
    end
  end
end


class MyReporter < Reporter
  def cond_status_s
    "conditioner one: " + bool_to_on_off_s(@home.conditioner(0).status) + " " +
    "conditioner two: " + bool_to_on_off_s(@home.conditioner(1).status)
  end
end


class MyWeather < Weather

end

class MyCyclon < Cyclon
    Cyclons = 
    [[-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2],
     [-1.5, -1, -0.5, 0, 0, 0],
     [0, 0, 0, 0.5, 1, 1.5],
     [-1, -0.5, 0, 0, 0, 0.5, 1],
     [-0.5, 0, 0.5],
     [-2.1, -1.8, -1.5, -1.2, -0.9, -0.6, -0.3, 0, 0.3, 0.6, 0.9, 1.2, 1.5, 1.8, 2.1]
    ] 

    def self.new_cyclon weather
    # берется случайный представитель списка Cyclons 
    # и с ним создается новый циклон
    MyCyclon.new(MyCyclons.sample, weather)
  end
end

class MyGlasshouse < Glasshouse
  def set_glasshouse
    @conditioner0 = MyConditioner.new self
    @conditioner1 = MyConditioner.new self
    @conditioner0.change_tact 0.4
    @conditioner1.change_tact 0.3
    @heater = Heater.new self
    @climate_control = MyClimateControl.new(self, 15, 25)
    @reporter = MyReporter.new self
  end

  def list_of_processes
    all_system = [@weather, @conditioner0, @conditioner1, @heater, @climate_control, @reporter]
    all_system.map { |syst| syst.get_runner }
  end

  def conditioner n
    n == 0 ? @conditioner0 : @conditioner1
  end

  def temperature
    # складывается как изменение температуры, вследствие погоды
    # минус изменение, сгенерированное кондиционером
    # плюс изменение, сгенерированное обогревателем
    @weather.temperature - @conditioner0.change - @conditioner1.change + @heater.change
  end
end

