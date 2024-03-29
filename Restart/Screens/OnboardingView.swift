//
//  OnboardingView.swift
//  Restart
//
//  Created by Oleksii Vasyliev on 05.04.2023.
//

import SwiftUI

/// View representing onboarding screen.
struct OnboardingView: View {
	// MARK: - Properties
	/// Define is onboarding is active.
	@AppStorage("onboarding") var isOnboarding = true
	/// Action button width, default value is screen width - 80.
	@State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
	/// Offset for the action button.
	@State private var buttonOffset: CGFloat = 0
	/// Defines animation state.
	@State private var isAnimating = false
	/// Sets up image offset.
	@State private var imageOffset: CGSize = .zero
	/// Opacity value for the drag gesture indicator.
	@State private var indicatorOpacity = 1.0
	/// String for the screen title.
	@State private var textTitle = "Share."
	/// Audio player instance for button tap action.
	private let player = AudioPlayer()
	/// Feedbackgenerator instance to trigger haptic feedback.
	private let hapticFeedback = UINotificationFeedbackGenerator()
	
	
	// MARK: - Body
	var body: some View {
		ZStack {
			Color("ColorBlue")
				.ignoresSafeArea()
			
			VStack(spacing: 20) {
				Spacer()
				VStack(spacing: 0) {
					Text(textTitle)
						.font(.system(size: 60))
						.fontWeight(.heavy)
						.foregroundColor(.white)
						.transition(.opacity)
						.id(textTitle)
					
					Text("It's not how much we give but\nhow much we put into giving.")
						.font(.title3)
						.fontWeight(.light)
						.foregroundColor(.white)
						.multilineTextAlignment(.center)
						.padding(.horizontal, 10)
				}
				.opacity(isAnimating ? 1: 0)
				.offset(y: isAnimating ? 0 : -40)
				.animation(.easeOut(duration: 1), value: isAnimating)
				
				ZStack {
					BackgroundCircles(shapeColor: .white, shapeOpacity: 0.2)
						.offset(x: imageOffset.width * -1)
						.blur(radius: abs(imageOffset.width / 5))
						.animation(.easeOut(duration: 1), value: imageOffset)
					
					Image("character-1")
						.resizable()
						.scaledToFit()
						.opacity(isAnimating ? 1 : 0)
						.animation(.easeOut(duration: 0.5), value: isAnimating)
						.offset(x: imageOffset.width * 1.2, y: 0)
						.rotationEffect(.degrees(Double(imageOffset.width / 20)))
						.gesture(DragGesture()
							.onChanged { gesture in
								if abs(imageOffset.width) <= 150 {
									imageOffset = gesture.translation
									withAnimation(.linear(duration: 0.25)) {
										indicatorOpacity = 0
										textTitle = "Give."
									}
								}
							}
							.onEnded { _ in
								imageOffset = .zero
								withAnimation(.linear(duration: 0.25)) {
									indicatorOpacity = 1
									textTitle = "Share."
								}
							}
						)
						.animation(.easeOut(duration: 1), value: imageOffset)
				}
				.overlay(alignment: .bottom) {
					Image(systemName: "arrow.left.and.right.circle")
						.font(.system(size: 44, weight: .ultraLight))
						.foregroundColor(.white)
						.offset(y: 20)
						.opacity(isAnimating ? 1: 0)
						.animation(.easeIn(duration: 1).delay(2), value: isAnimating)
						.opacity(indicatorOpacity)
				}
				Spacer()
				ZStack {
					Capsule()
						.fill(Color.white.opacity(0.2))
					Capsule()
						.fill(Color.white.opacity(0.2))
						.padding(8)
					
					Text("Get Started")
						.font(.system(.title3, design: .rounded))
						.fontWeight(.bold)
						.foregroundColor(.white)
						.offset(x: 20)
					
					HStack {
						Capsule()
							.fill(Color("ColorRed"))
							.frame(width: buttonOffset + 80)
						Spacer()
					}
					
					HStack {
						ZStack {
							Circle()
								.fill(Color("ColorRed"))
							Circle()
								.fill(.black.opacity(0.15))
								.padding(8)
							Image(systemName: "chevron.right.2")
								.font(.system(size: 24, weight: .bold))
						}
						.foregroundColor(.white)
						.frame(width: 80, height: 80, alignment: .center)
						.offset(x: buttonOffset)
						.gesture(DragGesture()
							.onChanged { gesture in
								if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 80 {
									buttonOffset = gesture.translation.width
								}
							}
							.onEnded { _ in
								withAnimation(Animation.easeOut(duration: 0.4)) {
									if buttonOffset > buttonWidth / 2 {
										hapticFeedback.notificationOccurred(.success)
										buttonOffset = buttonWidth - 80
										isOnboarding = false
										player.playSound(sound: "success", type: "m4a")
									} else {
										hapticFeedback.notificationOccurred(.warning)
										buttonOffset = 0
									}
								}
							}
						)
						Spacer()
					}
				}
				.frame(width: buttonWidth, height: 80, alignment: .center)
				.padding()
				.opacity(isAnimating ? 1 : 0)
				.offset(y: isAnimating ? 0 : 40)
				.animation(.easeIn(duration: 1), value: isAnimating)
			}
		}
		.onAppear {
			isAnimating = true
		}
		.preferredColorScheme(.dark)
	}
}

struct OnboardingView_Previews: PreviewProvider {
	static var previews: some View {
		OnboardingView()
	}
}
