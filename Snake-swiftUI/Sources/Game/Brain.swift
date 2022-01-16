//
//  Brain.swift
//  Snake-swiftUI
//
//  Created by Tudor Octavian Ana on 16.01.2022.
//

import UIKit


class Brain {
    
    var snakePositions: [CGPoint] = []
    var mapSize = CGSize(width: 1, height: 1)
    
    func getDirection(to destination: CGPoint?) -> Direction? {
        guard let destination = destination else { return nil }
        let directionDistances = getNeighbors(for: snakePositions)
            .map { neighbor in
                return (neighbor.key, distance(startPosition: neighbor.value, destination: destination))
            }
            .sorted(by: {
                $0.1 < $1.1
            })
        guard let minimumDirectionDistance = directionDistances.first else { return nil }
        return minimumDirectionDistance.0
    }
    
    func getNeighbors(for snakePositions: [CGPoint]) -> [Direction: CGPoint] {
        guard let snakeHead = snakePositions.first else { return [:] }
        let leftPosition = CGPoint(x: (snakeHead.x - 1 < 0) ? CGFloat(Int(mapSize.width - 1)) : snakeHead.x - 1, y: snakeHead.y)
        let upPosition = CGPoint(x: snakeHead.x, y: (snakeHead.y - 1 < 0) ? CGFloat(Int(mapSize.height - 1)) : snakeHead.y - 1)
        let rightPosition = CGPoint(x: (snakeHead.x + 1 > CGFloat(Int(mapSize.width - 1))) ? 0 : snakeHead.x + 1, y: snakeHead.y)
        let downPosition = CGPoint(x: snakeHead.x, y: (snakeHead.y + 1 > CGFloat(Int(mapSize.height - 1))) ? 0 : snakeHead.y + 1)
        
        return [.left: leftPosition, .up: upPosition, .right: rightPosition, .down: downPosition]
            .filter {
                !snakePositions.contains($0.value)
            }
    }
    
    func distance(startPosition: CGPoint, destination: CGPoint) -> Int {
        let squaredDistance = (startPosition.x - destination.x) * (startPosition.x - destination.x) +
        (startPosition.y - destination.y) * (startPosition.y - destination.y)
        return Int(sqrt(Double(squaredDistance)))
    }
}





//class Brain {
//
//    func direction(to foodPosition: CGPoint, from position: CGPoint) -> Direction {
//        var directions: [(CGFloat, Direction)] = []
//
//        let neighbors: [(CGPoint, Direction)] = [
//            (CGPoint(x: position.x + GameViewModel.snakeSize, y: position.y), .right),
//            (CGPoint(x: position.x, y: position.y + GameViewModel.snakeSize), .up),
//            (CGPoint(x: position.x - GameViewModel.snakeSize, y: position.y), .left),
//            (CGPoint(x: position.x, y: position.y - GameViewModel.snakeSize), .down)
//        ]
//
//        neighbors.forEach { neighbor in
//            directions.append((distance(from: neighbor.0, to: foodPosition), neighbor.1))
//        }
//
//        directions = directions.sorted(by: { $0.0 < $1.0 })
//        print(directions)
//        if let shortestDirection = directions.first?.1 {
//            print(shortestDirection)
//            return shortestDirection
//        }
//        return .right
//    }
//
//    private func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
//        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
//    }
//
//    private func distance(from: CGPoint, to: CGPoint) -> CGFloat {
//        return sqrt(CGPointDistanceSquared(from: from, to: to))
//    }
//}
