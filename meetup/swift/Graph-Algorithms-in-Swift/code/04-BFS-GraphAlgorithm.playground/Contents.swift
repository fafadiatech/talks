import Foundation

enum Cell {
    case traversable
    case nonTraversable
}

class World {
    var height:Int
    var width: Int
    var world:[[Cell]] = [[Cell]]()
    var difficultyRatio:Float = 0.20

    // generate world at random
    func generateRandom(){
        var difficultCellCounts:Int = 0;
        for _ in 0...self.height-1{
            var current:[Cell] = [Cell]()
            var generated:Bool = false
            for _ in 0...self.width-1{
                let magicNumber = Int.random(in: 0...100)
                
                if !generated && magicNumber % 7 == 0 && (difficultCellCounts < Int(Float(self.height * self.width) * self.difficultyRatio)) {
                    current.append(Cell.nonTraversable)
                    difficultCellCounts += 1
                    generated = true
                }else{
                    current.append(Cell.traversable)
                }
                
            }
            self.world.append(current)
        }
    }
    
    init(height: Int, width: Int){
        self.height = height
        self.width = width
        self.generateRandom()
    }
    
    func render(){
        for row in 0...self.height-1{
            var current = [Int]()
            for col in 0...self.width-1{
                if(self.world[row][col] == Cell.nonTraversable){
                    current.append(1)
                }else{
                    current.append(0)
                }
            }
            print(current)
        }
    }
    
    func genChildStates(currentX: Int, currentY: Int) -> [(Int, Int)] {
        var results = [(Int, Int)]()
        // assume we're only allowed to move right and down
        // check if we can move right
        if(currentX + 1 < width && self.world[currentX + 1][currentY] == Cell.traversable){
            results.append((currentX + 1, currentY))
        }
        
        if((currentY + 1) < height && self.world[currentX][(currentY + 1)] == Cell.traversable){
            results.append((currentX, (currentY + 1)))
        }
        return results
    }

    func hasPath(startX: Int, startY: Int, endX: Int, endY: Int) -> Bool {
        // this is where we implement DFS/BFS algorithm
        var frontier:[(Int, Int)] = [(startX, startY)]
        var visitedState:[String:Bool] = [:]
        
        while(frontier.count > 0){
            let currentState:(Int, Int) = frontier.removeFirst()
            let key = "\(currentState.0):\(currentState.1)"
            
            if (visitedState[key] != nil){
                continue
            }

            if(currentState.0 == endX && currentState.1 == endY){
                return true
            }

            let childStates = self.genChildStates(currentX: currentState.0, currentY: currentState.1)
            frontier.append(contentsOf: childStates)
            visitedState[key] = true
        }
        return false
    }
}

let mars = World(height: 10, width: 10)
mars.render()
print(mars.hasPath(startX: 0, startY: 0, endX: 2, endY: 4))
