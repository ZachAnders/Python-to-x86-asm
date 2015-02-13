class DSATUR:
    def __init__(self, graph, colorAmount):
        self.graph = graph
        self.saturation = {node:colorAmount for node in graph}
        self.color = {node:None for node in graph}

    def run(self):
        W = self.graph
        while W:
            node = self.getHighestSaturation(W)
            self.setColor(node)
            self.setSaturation(node)
            W.pop(node)

    def setColor(self, node):
        adj = [self.color[c] for c in self.graph[node]]
        color = 0
        while adj:
            if color in adj:
                filter(lambda element: element != color, adj)
                color += 1 
            else:
                break
        self.color[node] = color
       
    def setSaturation(self, node):
        for adj in self.graph[node]:
            self.saturation[adj] -= 1 

    def getHighestSaturation(self, W):
        lowest = (None,None)
        for node in W:
            if ( lowest == None ):
                lowest = (node,self.saturation[node])
            if ( lowest > self.saturation[node] ):
                lowest = (node,self.saturation[node])
        return lowest[0]

    def getColor(self):
        return self.color

'''g = {"w":["x","z"],"z":["x","w"],"x":["w","z","y"],"y":["x"]}
d = DSATUR(g,4)
d.run()
print d.getColor()'''