import UIKit

var str = "Hello, playground"
//
//  main.swift
//  GraphAlgorithms
//
//  Created by Sidharth Shah on 17/04/19.
//  Copyright © 2019 Sidharth Shah. All rights reserved.
//

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
    
    func genChildStates(currentX: Int, currentY: Int) -> Array<Any> {
        var results = [(Int, Int)]()
        results.append((0, 0))
        return results
    }

    func hasPath(startX: Int, startY: Int, endX: Int, endY: Int) -> Bool {
        return false
    }
}

print("Hello, World!")
let mars = World(height: 10, width: 10)
mars.render()
print(mars.hasPath(startX: 0, startY: 0, endX: 2, endY: 4))
print(mars.genChildStates(currentX: 0, currentY: 0))
