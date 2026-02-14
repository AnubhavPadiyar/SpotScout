//
//  Library.swift
//  SpotScout
//
//  Created by Anubhav on 25/01/26.
//

import Foundation

struct Library: Identifiable, Codable {
    let id: UUID
    let name: String
    var availableSpots: Int

    init(id: UUID = UUID(), name: String, availableSpots: Int) {
        self.id = id
        self.name = name
        self.availableSpots = availableSpots
    }
}

