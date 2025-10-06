//
//  ItemListView.swift
//  ScavangerHunt
//
//  Created by Rahul Kurra & Claude on 2025-10-02.
//

import SwiftUI

struct ItemListView: View {
    @Binding var items: [Item]
    
    var foundCount: Int {
        items.filter { $0.isFound }.count
    }
    
    var body: some View {
        List {
            // Progress section at top
            Section {
                VStack(spacing: 10) {
                    HStack {
                        Text("Progress")
                            .font(.headline)
                        Spacer()
                        Text("\(foundCount) / 10")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(foundCount == 10 ? .green : .blue)
                    }
                    
                    ProgressView(value: Double(foundCount), total: 10.0)
                        .tint(foundCount == 10 ? .green : .blue)
                }
                .padding(.vertical, 5)
            }
            
            // Items list
            Section {
                ForEach(items.indices, id: \.self) { index in
                    NavigationLink(destination: ItemDetailView(item: $items[index])) {
                        ItemRow(item: items[index])
                    }
                }
            } header: {
                Text("Items to Find")
                    .font(.headline)
            }
        }
        .navigationTitle("Scavenger Hunt")
        .navigationBarTitleDisplayMode(.large)
    }
}

// Custom row for each item
struct ItemRow: View {
    let item: Item
    
    var body: some View {
        HStack(spacing: 15) {
            // Icon - shows checkmark if found, circle if not
            Image(systemName: item.isFound ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundColor(item.isFound ? .green : .gray)
            
            // Item information
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.businessName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(item.businessType)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            // Show "Found" badge and thumbnail if item is found
            if item.isFound {
                VStack(spacing: 5) {
                    if let imageData = item.photoData,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    Text("Found")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    NavigationStack {
        ItemListView(items: .constant(Item.sampleItems))
    }
}
