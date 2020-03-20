//
//  Constantstinopolis.swift
//  Blocks World
//
//  Created by Mert Arıcan on 16.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct Constantstinopolis {
    
    static let names = ["turquoise", "brown", "blue", "green", "orange", "purple", "red", "yellow"]
    
    static let allBlocks: [Block] = [
        Block(name: "Turquoise", width: 1, height: 1, origin: Position(x: 1, y: 2), color: .black),
        Block(name: "Brown", width: 1, height: 1, origin: Position(x: 1, y: 1), color: .brown),
        Block(name: "Blue", width: 2, height: 2, origin: Position(x: 2, y: 2), color: .blue),
        Block(name: "Green", width: 1, height: 1, origin: Position(x: 4, y: 1), color: .green),
        Block(name: "Orange", width: 1, height: 2, origin: Position(x: 5, y: 2), color: .orange),
        Block(name: "Purple", width: 2, height: 1, origin: Position(x: 6, y: 1), color: .purple),
        Block(name: "Red", width: 1, height: 1, origin: Position(x: 8, y: 1), color: .red),
        Block(name: "Yellow", width: 1, height: 2, origin: Position(x: 9, y: 2), color: .yellow)
    ]
    
    static let pilePositions: [String : Position] = [
        "Turquoise" : Position(x: 2, y: 3),
        "Brown" : Position(x: 6, y: 2),
        "Blue" : Position(x: 2, y: 2),
        "Green" : Position(x: 5, y: 3),
        "Orange" : Position(x: 5, y: 2),
        "Purple" : Position(x: 6, y: 1),
        "Red" : Position(x: 6, y: 3),
        "Yellow" : Position(x: 7, y: 3),
    ]
    
}
