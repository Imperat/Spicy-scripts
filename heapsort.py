def heapsort(s):                               
    sl = len(s)                                    
 
    def swap(pi, ci):                              
        if s[pi] < s[ci]:                          
            s[pi], s[ci] = s[ci], s[pi]            
 
    def shift(pi, unsorted):                        
        i_gt = lambda a, b: a if s[a] > s[b] else b
        while pi*2+1 < unsorted:                   
            gtci = i_gt(pi*2+1, pi*2+2) if pi*2+2 < unsorted else pi*2+1            
            swap(pi, gtci)                         
            pi = gtci                              
    # heapify                                      
    for i in range((sl/2)-1, -1, -1):              
        shift(i, sl)                                
    # sort                                         
    for i in range(sl-1, 0, -1):                   
        swap(i, 0)                                 
        shift(0, i)
    return s


print heapsort([3,45,3,56,2])
