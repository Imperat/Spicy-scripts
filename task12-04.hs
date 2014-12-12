-- функция возвращает корень уравнения f(x) = 0 с точностью e.
-- начальные приближения - x0, x1.
--sek :: (Fractional a, Ord a) => (a -> a) -> a -> a -> a
sek f x0 x1 = antwort xes
   where
      fun n = if n == 1
      	then
      		42
      	else if n == 2
      		then
      			100
      	else if n == 3
        then
            100 - (f 100) * (100 - 42) / ((f 100) - f(42))
        else
            (fun $ n-1) - (((f . fun) $ n-1) * ((fun $ n-1) - (fun $ n-2)) /
                        (((f . fun) $ n-1) - ((f . fun) $ n-2)))
      xes = map fun [3..]
      e = 0.001

      antwort t@(s:ls) = if abs (f s) < e
         then
            s
         else
            antwort ls

--функция вычисления квадратного корня числа.

--my_sqrt :: (Fractional a, Ord a) => a -> a
--my_sqrt num = sek (\x -> x * x - num) 1 num
--
main = do
	print $ sek cos 10 20
