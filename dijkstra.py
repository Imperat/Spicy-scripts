def Dijkstra(N, S, matrix):
    valid = [True]*N
    weight = [1000000]*N
    weight[S] = 0
    for i in range(N):
        min_weight = 1000001
        ID_min_weight = -1
        for i in range(N):
            if valid[i] and weight[i] < min_weight:
                min_weight = weight[i]
                ID_min_weight = i
        for i in range(N):
            if weight[ID_min_weight] + matrix[ID_min_weight][i] < weight[i]:
                weight[i] = weight[ID_min_weight] + matrix[ID_min_weight][i]
        valid[ID_min_weight] = False
    return weight

print Dijkstra(3, 0, [[0, 5, 1], [5,0,3], [1,3,0]])
