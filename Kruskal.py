def Kruskal (N, matrix):
    Tree = [[-1]*N]*N
    ListOfArcs = dict()
    cost = 0
    for i in range(N):
        for j in range(N):
            if i < j:
                if (i,j) not in ListOfArcs:
                    ListOfArcs[(i,j)] = matrix[i][j]
    ListOfArcs = ListOfArcs.items()
    ListOfArcs.sort(key = lambda x: x[1])
    Tree_id = range(1, N+1)
    for i in ListOfArcs:
        a = i[0][0]
        b = i[0][1]
        l = i[1]
        if Tree_id[a] != Tree_id[b]:
            cost += l
            Tree[a][b] = 1
            old_id = Tree_id[b]
            new_id = Tree_id[a]
            for j in range(N):
                if Tree_id[j] == old_id:
                    Tree_id[j] = new_id

    return Tree

tmp = Kruskal(3, [[0, 5, 1], [5,0,3], [1,3,0]])
for i in tmp:
    print i
