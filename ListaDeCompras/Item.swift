//
//  Item.swift
//  ListaDeCompras
//
//  Created by Denys Fernandes on 11/12/24.
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
