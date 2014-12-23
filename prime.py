def Prime (N, matrix):
    INF = 10000000
    used = [False]*N
    min_e = [INF]*N
    sel_e = [-1]*N
    min_e[0] = 0
    sel_e[0] = 1
    res = []
    for i in range(N):
        v = -1
        for j in range(N):
            if (not used[i]) and (v == -1 or (min_e[j] < min_e[v] and v!= -1)):
                v = j
        if min_e[v] == INF:
            print "Error!"
            return False

        used[v] = True
        if sel_e[v] != -1:
            res.append((v, sel_e[v]))

        for to in range(N):
            if matrix[v][to] < min_e[to]:
                min_e[to] = matrix[v][to]
                sel_e[to] = v
    return res

tmp = Prime(3, [[0, 5, 1], [5,0,3], [1,3,0]])
print tmp
