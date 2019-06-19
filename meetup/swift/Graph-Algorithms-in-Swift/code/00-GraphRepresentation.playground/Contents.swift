// Simplest way to re-present graphs are using Adjacency Matrix

// Lets say we have 4 node graph as follows
// A -> B -> C
//      |-> D
// this can be re-presented as

var adjacencyMatrix = [
    [0, 1, 0, 0],
    [0, 0, 1, 1],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
]

var nodeNameMappings = ["A", "B", "C", "D"]

func getOutDegree(nodeIndex: Int) -> Int {
    let row = adjacencyMatrix[nodeIndex]
    let result:Int = row.reduce(0, +)
    return result
}

let nodeToCheck:Int = 1
print("Node: \(nodeNameMappings[nodeToCheck])'s out degree is \(getOutDegree(nodeIndex: nodeToCheck))")
