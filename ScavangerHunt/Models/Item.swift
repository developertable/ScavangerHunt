//
//  Item.swift
//  ScavangerHunt
//
//  Created by Rahul Kurra  & Claude on 2025-10-02.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let clue: String
    let businessName: String
    let businessType: String
    var isFound: Bool = false
    var photoData: Data? = nil
}

// Add this extension below the struct
extension Item {
    static let sampleItems: [Item] = [
        Item(
            name: "Golden Coffee Cup",
            clue: "Look for the vintage espresso machine near the counter",
            businessName: "Joe's Coffee Shop",
            businessType: "☕️ Restaurant"
        ),
        Item(
            name: "Mystery Book",
            clue: "Hidden in the science fiction section, third shelf",
            businessName: "Page Turner Books",
            businessType: "📚 Bookstore"
        ),
        Item(
            name: "Red Ticket Stub",
            clue: "Check near the popcorn machine",
            businessName: "Cinema Palace",
            businessType: "🎬 Movie Theatre"
        ),
        Item(
            name: "Vintage Record",
            clue: "Jazz section, look for albums from the 1960s",
            businessName: "Vinyl Vibes",
            businessType: "🎵 Music Store"
        ),
        Item(
            name: "Chef's Hat",
            clue: "In the kitchen display window",
            businessName: "Pasta Paradise",
            businessType: "🍝 Restaurant"
        ),
        Item(
            name: "Soccer Trophy",
            clue: "Near the running shoes display",
            businessName: "SportZone",
            businessType: "⚽️ Sports Store"
        ),
        Item(
            name: "Paint Brush",
            clue: "Look in the watercolor section",
            businessName: "Art Supply Co.",
            businessType: "🎨 Art Store"
        ),
        Item(
            name: "Telescope",
            clue: "By the astronomy books",
            businessName: "Science Shop",
            businessType: "🔬 Educational Store"
        ),
        Item(
            name: "Garden Gnome",
            clue: "Hidden among the potted plants outside",
            businessName: "Green Thumb Nursery",
            businessType: "🌱 Garden Center"
        ),
        Item(
            name: "Magic Wand",
            clue: "In the window display with board games",
            businessName: "Toy Kingdom",
            businessType: "🎲 Toy Store"
        )
    ]
}



