//
//  ItemDetailView.swift
//  ScavangerHunt
//
//  Created by Rahul Kurra on 2025-10-02.
//

import SwiftUI

struct ItemDetailView: View {
    @Binding var item: Item
    @State private var showPhotoPicker = false
    @State private var selectedImage: UIImage?
    @State private var showSuccessAlert = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Item name
                Text(item.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Show captured photo if exists
                if let imageData = item.photoData,
                   let uiImage = UIImage(data: imageData) {
                    VStack(spacing: 10) {
                        Text("Your Photo:")
                            .font(.headline)
                            .foregroundColor(.green)
                        
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                }
                
                // Business info card
                VStack(spacing: 10) {
                    Label(item.businessName, systemImage: "building.2")
                        .font(.title3)
                    
                    Text(item.businessType)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                
                // Clue section
                VStack(alignment: .leading, spacing: 10) {
                    Label("Clue", systemImage: "lightbulb.fill")
                        .font(.headline)
                        .foregroundColor(.orange)
                    
                    Text(item.clue)
                        .font(.body)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // Status indicator
                HStack {
                    Image(systemName: item.isFound ? "checkmark.circle.fill" : "circle")
                        .font(.title)
                        .foregroundColor(item.isFound ? .green : .gray)
                    
                    Text(item.isFound ? "Found!" : "Not found yet")
                        .font(.headline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(item.isFound ? Color.green.opacity(0.1) : Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Photo picker button or success message
                if !item.isFound {
                    Button(action: {
                        showPhotoPicker = true
                    }) {
                        Label("Take Photo", systemImage: "photo.on.rectangle")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                } else {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("Great job! Item found!")
                            .font(.headline)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showPhotoPicker) {
            PhotoPicker(selectedImage: $selectedImage)
        }
        .onChange(of: selectedImage) { oldValue, newValue in
            if let image = newValue {
                // Convert image to data and save
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    withAnimation {
                        item.photoData = imageData
                        item.isFound = true
                    }
                    showSuccessAlert = true
                }
            }
        }
        .alert("Success! 🎉", isPresented: $showSuccessAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You found the \(item.name)!")
        }
    }
}

#Preview {
    NavigationStack {
        ItemDetailView(item: .constant(Item.sampleItems[0]))
    }
}
