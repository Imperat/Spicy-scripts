#!/usr/bin/env python
# -*- coding: utf-8 -*-

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

    def next(self, a):
        try:
            t = self.struct[a]
            if t:
                return True
            else:
                return False
        except:
            return False

    def findForUserUV(self):
        c = raw_input("Please, write two vertexes:\n")
        c = c.split()
        a = c[0]
        b = c[1]
        print "You answer is:", self.find(int(a),int(b))

    def read(self, filename):
        try:
            with open(filename) as f:
                self.vertex = set(eval(f.readline()))
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

    def ddfs(self, a):
        views = []

        def dfs(self, a):
            #print a
            views.append(a)
            if self.next(a):
                for i in self.struct[a]:
                    if i not in views:
                        dfs(self, i)

        dfs(self, a)
        return views

    def A(self, a):
        olala = set()
        for i in self.struct.keys():
            if a in self.struct[i]:
                olala.add(i)
        return olala

    def TopologSort(self):
        res = []
        for i in self.vertex:
            tmp = self.ddfs(i)
            res = res + tmp
            if len(res) == len(self.vertex):
                return res
                break

    def AllTrops(self, u, v, parameter=[], top = True):
        if u == v:
            return parameter + [v]
        else:
            tmp = self.ddfs(u)
            if v not in tmp:
                #print "u ", u, "v ", v
                return None 
            else:
                conjug = self.struct[u]
                answer = []
                for i in conjug:
                    a = self.AllTrops(i, v, parameter + [u], False)
                    if a:
                        answer.append(a)
                if top:
                    return answer
                else:
                    return answer[0]

    def MinPathUV(self, u,v, leng = 0):
        if not v in self.ddfs(u):
            return 99999
        else:
            if u==v:
                return leng
            else:
                f = lambda x: self.MinPathUV(x,v, leng + 1)
                return min(map(f, self.conjugate(u)))


    def Eccentricity(self, u):
        f = lambda x: self.MinPathUV(u,x)
        g = lambda x: x != 99999
        vert = self.vertex - set([u])
        antw = filter(g, map(f, vert))
        if antw:
            return max(antw)
        else:
            return 99999

    def Radius(self):
        f = lambda x: self.Eccentricity(x)
        return min(map(f, self.vertex))

    def Center(self):
        antwort = []
        r = self.Radius()
        for i in self.vertex:
            if self.Eccentricity(i) == r:
                antwort.append(i)        
        return antwort


a = Graph()
a.read("graph.txt")


#print a.ddfs(24)
#print a.TopologSort()
#print a.AllTrops(34, 45)
print a.Eccentricity(76)
print a.MinPathUV(2,76)
print a.Radius()
print a.Center()
