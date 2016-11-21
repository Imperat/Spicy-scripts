__author__ = 'Imperat-2'
# -*- coding: utf-8 -*-
import random
import sys
sys.setrecursionlimit(500000)
def mergeSort (l):
    size = len(l)
    if size > 2:
        a = mergeSort(l[0:size/2])
        b = mergeSort(l[size/2:])
        def merge (l1, l2, res = []):
            if l1 != [] and l2 != [] :
                x = l1[0]
                y = l2[0]
                if x<y:
                    del (l1[0])
                    return merge (l1, l2, res + [x])
                else:
                    del (l2[0])
                    return merge (l1, l2, res + [y])
            else:
                return res + l1 + l2
        return merge(a, b)
    elif size == 2:
        if l[0] <= l[1]:
            return l
        return [l[1], l[0]]
    return l

#example
a = []
for i in range(541):
    t = random.randint(1,1000)
    a.append (t)
print mergeSort(a)
