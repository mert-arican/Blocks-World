//
//  BlocksWorldModel.swift
//  Blocks World
//
//  Created by Mert Arıcan on 16.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

protocol BlockOrTable {
    
    var name: String { get }
    
    var width: Int { get }
    
}

class BlocksWorldModel {

    private let table = Table(name: "Table", blocks: Constantstinopolis.allBlocks)
    
    private(set) var graspedBlock: Block?
    
    private(set) var movements: [(Block, Position)] = [(Block, Position)]()
    
    var allBlocks: [Block] {
        return table.blocks
    }
        
    func put(block: Block, destination: BlockOrTable) {
        guard block.width <= destination.width else { return }
//        print("\(block.name) bloğu \(destination.name) üzerine koymak istedim.")
        goalTree.append("I wanted to put \(block.name) block on top of \(destination.name).")
        let destinationPos: Position
        if let destination = destination as? Block, table.getBlocksOnTopOf(block: block)?.contains(destination) ?? false {
            grasp(block: block)
            destinationPos = findSpace(on: destination, for: block)
        } else {
            destinationPos = findSpace(on: destination, for: block)
            grasp(block: block)
        }
        if graspedBlock != nil {
            move(to: destinationPos)
        }
        ungrasp()
    }
    
    func clearMovements() {
        movements = []
    }
    
    func getBlock(with name: String) -> Block {
        return allBlocks.filter { $0.name.lowercased() == name }.first!
    }
    
    private func findSpace(on destination: BlockOrTable, for block: Block) -> Position {
//        print("\(destination.name) üzerinde boşluk bulmak istedim.")
        goalTree.append("I wanted to find space on top of \(destination.name).")
        if let destination = destination as? Block {
            let destinationPos = Position(x: destination.origin.x, y: destination.origin.y + block.height)
            while let top = table.getBlocksOnTopOf(block: destination)?.first {
                getRidOf(block: top)
            }
            return destinationPos
        } else {
            return table.findSpaceOnTableFor(block: block)!
        }
    }
    
    private func clearTopOf(block: Block) {
//        print("\(block.name) bloğun üzerini temizlemek istedim.")
        goalTree.append("I wanted to clear top of \(block.name).")
        while let blockOnTop = table.getBlocksOnTopOf(block: block)?.first {
            getRidOf(block: blockOnTop)
        }
    }
    
    private func grasp(block: Block) {
        clearTopOf(block: block)
        graspedBlock = block
    }
    
    private func move(to position: Position) {
        if let graspedBlock = graspedBlock {
            movements.append((graspedBlock, position))
            graspedBlock.origin = position
        }
    }
    
    private func getRidOf(block: Block) {
//        print("\(block.name) bloktan kurtulmak istedim.")
        goalTree.append("I wanted to get rid of \(block.name).")
        put(block: block, destination: table)
    }
    
    var goalTree = [String]()
    
    private func ungrasp() {
        graspedBlock = nil
    }
    
}
