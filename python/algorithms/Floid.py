def Floid (N, S, matrix):
    for i in range(N):
        for j in range(N):
            for k in range(N):
                matrix[i][j] = min(matrix[i][j], matrix[i][k] + matrix[k][j])
    return matrix

print Floid(3, 0, [[0, 5, 1], [5,0,3], [1,3,0]])
