#!/usr/bin/env python
# -*- coding: utf-8 -*-
 
class Graph:
    struct = dict()
    vertex = set()
    Cycles = set()
    color  = dict() # метки цветов
    num = 0
    d = []
 
    def Predock(self, a, antw=[]):
        if a not in antw:
            antw.append(a)
        for i in self.struct.keys():
            for j in self.struct[i]:
                if j==a:
                    if i not in antw:
                        antw.append(i)
                        Predock(i, antw)
        return antw



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
 
    def addArc(self, a,b,w):
        if a not in self.vertex or b not in self.vertex:
            raise NotExistingVertex
        self.struct[a] = []
        if b in self.struct[a]:
            raise ArcExist
        self.struct[a].append((b,w))
 
    def delArc(self, a,b):
        try:
            del(self.struct[a][b])
        except:
            raise ArcDoesNotExist
 
    def setOfArc(self):
        for i in self.struct.keys():
            for j in self.struct[i]:
                yield(i,j[0], j[1])
 
    def read(self, filename):
        try:
            with open(filename) as f:
                self.vertex = set(eval(f.readline()))
                self.struct = eval(f.readline())
        except:
            raise Error
        for i in self.vertex:
            self.color[i]="white"
        f = lambda x: 30000
        #self.d = map(f, range(len(self.vertex)))
 
 
    def __str__(self):
        for k in self.vertex:
            try:
                a = str(self.struct[k])
            except:
                a = "[]"
            print k, " : ", a
 
    def Bellman_Ford (self, a):
        self.d = dict()
        for i in self.vertex:
            if i != a:
                self.d[i] = 30000
            else:
                self.d[i] = 0
        #------------------------
        d = self.d
        for i in range(len(self.vertex)):
            if i != range(len(self.vertex))[-1]:
                for j in self.setOfArc():
                    if d[j[1]]>d[j[0]]+j[2]:
                        d[j[1]]=d[j[0]]+j[2]
            else:
                for j in self.setOfArc():
                    if d[j[1]]>d[j[0]]+j[2]:
                        d[j[1]]=d[j[0]]+j[2]
                        print "Cycle!!!!"
                        print self.Predock(j[1])
        for k in d.keys():
            if d[k]>=30000:
                d[k]="Path doesn't exist"
        return d


    def Kraskal (self):
        setOfArcs = set()
        setOfVertex = set()
        b = self.setOfArc()
        c = []
        for i in b:
            c.append(i)
        c.sort(key=lambda x: x[2])
        for i in c:
            if (i[0] not in setOfVertex) or (i[1] not in setOfVertex):
                setOfArcs.add(i)
                setOfVertex.add(i[0])
                setOfVertex.add(i[1])

        return setOfArcs
           
 
 
 
 
 
a = Graph()
a.read("graph.txt")
 
print a.struct

print "----"
print a.Kraskal()
print "----"
