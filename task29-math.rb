# математические выражение
class MathExpression
  # вычисление результата сложения с объектом other
  def add other 
    Add.new(other,self)
  end

  # вычисление результата умножения с объектом other
  def multiply other
    Multiply.new(other,self)
  end  

  # вычисление результата сложения с числом
  def addNumber other
    Add.new(other,self)
  end

  # вычисление результата умножения на число
  def multiplyNumber other
    Multiply.new(other,self)
  end

  # вычисление результата сложения с переменной
  def addVar other
    Add.new(self,other)
  end

  # вычисление результата умножения на переменную
  def multiplyVar other
    Multiply.new(self,other)
  end

  # вычисление экспоненты от выражения
  def evalExp
    Exp.new self
  end

  def eval_exp 
    eval []
  end


end 

# число
class Number < MathExpression
  attr_reader :n
  def initialize n
    @n = n
  end

  # вычисление выражения в окружении env
  def eval env
    self # результат вычисления числового значения - само значение
  end

  # вычисление смены знака
  def negate
    Number.new(-@n) # результат вычисления числа с обратным знаком - новое число
  end

  # вычисление сложения с другим объектом
  def add other
    if @n == 0 then        # если число ноль
      other                # то результат сложения - второе слагаемое
    else    
      other.addNumber self # иначе организуем сложение второго
                           # слагаемого с данным числом 
    end
  end

  # вычисление умножения на другой объект
  def multiply other
    if @n == 0 then      # если число ноль
      self               # то ноль и есть результат
    elsif @n == 1 then   # если единица
      other              # то результат - второй множитель
    elsif @n == -1 then  # если минус единица
      other.negate       # результат - другой объект с обратным знаком
    else
      other.multiplyNumber self # иначе организуем умножение с данным числом
                                # второго множителя
    end
  end

  # вычисления сложения с другим числом
  def addNumber other
    Number.new(@n + other.n) # результат сложения - число
  end

  # вычисления умножения на другое число
  def multiplyNumber other
    Number.new(@n * other.n) # результат умножения - число
  end

  # вычисления умножения на переменную
  def multiplyVar other
    if @n == 0 then    # если данное число ноль, 
      self             # то это и есть результат'
    elsif @n == 1 then # если единица
      other            # то результат - переменная
    else
      super other      # иначе вызываем метод суперкласса
    end
  end

  # вычисление производной 
  def derivative var
    Number.new(0) # результат - ноль
  end

  # вычисление экспоненты числа
  def evalExp
    if @n = 0 then  # если число - ноль
      Number.new(1) # экспонента от нуля - единица'
    else
      super # иначе - то же, что в суперклассе 
    end
  end

  # преобразование объекта Number в строку
  def to_s
    @n.to_s
  end
end

# переменная
class Variable < MathExpression
  attr_reader :name
  def initialize(name) # при инициализации передается строка - имя переменной
    @name = name       
  end
  
  # вычисление выражения в окружении env
  def eval env          
    p = env.assoc @name # ищем в окружении пару с 
                        # первым элементом именем переменной
    if p.nil? then      # если не найдено
      self              # значит переменная не вычисляется
    else
      p[1]              # иначе возвращаем второй элемент 
                        # найденной пары в окружении как значение переменной
    end
  end

  # смена знака переменной
  def negate
    Negate.new(self) # создается объект Negate с содержимым - переменной
  end

  # прибавление некоторого слагаемого
  def add other
    other.addVar self # вызывается метод сложения с переменной для 
                      # второго слагаемого
  end

  # домножение на некоторый множитель
  def multiply other
    other.multiplyVar self # вызывается метод домножения на переменную
                           # для второго множителя
  end

  # вычисление производной по переменной с именем var
  # var - строка
  def derivative var
    if @name == var then # если текущая переменная - та по которой ищется 
                         # производная
      Number.new(1)      # то результат - число 1
    else
      Number.new(0)      # иначе результат - число 0
    end
  end

  # представление переменной в виде строки 
  def to_s
    @name # выдается просто имя переменной
  end
end

# замыкание
class Closure < MathExpression
  attr_reader :func, :env  
  def initialize(func, env) # замыкание представляет из себя совокупность
    @func = func            # функции
    @env = env              # и окружения, в котором эта функция определена
  end
