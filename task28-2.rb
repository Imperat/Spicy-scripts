class CofeeMachine

  def initialize ()
    #Ингридиенты в наличии
    @component = {"coffee" => 0, "tea" => 0, "chocolate" => 0, "cream" => 0, "sugar" => 0, "lemon" => 0}
    #Заказы
    @offers = {}

    @Size = 23
    @Recipes = {"Coffee"    => {"coffee" => 1, "sugar" => 4}, 
             "Tea"       => {"tea" => 1, "sugar" => 4, "lemon" => 1},
             "Chocolate" => {"chocolate" => 1, "sugar" => 1},
             "Cream"     => {"cream" => 1, "sugar" => 0}}
  end


  def order (rec, changes)
    changes.each do |k, v|
      if k == "sugar" and v > 9 
        v = 9
      elsif v.abs > 1 and k != "sugar"
        changes[k] = v/v.abs
      end
    end
    #
    if @Recipes.key?(rec)
      tmp = @Recipes[rec]
    else
      return nil
    end
    const = true
    tmp.each_key do |key|
      if changes.key?(key)
        tmp[key] += changes[key]
      end
    end
    unless tmp["lemon"]
      tmp["lemon"] = changes["lemon"]
    end
    unless tmp["sugar"]
      tmp["sugar"] = changes["sugar"]
    end
    tmp.each do |k, v|
      '''if @component[k] - v > 0
        @component[k] -= v
      else
        nil
      end
      '''
      temp = @component
      
      unless temp[k]-v > 0 ? temp[k] -= v : nil
        const = false
        break
      end
      @component = temp
    end
    if const
      @offers[rec] ? @offers[rec]+=1 : @offers[rec]=1
    else
      return nil
    end
  end

  def load ()
    @component.each_key { |key| @component[key] = @Size }
  end
  
  def status ()
    @component
  end

  def stat ()
    @offers
  end

end
  
  cf = CofeeMachine.new
  cf.load
  print cf.status, "\n"
  cf.order("Coffee", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  print cf.status, "\n"
  cf.order("Coffee", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  print cf.status, "\n"
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  print cf.status, "\n"
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  print cf.status, "\n"
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  print cf.status, "\n"
  print cf.stat
