//
//  ContentView.swift
//  CatLepa
//
//  Created by GMachine on 08/11/2024.
//

import SwiftUI

struct ContentView: View {
    // List of image names (make sure these images are added to your assets)
    let images = ["lepa1", "lepa2", "lepa3", "lepa4", "lepa5"]
    
    // Array to keep track of each cat's image, position, and animation states
    @State private var displayedCats: [(image: String, xOffset: CGFloat, yOffset: CGFloat, rotation: Double)] = []
    
    // Used to randomly select an image
    @State private var currentImageIndex = 0

    var body: some View {
        ZStack {
            ForEach(0..<displayedCats.count, id: \.self) { index in
                let cat = displayedCats[index]
                
                Image(cat.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250) // Adjust size as needed
                    .position(x: cat.xOffset, y: cat.yOffset) // Place cat at random position
                    .rotationEffect(.degrees(cat.rotation))
                    .animation(
                        Animation.easeInOut(duration: 2.0) // Slower for more subtle effect
                            .repeatForever(autoreverses: true),
                        value: cat.xOffset
                    )
                    .onAppear {
                        // Set initial side-to-side movement and rotation for each cat
                        displayedCats[index].xOffset += 2 // Subtle side-to-side movement
                        displayedCats[index].rotation = displayedCats[index].rotation == 2 ? -2 : 2 // Alternate rotation direction
                    }
            }
        }
        .contentShape(Rectangle()) // Makes the entire screen tappable
        .onTapGesture {
            addNewCat()
        }
        .onAppear {
            // Start with one cat on the screen
            addNewCat()
        }
    }
    
    func addNewCat() {
        // Randomly select a cat image
        let newCatImage = images[currentImageIndex]
        
        // Update the image index to show a new cat next time
        currentImageIndex = (currentImageIndex + 1) % images.count
        
        // Generate random position within screen bounds
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let randomX = CGFloat.random(in: 100...(screenWidth - 100))
        let randomY = CGFloat.random(in: 100...(screenHeight - 100))
        
        // Initial small rotation for animation
        let initialRotation: Double = 2
        
        // Add the new cat with a random position and initial rotation
        displayedCats.append((image: newCatImage, xOffset: randomX, yOffset: randomY, rotation: initialRotation))
    }
}

#Preview {
    ContentView()
}
