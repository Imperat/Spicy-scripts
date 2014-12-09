class CofeeMachine

  def initialize ()
    @component = {"coffee" => 0, "tea" => 0, "chocolate" => 0, "cream" => 0, "sugar" => 0, "lemon" => 0}
    @offers = {}
    @Size = 23
    @Recipes = {"Coffee"    => {"coffee" => 1, "sugar" => 4}, 
                "Tea"       => {"tea" => 1, "sugar" => 4, "lemon" => 1},
                "Chocolate" => {"chocolate" => 1, "sugar" => 1},
                "Cream"     => {"cream" => 1, "sugar" => 0}}
  end


  def order rec, changes
    changes.each do |k, v|
      if k == "sugar" and v > 9 
        changes["sugar"] = 9
      elsif v.abs > 1 and k != "sugar"
        changes[k] = v/v.abs
      end
    end
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
    unless tmp["lemon"] or changes["lemon"] <= 0
      tmp["lemon"] = changes["lemon"]
    end
    unless tmp["sugar"] or changes["lemon"] <= 0
      tmp["sugar"] = changes["sugar"]
    end
    temp = @component.clone
    tmp.each do |k, v|
      if temp[k] - v > 0
        temp[k] -= v
      else
        const = false
        nil
      end
     # if f then @component = temp end
    end
    if const
      @component = temp.clone
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
  puts cf.status
  cf.order("Coffee", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  puts cf.status
  cf.order("Coffee", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  puts cf.status
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  puts cf.status
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  puts cf.status
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  puts cf.status
  print cf.stat
