class Graph:
    struct = dict()
    vertex = set()


    def addVertex(self, a):
        if a in self.vertex:
            raise VertexExists
        else:
            self.vertex.add(a)
            self.struct[a] = []


    def delVertex(self, a):
        try:
            self.vertex.remove(a)
            del(self.struct[a])
            for i in self.struct.values():
                for j in i:
                    if j == a:
                        del(j)
        except:
            raise VertexDoesNotExists

    def addArc(self, a,b):
        if a not in self.vertex or b not in self.vertex:
            raise NotExistingVertex
        self.struct[a] = []
        if b in self.struct[a]:
            raise ArcExist
        self.struct[a].append(b)


    def delArc(self, a,b):
        try:
            del(self.struct[a][b])
        except:
            raise ArcDoesNotExist



    def __str__(self):
        for k in self.vertex:
            try:
                a = str(self.struct[k])
            except:
                a = "[]"
            print k, " : ", a

    def find(self, a, b):
        try:
            A = self.struct[a]
            B = self.struct[b]
            A = set(A)
            B = set(B)
            if A & B:
                return A & B
            else:
                return []
        except:
            pass

    def findForUserUV(self):
        c = raw_input("Please, write two vertexes:\n")
        c = c.split()
        a = c[0]
        b = c[1]
        print "You answer is:", self.find(int(a),int(b))

    def read(self, filename):
        try:
            with open(filename) as f:
                self.vertex = eval(f.readline())
                self.struct = eval(f.readline())
        except:
            raise Error
            
    def conjugate(self, a):
        if a in self.vertex:
            try:
                return self.struct[a]
            except:
                return []
        else:
            raise KeyError

    def dfs(self, a, out=[]):
        out.append(a)
        for i in self.struct[a]:
            if i not in out:
                self.dfs(i, out)
        if len(out) == len(self.vertex):
            return out

    def A(self, a):
        olala = set()
        for i in self.struct.keys():
            if a in self.struct[i]:
                olala.add(i)
        return olala

    #def TopologSort(self):



a = Graph()
a.read("graph.txt")

print a.A(45)
print a.dfs(45)
