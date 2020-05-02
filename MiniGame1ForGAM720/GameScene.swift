//
//  GameScene.swift
//  MiniGame1ForGAM720
//
//  Created by Rachel Saunders on 30/04/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//
// THIS APP IS SOLELY FOR THE PURPOSE OF ASSIGNMENT 2 FOR GAM720 MODULE AS PART OF THE MASTERS DEGREE FOR CREATIVE APP DEVELOPMENT. ALL PROGRAMMING, NOTES AND ARTWORK BY RACHEL SAUNDERS. THIS IS A TEST TO SEE HOW MINIGAMES WORK. COPYRIGHT RACHEL SAUNDERS.
//
//

import SpriteKit

// Numbers don't add to equal another e.g. 1 + 2 = 3 theres no 3 aka no colliding values
enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case bird = 8
    case finish = 16
}


class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        loadLevel()
        
        }
    
    
    func loadLevel() {
        
        // Load the level, if it fails do nothing aka crash
        // level is being loaded by letter arrangement in the file level1.txt
        
        guard let levelURL = Bundle.main.url(forResource: "level1", withExtension: "txt")
            else {
                fatalError("couldn't find level file")
        }
        
        guard let levelString = try? String(contentsOf: levelURL)
            else {
                fatalError("couldn't find level file")
        }
        
        // defining the lines
        // \n is a line break
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
               
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                if letter == "x" {
                    
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    
                } else if letter == "v" {
                    
                    let node = SKSpriteNode(imageNamed: "bird")
                    node.name = "bird"
                    node.position = position
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisionTypes.bird.rawValue
                    // When it touches the player
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    
                    addChild(node)
                    
                } else if letter == "s" {
                    
                    let node = SKSpriteNode(imageNamed: "star")
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false

                    node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    
                    addChild(node)
                    
                } else if letter == "f" {
                    
                    let node = SKSpriteNode(imageNamed: "finish")
                    node.name = "finish"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false

                    node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
                    node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    node.position = position
                    
                    addChild(node)
                    
                // Fixes error
                } else if letter == " " {
                    // Empty space
                    
                } else {
                    fatalError("Couldn't read letters from file")
                }
            }
        }
    }
        
        
}
