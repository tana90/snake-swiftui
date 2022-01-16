//
//  GameViewModel.swift
//  Snake-swiftUI
//
//  Created by Tudor Octavian Ana on 16.01.2022.
//

import SwiftUI

class GameViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var gameRunning: Bool = true
    @Published var direction: Direction = .right
    @Published var snakePositions: [CGPoint]
    @Published var foodPosition: CGPoint
    @Published var timer = Timer.publish(every: 0.1, on: .current, in: .common).autoconnect()
    @Published var autoPilot = false
    static var snakeSize: CGFloat = 10
    private let brain = Brain()
    
    init() {
        snakePositions = [CGPoint(x: 0 + Self.snakeSize / 2, y: 0 + Self.snakeSize / 2),
                          CGPoint(x: Self.snakeSize + Self.snakeSize / 2, y: 0 + Self.snakeSize / 2),
                          CGPoint(x: Self.snakeSize * 2 + Self.snakeSize / 2, y: 0 + Self.snakeSize / 2)].reversed()
        foodPosition = CGPoint(x: Self.snakeSize * 10 + Self.snakeSize / 2, y: Self.snakeSize * 8 + Self.snakeSize / 2)
    }
    
    func move(in geometry: GeometryProxy) {
        
        if autoPilot {
            brain.snakePositions = snakePositions
            brain.mapSize = geometry.size
            if let unwrappedDirection = brain.getDirection(to: foodPosition) {
                direction = unwrappedDirection
            }
        }
        
        let containerSize = geometry.size
        var prev = snakePositions[0]
        
        if snakePositions[0].x <= 0 { snakePositions[0].x = containerSize.width + Self.snakeSize / 2 } else
        if snakePositions[0].x > containerSize.width { snakePositions[0].x = 0 + Self.snakeSize / 2 } else
        if snakePositions[0].y <= 0 { snakePositions[0].y = containerSize.height + Self.snakeSize / 2 } else
        if snakePositions[0].y > containerSize.height { snakePositions[0].y = 0 + Self.snakeSize / 2 }

        if snakePositions[0].x == foodPosition.x && snakePositions[0].y == foodPosition.y {
            snakePositions.append(prev)
            setFoodPosition(in: geometry)
        }
        
        switch direction {
        case .up:
            snakePositions[0].y -= Self.snakeSize
        case .down:
            snakePositions[0].y += Self.snakeSize
        case .left:
            snakePositions[0].x -= Self.snakeSize
        case .right:
            snakePositions[0].x += Self.snakeSize
        }
        
        for index in 1..<snakePositions.count {
            let current = snakePositions[index]
            snakePositions[index] = prev
            prev = current
        }
    }
    
    func setFoodPosition(in geometry: GeometryProxy) {
        let rows = Int(geometry.size.width / Self.snakeSize)
        let cols = Int(geometry.size.height / Self.snakeSize)
        
        let randomX = Int.random(in: 1..<rows) * Int(Self.snakeSize) + Int(Self.snakeSize) / 2
        let randomY = Int.random(in: 1..<cols) * Int(Self.snakeSize) + Int(Self.snakeSize) / 2
        foodPosition = CGPoint(x: randomX, y: randomY)
    }
    
    func reset() {
        direction = .right
        snakePositions = [CGPoint(x: 0 + Self.snakeSize / 2, y: 0 + Self.snakeSize / 2),
                          CGPoint(x: Self.snakeSize + Self.snakeSize / 2, y: 0 + Self.snakeSize / 2),
                          CGPoint(x: Self.snakeSize * 2 + Self.snakeSize / 2, y: 0 + Self.snakeSize / 2)]
        timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    }
}