end

# выражение let: вычисление некоторого выражения в окружении
# к которому добавлено дополнительное имя
class Let < MathExpression
  def initialize(name,e1,e2) # выражение e1 связывается с именем name
    @name = name             # и в полученном окружении вычисляется 
    @e1 = e1                 # выражение e2
    @e2 = e2
  end

  # вычисление значения выражения в окружении env
  def eval env
    bound_val = @e1.eval env              # в окружении env вычисляется e1
    @e2.eval ([[@name, bound_val]] + env) # e2 вычисляется в окружении env
                                          # в которое добавлено имя name с 
                                          # которым связывается значение e1
  end

  # представление выражения let в строковом виде
  def to_s
    "let \n" +
    "  #{@name} = #{@e1.to_s}\n" +
    "in\n" +
    "  #{@e2.to_s}"
  end
end

# смена знака
class Negate < MathExpression
  def initialize e # знак меняется у выражения e
    @e = e
  end

  # вычисление в окружении env
  def eval env
    (@e.eval env).negate # сначала вычисляется значение выражения e 
                         # в окружении env, после чего к полученному значению 
                         # применяется метод negate
  end

  # смена знака для объекта Negate
  def negate
    @e # двойная смена знака для выражения e - есть выражение e
  end

  # вычисление производной от объекта Negate по переменной var
  def derivative var
    e = @e.derivative var # вычисляется производная от выражения e
    e.negate              # после чего выполняется смена знака 
                          # у полученного выражения
  end

  # отображение объекта Negate в строковом виде
  def to_s
    "-(#{@e.to_s})" # выражение e представляется в строковом виде
                    # заключается в скобки, перед которыми ставится минус
  end
end

# сложение
class Add < MathExpression
  def initialize(e1,e2) # складываются выражения e1 и e2
    @e1 = e1
    @e2 = e2
  end

  # вычисление суммы в окружении env
  def eval env
    e1 = @e1.eval env # в окружении env вычисляются @e1 и @e2
    e2 = @e2.eval env # после чего для результата вычисления @e1
    e1.add e2         # вызывается метод сложения с результатом @e2
  end

  # смена знака для сложения двух выражений
  def negate
    e1 = @e1.negate # меняется знак для выражений @e1 и @e2
    e2 = @e2.negate # после чего для e1
    e1.add e2       # вызывается метод сложения с объектом e2
  end

  # вычисление производной суммы двух выражений
  def derivative var
    e1 = @e1.derivative var # производная суммы
    e2 = @e2.derivative var # равна сумме производных
    e1.add e2
  end

  # сложение суммы с другим объектом
  def add other
    e1 = @e1.add other # складываем @e1 с другим объектом
    @e2.add e1         # передаем результат методу сложения для @e2  
  end

  # умножение суммы на другой объект
  def multiply other
    e1 = @e1.multiply other # на заданный объект умножается каждое слагаемое
    e2 = @e2.multiply other 
    e1.add e2               # результаты умножения складываются
  end

  # добавление числа к сумме
  def addNumber other
    e1 = @e1.addNumber other # число добавляется к первому слагаемому
    e1.add @e2               # к результату добавляется второе слагаемое
  end

  # умножение суммы на число
  def multiplyNumber other
    e1 = @e1.multiplyNumber other # на число умножается каждое слагаемое
    e2 = @e2.multiplyNumber other # после чего
    e1.add e2                     # результаты складываются
  end

  # представление суммы в виде строки
  def to_s
    "(#{@e1.to_s}) + (#{@e2.to_s})" # каждое слагаемое берется в скобки
                                    # между которыми ставится плюс
  end

end

