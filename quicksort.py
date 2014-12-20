import random
def quickSort(l):
    if len(l) <= 1:
        return l
    else:
        def divide (l):
            t = l.pop()
            a, b = [], []
            for i in l:
                a.append(i) if i<t else b.append(i)
            a.append(t) if b!=[] else b.append(t)
            return a, b
        a, b = divide(l)
        return quickSort(a) + quickSort(b)


a=[]
for i in range(541):
    t = random.randint(1,1000)
    a.append (t)
print quickSort(a)
