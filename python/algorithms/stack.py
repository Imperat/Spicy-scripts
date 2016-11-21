class Stack :
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        return self.items.pop()

    def is_empty(self):
        return (self.items == [])

    def __repr__(self):
        return str(self.items)


s = Stack()
s.push(45)
s.push(456)
s.push(3)
s.push(26)
s.push(445)
s.push(98)
s.push(100)
s.push(2)
s.push(3)

t = Stack()
while (not s.is_empty()):
    tmp = s.pop()
    if not (tmp >= 10 and tmp <= 99):
        t.push(tmp)
s = Stack()
while (not t.is_empty()):
    s.push(t.pop())

print s
