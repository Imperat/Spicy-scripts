class CofeeMachine
  Size = 23
  #Ингридиенты в наличии
  component = {"coffee" => 0, "team" => 0, "chocolate" => 0, "cream" => 0, "sugar" => 0, "lemon" => 0}
  #Рецепты напитков
  Coffee = {"coffee" => 1, "sugar" => 4}
  Tea = {"tea" => 1, "sugar" => 4, "lemon" => 1}
  Chocolate = {"chocolate" => 1, "sugar" => 1}
  Cream = {"cream" => 1, "sugar" => 0}
  #Каждому напитку ставим в соответствие рецепт
  Recipes = {"Coffee" => Coffee, "Tea" => Tea, "Chocolate" => Chocolate, "Cream" => Cream}
  
  def load ()
  component.each_key { |key| component[key] = Size}
  end
  def hi ()
  puts "lololololo"
  end
  end
  
  puts "hello"
