//
//  Block.swift
//  Blocks World
//
//  Created by Mert Arıcan on 16.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

class Block: BlockOrTable, Equatable, CustomStringConvertible {
    
    var description: String {
        return name
    }
    
    static func == (lhs: Block, rhs: Block) -> Bool {
        return lhs.name == rhs.name
    }
    
    let name: String
    
    let width: Int
    
    let height: Int
    
    let color: Color
    
    var origin: Position
    
    init(name: String, width: Int, height: Int, origin: Position, color: Color) {
        self.name = name ; self.width = width ; self.color = color
        self.height = height ; self.origin = origin
    }
    
    enum Color {
        
        case black
        case brown
        case blue
        case green
        case orange
        case purple
        case red
        case yellow
        
    }
    
}
