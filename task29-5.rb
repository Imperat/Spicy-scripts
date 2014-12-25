# подгружаются основные определения
require_relative './task29-math'

# вычитание
class Minus < MathExpression
  def initialize(e1,e2) # складываются выражения e1 и e2
    @e1 = e1
    @e2 = e2
  end

  # вычисление разности в окружении env
  def eval env
    e1 = @e1.eval env # в окружении env вычисляются @e1 и @e2
    e2 = @e2.eval env # после чего для результата вычисления @e1
    e1.add e2.negate       # вызывается метод сложения с результатом @e2, но противоположным знаком
  end

  # смена знака для разности двух выражений
  def negate
    e1 = @e1.negate # меняется знак для выражения @e1
    e2 = @e2 # после чего для e1
    e1.add e2       # вызывается метод сложения с объектом e2
  end

  # вычисление производной суммы двух выражений
  def derivative var
    e1 = @e1.derivative var # производная разности
    e2 = @e2.derivative var # равна разности производных
    e1.add e2.negate
  end

  # сложение разности с другим объектом
  def add other
    e1 = @e1.add other # складываем @e1 с другим объектом
    e1.andd @e2.negate         # передаем результат методу сложения для @e2  
  end

  # умножение разности на другой объект
  def multiply other
    e1 = @e1.multiply other # на заданный объект умножается каждое слагаемое
    e2 = @e2.multiply other 
    e1.add e2.negate               # результаты умножения вычитаются
  end

  # добавление числа к разности
  def addNumber other
    e1 = @e1.addNumber other # число добавляется к первому
    e1.add @e2.negate               # из результата вычитается второе
  end

  # умножение разности на число
  def multiplyNumber other
    e1 = @e1.multiplyNumber other # на число умножается каждое слагаемое
    e2 = @e2.multiplyNumber other # после чего
    e1.add e2.negate                     # результаты складываются
  end

  # представление разности в виде строки
  def to_s
    "(#{@e1.to_s}) - (#{@e2.to_s})" # каждое слагаемое берется в скобки
                                    # между которыми ставится минус
  end

end

class Abs < MathExpression
  def initialize e1 #подмодульное выражение
    @e1 = e1
  end

  # вычисление в окружении env
  def eval env
    e = @e.eval env 
    e.abs        # вычисление модуля от выражения
  end

  def to_s
    "|#{@e1.to_s}|"
  end
end

class MathExpression
  def abs
    Abs.new self
  end
end

class Number < MathExpression #Доопределение модуля числа
  def abs
    n<=0? -n : n
  end
end


puts(Derivative.new(
        Multiply.new(
          Add.new(
            Add.new(
              Multiply.new(Abs.new(-2),      
                           Variable.new("x")), 
              Multiply.new(Number.new(3), 
                           Variable.new("y"))), 
            Negate.new(Variable.new("z"))), 
          Add.new(Number.new(5), 
                  Variable.new("x"))), 
        "x"))  



# ПРИМЕРЫ
#puts(Derivative.new(
#        Multiply.new(
#          Add.new(
#            Add.new(
#              Multiply.new(Number.new(2),      
#                           Variable.new("x")), 
#              Multiply.new(Number.new(3), 
#                           Variable.new("y"))), 
#            Negate.new(Variable.new("z"))), 
#          Add.new(Number.new(5), 
#                  Variable.new("x"))), 
#        "x"))  
#
#puts(Let.new("a", Multiply.new(Number.new(2), 
#                               Variable.new("x")),        # a = 2x
#       Let.new("b", Multiply.new(Number.new(3), 
#                                 Variable.new("y")),      # b = 3y
#         Let.new("e", Add.new(Variable.new("a"),         
#                              Variable.new("b")),         # e = a + b
#            Multiply.new(Multiply.new(Variable.new("e"),
#                                      Variable.new("e")),
#                         Variable.new("e"))))))            
#
#puts(Let.new("a", Multiply.new(Number.new(2), 
#                               Variable.new("x")),   # a = 2x
#       Let.new("b", Multiply.new(Number.new(3), 
#                                 Variable.new("y")), # b = 3y
#         Let.new("cube",                             # cube(e) = e * e * e
#                 MyFunc.new(nil, "e",
#                   Multiply.new(Multiply.new(Variable.new("e"),
#                                             Variable.new("e")),
#                                Variable.new("e"))),
#           # вычисление cube(a + b) + cube(b)
#           Add.new(Call.new(Variable.new("cube"),        # вызов cube(a + b)
#                            Add.new(Variable.new("a"), 
#                                    Variable.new("b"))),
#                   Call.new(Variable.new("cube"),        # вызов cube(b)
#                            Variable.new("b")))))))
#
## вычисление выражений
#puts(Derivative.new(
#        Multiply.new(
#          Add.new(
#            Add.new(
#              Multiply.new(Number.new(2),      
#                           Variable.new("x")), 
#              Multiply.new(Number.new(3), 
#                           Variable.new("y"))), 
#            Negate.new(Variable.new("z"))), 
#          Add.new(Number.new(5), 
#                  Variable.new("x"))), 
#        "x").eval_exp)  
#
#puts(Let.new("a", Multiply.new(Number.new(2), 
#                               Variable.new("x")),        # a = 2x
#       Let.new("b", Multiply.new(Number.new(3), 
#                                 Variable.new("y")),      # b = 3y
#         Let.new("e", Add.new(Variable.new("a"),         
#                              Variable.new("b")),         # e = a + b
#            Multiply.new(Multiply.new(Variable.new("e"),
#                                      Variable.new("e")),
#                         Variable.new("e"))))).eval_exp)            
#
#puts(Let.new("a", Multiply.new(Number.new(2), 
#                               Variable.new("x")),   # a = 2x
#       Let.new("b", Multiply.new(Number.new(3), 
#                                 Variable.new("y")), # b = 3y
#         Let.new("cube",                             # cube(e) = e * e * e
#                 MyFunc.new(nil, "e",
#                   Multiply.new(Multiply.new(Variable.new("e"),
#                                             Variable.new("e")),
#                                Variable.new("e"))),
#           # вычисление cube(a + b) + cube(b)
#           Add.new(Call.new(Variable.new("cube"),        # вызов cube(a + b)
#                            Add.new(Variable.new("a"), 
#                                    Variable.new("b"))),
#                   Call.new(Variable.new("cube"),        # вызов cube(b)
#                            Variable.new("b")))))).eval_exp)
