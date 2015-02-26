class DSATUR:
    def __init__(self, graph, unspillableSlots):
        self.graph = graph
        self.unspillableSlots = unspillableSlots
        self.color = {node:None for node in graph}
        self.saturation = {node:0 for node in graph}
        self.failedNode = None

    def markUnspillable(self):
        for node in self.graph:
            if not node.canSpill():
                self.setColor(node)
                self.checkValue(node)

        
    def run(self):
        self.markUnspillable()
        W = self.graph
        while W:
            node = self.getHighestSaturation(W)
            if self.color[node] == None:
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

    def checkValue(self, node):
        if ( self.color[node] >= self.unspillableSlots):
            self.failedNode = node
            print node
            node.printAllocation()
            raise ValueError('Cannot resolve graph')
       
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

    def getFailedNode(self):
        return self.failedNode

'''
#g = {"w":["x","z"],"z":["x","w"],"x":["w","z","y"],"y":["x"]}
#g = {"w":["x","z"],"z":["x","w","v","y"],"x":["w","z","y"],"y":["x","v","z"],"v":["y","z"]}
#g = {"w":["x","z","v"],"z":["x","w","v","y"],"x":["w","z","y"],"y":["x","v","z"],"v":["y","z","w"]}
g = {"x":["a","b","c","d"],"a":["x","b","c","d"],"b":["a","x","c","d"],"c":["a","b","x","d"],"d":["a","b","c","x"]}
d = DSATUR(g,4)
try:
    d.run()
    print d.getColor()
except ValueError:
    print d.getFailedNode()
'''