# умножение
class Multiply < MathExpression
  def initialize(e1, e2) # перемножаются выражения e1 и e2
    @e1 = e1
    @e2 = e2
  end

  # вычисление в окружении env
  def eval env
    e1 = @e1.eval env # в заданном окружении вычисляется каждый множитель
    e2 = @e2.eval env # после чего
    e1.multiply e2    # результаты перемножаются
  end

  # смена знака произведения
  def negate
    e1 = @e1.negate # для того, чтобы сменить знак произведения,
    e1.multiply @e2 # достаточно сменить знак первого множителя
  end

  # умножение произведения на некоторое выражение
  def multiply other
    e1 = @e1.multiply other # на заданное выражение домножаем первый
    @e2.multiply e1         # множитель, после чего на результат
                            # домножаем второй множитель
  end

  # вычисление производной произведения
  def derivative var
    e1 = @e1.derivative var                 # вычисляются производные 
    e2 = @e2.derivative var                 # каждого из множителей
    (e1.multiply @e2).add (@e1.multiply e2) # после чего формируем результат
        # по правилам производной произведения (uv)'= u'v + v'u
  end

  # умножение произведения на число
  def multiplyNumber other
    e1 = @e1.multiplyNumber other # домножаем на число первый множитель
    e1.multiply @e2               # после чего домножаем результат на второй
  end

  # представляем произведение в виде строки
  def to_s
    "(#{@e1.to_s}) * (#{@e2.to_s})" # заключаем в скобки каждое выражение
                                    # между скобками ставим знак умножения
  end
end

# производная
class Derivative < MathExpression
  def initialize(e, var) # производная вычисляется 
    @e = e               # от выражения
    @var = var           # по некоторой переменной (var - строка)
  end

  # вычисление в окружении env
  def eval env
    e = @e.eval env           # сначала вычисляется  выражение @e
    new_e = e.derivative @var # после чего вычисляется производная от результата
  end

  # представление производной в виде строки
  def to_s
    "(#{@e.to_s})'_#{@var}" # выражение заключается в скобки, после
                            # которых ставится штрих и указывается имя
                            # переменной, по которой вычисляется производная
  end
end

# функция для формирования выражения
class MyFunc < MathExpression
  attr_reader :name, :arg_name, :body
  def initialize(name,arg_name,body) # определяется функция с именем name
    @name = name                           # аргументом arg
    @arg_name = arg_name                   # и выражением body в качестве тела
    @body = body
  end

  # вычисление (определения) функции в окружении
  def eval env 
    Closure.new(self,env) # результатом определения функции является замыкание
  end

  # представление определенной функции в виде строки
  def to_s
    "fun #{@name} #{arg_name if arg_name}\n" +
    "   #{@body}"
  end
end

# вызов функции 
class Call < MathExpression
  def initialize(fun_exp,fact_par) # вызывается функция, полученная  
    @fun_exp = fun_exp             # в результате вычисления fun_exp
    @fact_par = fact_par           # с фактическим параметром fact_par
  end

  # вычисление в окружении env
  def eval env
    closure = @fun_exp.eval env   # вычисляется функциональное выражение
                                  # результатом которого должно быть замыкание
    fact_arg = @fact_par.eval env # вычисляется значение фактического параметра
    func_name = closure.func.name    # определяем имя функции в замыкании
    func_arg = closure.func.arg_name # определяем имя формального параметра
    func_body = closure.func.body    # извлекаем выражение - тело функции
    # формируем окружение для вычисления значения функции
    if func_name then # если функция именованная
      # добавляем к окружению в замыкании имя функции, связанное с замыканием
      # и имя формального параметра, связанное со значением
      # фактического параметра 
      new_env = [[func_arg, fact_arg], [func_name, closure]] + closure.env
    else
      # добавляем к окружению в замыкании 
      # имя формального параметра, связанное со значением
      # фактического параметра 
      new_env = [[func_arg, fact_arg]] + closure.env
    end
    # вычисляем тело функции в полученном окружении
    func_body.eval new_env
  end

  # представление вызова функции в виде строки
  def to_s
    "call #{@fun_exp}\n" + 
    "  with #{@fact_par}"
  end
end

# Экспонента
class Exp < MathExpression
  def initialize(e = Number.new(1)) # e - выражение для которого ищется 
    @e = e                          # экспонента - показатель степени
  end 

  # вычисление в окружении env
  def eval env
    e = @e.eval env  # вычисляется показатель степени
    e.evalExp        # вычисление экспоненты от выражения
  end

  # вычисление производной
  def derivative var
    e = @e.derivative var # формируем результат по правилу 
    e.multiply self       # (e^f)'=f'*e^f
  end

  # строковое представление экспоненты выражения
  def to_s
    "exp(#{@e.to_s})"
  end
end

