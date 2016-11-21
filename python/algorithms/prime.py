# -*- coding: utf-8 -*-
def Prime (N, matrix, Tree = [0], res = []):
    minim = 100000
    index = -1
    for j in Tree:
        for i in range(len(matrix[j])):
            if 0 < matrix[j][i] < minim and i not in Tree:
                minim = matrix[j][i]
                index, indexj = i, j
    if index != -1:
        res.append((index, indexj, matrix[index][indexj]))
        return Prime(N, matrix, Tree + [index], res)
    else:
        return res

tmp = Prime(3, [[0, 5, 1], [5,0,3], [1,3,0]])
#tmp = Prime(4, [[0, 1, 1, 1],[1, 0, 1, 1],[1, 1, 0, 1],[1, 1, 1, 0]])
print "a - b - len"
for i in tmp:
    print i
