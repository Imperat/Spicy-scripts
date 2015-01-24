class CofeeMachine

  def initialize
    @component = {"coffee" => 0, "tea" => 0, "chocolate" => 0, "cream" => 0, "sugar" => 0, "lemon" => 0}
    @offers = {}
  end
  Size = 23
  Recipes = {"Coffee"    => {"coffee" => 1, "sugar" => 4}, 
             "Tea"       => {"tea" => 1, "sugar" => 4, "lemon" => 1},
             "Chocolate" => {"chocolate" => 1, "sugar" => 1},
             "Cream"     => {"cream" => 1, "sugar" => 0}}

  def order rec, changes
    changes.each do |k, v|
      if k == "sugar" and v > 9 
        changes["sugar"] = 9
      elsif v.abs > 1 and k != "sugar"
        changes[k] = v/v.abs
      end
    end
    if Recipes.key?(rec)
      tmp = Recipes[rec].clone
    else
      return nil
    end
    const = true
    tmp.each_key do |key|
      if changes.key?(key)
        tmp[key] += changes[key]
        if tmp[key] < 0 then tmp[key] = 0 end
      end
    end
    ["lemon", "sugar"].each do |x|
      unless tmp.key?(x)
        if changes[x]
          if changes[x] > 0 then tmp[x] = changes[x] end
        end
      end
    end
    temp = @component.clone
    tmp.each do |k, v|
      if temp[k] - v > 0
        temp[k] -= v
      else
        const = false
        nil
      end
    end
    if const
      @component = temp.clone
      @offers[rec] ? @offers[rec]+=1 : @offers[rec]=1
      true
    else
      nil
    end
  end

  def load ()
    @component.each_key { |key| @component[key] = Size }
    self
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
  puts cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  puts cf.status
  cf.order("Tea", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  cf.order("Cream", {"sugar" => 2})
  cf.order("Cream", {"sugar" => -1})
  cf.order("Cream", {"sugar" => 1})
  cf.order("Cream", {"sugar" => 1})
  puts cf.status
  print cf.stat
