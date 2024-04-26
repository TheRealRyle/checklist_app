//
//  Item.swift
//  1 Week Learning
//
//  Created by Kardeiz Ryle on 1/22/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
