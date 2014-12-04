class CofeeMachine

  def initialize ()
    
    #Ингридиенты в наличии
    @component = {"coffee" => 0, "tea" => 0, "chocolate" => 0, "cream" => 0, "sugar" => 0, "lemon" => 0}
    #Рецепты напитков
    @Coffee = {"coffee" => 1, "sugar" => 4}
    @Tea = {"tea" => 1, "sugar" => 4, "lemon" => 1}
    @Chocolate = {"chocolate" => 1, "sugar" => 1}
    @Cream = {"cream" => 1, "sugar" => 0}
    #Каждому напитку ставим в соответствие рецепт
    @offers = {"Coffee" => 0, "Tea" => 0, "Chocolate" => 0, "Cream" => 0}
  end

  Size = 23
  Recipes = {"Coffee" => @Coffee, 
             "Tea" => @Tea, "Chocolate" => @Chocolate, "Cream" => @Cream}
  def order (rec, changes)
    changes.each do |k, v|
      if k == "sugar" and v > 9 
        v = 9
      elsif v.abs > 1 and k != "sugar"
        changes[k] = v/v.abs
      end
    end
    #
    if rec == "Coffee"
      tmp = @Coffee
      changes.each_key{
        |key|
        if key != "sugar" and key != "lemon" and key != "coffee"
          changes.delete(key)
        end
      }
    elsif rec == "Tea"
      tmp = @Tea
      changes.each_key{
        |key|
        if key != "sugar" and key != "lemon" and  key !=  "tea"
          changes.delete(key)
        end
      }
    elsif rec == "Chocolate"
      tmp = @Chocolate
      changes.each_key{
      |key|
      if key != "sugar" and key != "lemon" and key !=  "chocolate"
        changes.delete(key)
      end
      }
    elsif rec == "Cream"
      tmp = @Cream
      changes.each_key{
       |key|
       if key != "sugar" and key != "lemon" and key !=  "cream"
         changes.delete(key)
       end
      }
    else
      return nil
    end
    tmp.merge! (changes) {
     |key, old, news|
     if tmp.key?(key) != nil or key == "sugar" or key == "lemon"
       news = old + news
     end
    }
    tmp.each{
      |k, v|
      @component[k] -= v
    }
    const = true
    @component.each_value{
      |v| if v < 0 then const = false end
    }
    if const
      @offers[rec] += 1
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
  cf.order("Coffee", {"lemon" => 4, "tea" => 3, "sugar" => 2, "coffee" =>2})
  print cf.stat
