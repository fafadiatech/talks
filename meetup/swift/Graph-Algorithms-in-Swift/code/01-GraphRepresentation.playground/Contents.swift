// Simplest way to re-present graphs are using Adjacency List

// Lets say we have 4 node graph as follows
// A -> B -> C
//      |-> D
// this can be re-presented as

class Graph {
    var adjacencyList: [String: [String]] = [:]
    
    func addConnection(sourceNode: String, destinationNode: String){
        if adjacencyList[sourceNode] == nil{
           adjacencyList[sourceNode] = [destinationNode]
        }else{
            adjacencyList[sourceNode]?.append(destinationNode)
        }
    }
    
    func isChild(parentNode: String, childNode:String) -> Bool {
        return adjacencyList.keys.contains(parentNode) && (adjacencyList[parentNode]?.contains(childNode))!
    }
}

var toyGraph = Graph()
toyGraph.addConnection(sourceNode: "A", destinationNode: "B")
toyGraph.addConnection(sourceNode: "B", destinationNode: "C")
toyGraph.addConnection(sourceNode: "B", destinationNode: "D")
toyGraph.isChild(parentNode: "A", childNode: "C")
toyGraph.isChild(parentNode: "B", childNode: "C")
