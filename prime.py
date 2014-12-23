# -*- coding: utf-8 -*-
def Prime (N, matrix, Tree = [0], res = []):
    minim = 100000
    index = -1
    for j in Tree:
        for i in matrix[j]:
            if i < minim and matrix[j].index(i) not in Tree:
                minim = i
                index, indexj = matrix[j].index(i), j
    if index != -1:
        res.append((index, indexj))
        print "в оставное дерево добавлена вершина " + str(index)
        return Prime(N, matrix, Tree + [index], res)
    else:
        return Tree

#tmp = Prime(3, [[0, 5, 1], [5,0,3], [1,3,0]])
tmp = Prime(4, [[0, 1, 1, 1],[1, 0, 1, 1],[1, 1, 0, 1],[1, 1, 1, 0]])
print tmp
