

class graph:
	
	g = {1 : [2, 3], 2: [5, 4], 3: [7], 4:[8], 5:[], 6:[8], 7:[6], 8:[]}
	color = []
	num = 0

	def dfs(self, v):
		self.color[v] = "grey"
		for u in self.g[v]:
			if self.color[u] == "white":
				self.dfs(u)
			elif self.color[u] == "grey":
				print "Cycle in this!"
				exit()
		self.num += 1
		self.color[v] = "black"
		print v
		
	
	
	def topolog(self):
		for v in self.g.keys():
			if self.color[v] == "white":
				self.dfs(v)

	def __init__(self):
		self.color = range(len(self.g)+1)
		for i in self.color:
			self.color[self.color.index(i)] = "white"
		#print self.color

a = graph()
a.topolog()

