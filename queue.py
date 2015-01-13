
newSymbol = "N"

class Queue :
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if not self.is_empty():
            t = self.items[0]
            del self.items[0]
            return t

    def is_empty(self):
        return (self.items == [])

    def __repr__(self):
        return str(self.items)

vowel = "eyuoia"

s = Queue()
s.push("m")
s.push("i")
s.push("s")
s.push("a")
s.push("r")
s.push("q")

t = Queue()
while (not s.is_empty()):
    tmp = s.pop()
    t.push(tmp)
    if tmp in vowel:
        t.push(newSymbol)

print t
