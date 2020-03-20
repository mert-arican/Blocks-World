//
//  BlockView.swift
//  Blocks World
//
//  Created by Mert Arıcan on 24.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import UIKit

class BlockView: UIView {

    var block: Block!

}

extension CGPoint {
    
    func offsetby(x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: self.x + x, y: self.y + y)
    }
    
}
