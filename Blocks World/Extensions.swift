//
//  BlocksWorldControllerExtensions.swift
//  Blocks World
//
//  Created by Mert Arıcan on 24.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import Foundation

extension String {
    
    func contains(collection: [String]) -> String? {
        for element in collection {
            if self.contains(element) {
                return element
            }
        }
        return nil
    }
    
}

extension Array where Element: Equatable {
    
    mutating func remove(element: Element) -> Element? {
        if let index = (self.firstIndex { $0 == element }) {
            return self.remove(at: index)
        }
        return nil
    }
    
}

extension StringProtocol {
    
    var words: [SubSequence] {
        return split { !$0.isLetter }
    }
    
}
