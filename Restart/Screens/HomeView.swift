//
//  HomeView.swift
//  Restart
//
//  Created by Oleksii Vasyliev on 05.04.2023.
//

import SwiftUI

/// View representing Hove screen.
struct HomeView: View {
    // MARK: - Properties
	
    /// Define is onboarding is active.
    @AppStorage("onboarding") var isOnboarding = false
	/// Animation state.
	@State private var isAnimating = false
	/// Audio player instance for button tap action.
	private let player = AudioPlayer()
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
			ZStack {
				BackgroundCircles(shapeColor: .gray, shapeOpacity: 0.1)
				Image("character-2")
					.resizable()
					.scaledToFit()
					.padding()
					.offset(y: isAnimating ? 35 : -35)
					.animation(Animation
						.easeOut(duration: 4)
						.repeatForever(), value: isAnimating)
			}
			
			Text("The time that leads to mastery is depend on the intensity of our focus.")
				.font(.title3)
				.fontWeight(.light)
				.foregroundColor(.secondary)
				.multilineTextAlignment(.center)
				.padding()
			
			Spacer()
			
            Button {
				withAnimation {
					player.playSound(sound: "success", type: "m4a")
					isOnboarding = true
				}
            } label: {
				Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
					.imageScale(.large)
                Text("Restart")
					.font(.system(.title3, design: .rounded))
					.fontWeight(.bold)
            }
			.buttonStyle(.borderedProminent)
			.buttonBorderShape(.capsule)
			.controlSize(.large)

        }
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
				isAnimating = true
			}
		}
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
