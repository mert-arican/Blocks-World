//
//  Table.swift
//  Blocks World
//
//  Created by Mert Arıcan on 16.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

struct Table: BlockOrTable {
    
    let width: Int = 10 //Multiplier of the width. BlockOrTable protocol requirement.
    
    let name: String
    
    let blocks: [Block]
    
    func findSpaceOnTableFor(block: Block) -> Position? {
        for x in 0...9 {
            let width = block.width
            var appropriate = true
            for w in 0..<width {
                if thereIsABlockAt(given: x+w) {
                    appropriate = false
                    break
                }
            }
            if appropriate { return Position(x: x, y: block.height) }
        }
        return nil
    }
    
    func getBlocksOnTopOf(block: Block) -> [Block]? {
        let blockWidth = block.origin.x ..< block.origin.x + block.width
        let higherBlocks = (blocks.filter { blockWidth.contains($0.origin.x) && $0.origin.y > block.origin.y }).sorted { $0.origin.y > $1.origin.y }
        return (higherBlocks != []) ? higherBlocks : nil
    }
    
    private func thereIsABlockAt(given x: Int) -> Bool {
        for i in 0...9 {
            let blocksX = blocks.filter { $0.origin.x == i }
            if blocksX != [] {
                let maxWidth = blocksX.max { a, b in a.width < b.width }!.width
                let range = i..<i+maxWidth
                if range.contains(x) { return true }
            }
        }
        return false
    }
    
}
