//
//  ContentView.swift
//  ScavangerHunt
//
//  Created by Rahul Kurra on 2025-10-01.
//

import SwiftUI

struct ContentView: View {
    @State private var items = Item.sampleItems
    @State private var showMilestoneAlert = false
    @State private var milestoneMessage = ""
    
    // Computed property to calculate found items
    var foundCount: Int {
        items.filter { $0.isFound }.count
    }
    
    // Check if hunt is complete
    var isHuntComplete: Bool {
        foundCount == 10
    }
    
    // Get reward message based on progress
    var rewardMessage: String {
        if foundCount >= 10 {
            return "🏆 All items found! You've earned 20% discount + $5000 grand prize entry!"
        } else if foundCount >= 7 {
            return "💰 Great progress! You've earned 20% discount!"
        } else if foundCount >= 5 {
            return "🎁 Nice work! You've earned 10% discount!"
        } else {
            return ""
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "map.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(Color.blue)
                
                //Title
                Text("Scavenger Hunt")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .cornerRadius(16)
                
                //Subtitle
                Text("Find 10 Hidden items")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.green)
                    .foregroundStyle(Color.white)
                    .cornerRadius(16)
                
                //Rewards Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Rewards")
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    RewardRow(
                        icon: "🎁",
                        text: "Find 5+ items → 10% discount",
                        isAchieved: foundCount >= 5
                    )
                    RewardRow(
                        icon: "💰",
                        text: "Find 7+ items → 20% discount",
                        isAchieved: foundCount >= 7
                    )
                    RewardRow(
                        icon: "🌟",
                        text: "Find all 10 → $5000 grand prize",
                        isAchieved: foundCount >= 10
                    )
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                
                // Progress indicator
                if foundCount > 0 {
                    VStack(spacing: 10) {
                        Text("Progress: \(foundCount) / 10 items found")
                            .font(.headline)
                            .foregroundColor(.blue)
                        
                        ProgressView(value: Double(foundCount), total: 10.0)
                            .tint(foundCount >= 10 ? .green : .blue)
                        
                        // Show reward message if milestone reached
                        if !rewardMessage.isEmpty {
                            Text(rewardMessage)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(foundCount >= 10 ? .green : foundCount >= 7 ? .orange : .blue)
                                .multilineTextAlignment(.center)
                                .padding(.top, 5)
                        }
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                }
                
                // Start Hunt or Continue Hunt button
                if !isHuntComplete {
                    NavigationLink(destination: ItemListView(items: $items)) {
                        Label(
                            foundCount > 0 ? "Continue Hunt" : "Start Hunt",
                            systemImage: foundCount > 0 ? "arrow.right.circle.fill" : "play.circle.fill"
                        )
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                } else {
                    // Hunt completed - show completion message
                    VStack(spacing: 15) {
                        HStack {
                            Image(systemName: "trophy.fill")
                                .font(.title)
                                .foregroundColor(.yellow)
                            Text("Hunt Completed!")
                                .font(.title2)
                                .fontWeight(.bold)
                            Image(systemName: "trophy.fill")
                                .font(.title)
                                .foregroundColor(.yellow)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(12)
                        
                        // View Results button
                        NavigationLink(destination: ItemListView(items: $items)) {
                            Label("View Results", systemImage: "list.bullet.clipboard")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                        
                        // Restart Hunt button
                        Button(action: {
                            restartHunt()
                        }) {
                            Label("Restart Hunt", systemImage: "arrow.clockwise")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .cornerRadius(12)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .onChange(of: foundCount) { oldValue, newValue in
            checkMilestone(oldCount: oldValue, newCount: newValue)
        }
        .alert("Milestone Reached! 🎉", isPresented: $showMilestoneAlert) {
            Button("Awesome!", role: .cancel) { }
        } message: {
            Text(milestoneMessage)
        }
    }
    
    // Function to check if milestone was reached
    func checkMilestone(oldCount: Int, newCount: Int) {
        if oldCount < 5 && newCount >= 5 {
            milestoneMessage = "Congratulations! You've found 5 items and earned a 10% discount code!"
            showMilestoneAlert = true
        } else if oldCount < 7 && newCount >= 7 {
            milestoneMessage = "Amazing! You've found 7 items and earned a 20% discount code!"
            showMilestoneAlert = true
        } else if oldCount < 10 && newCount >= 10 {
            milestoneMessage = "Incredible! You've found all 10 items! You've earned a 20% discount code AND been entered into the $5000 grand prize draw!"
            showMilestoneAlert = true
        }
    }
    
    // Function to restart the hunt
    func restartHunt() {
        withAnimation {
            items = Item.sampleItems  // Reset to fresh data
        }
    }
}

#Preview {
    ContentView()
}

struct RewardRow: View {
    let icon: String
    let text: String
    var isAchieved: Bool = false
    
    var body: some View {
        HStack (spacing: 10) {
            Text(icon)
                .font(.largeTitle)
            Text(text)
                .font(.body)
                .strikethrough(isAchieved, color: .green)
                .foregroundColor(isAchieved ? .green : .primary)
            
            Spacer()
            
            if isAchieved {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            }
        }
    }
}
