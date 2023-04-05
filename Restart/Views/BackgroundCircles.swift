//
//  BackgroundCircles.swift
//  Restart
//
//  Created by Oleksii Vasyliev on 05.04.2023.
//

import SwiftUI

/// Reusable background view with circles
struct BackgroundCircles: View {
	// MARK: - Properties.
	/// Color for the circles.
	@State var shapeColor: Color
	/// Opacity for the circles.
	@State var shapeOpacity: Double
	/// Animation state.
	@State private var isAnimating = false
	
	// MARK: - Body
    var body: some View {
		ZStack {
			Circle()
				.stroke(shapeColor.opacity(shapeOpacity), lineWidth: 40)
				.frame(width: 260, height: 260, alignment: .center)
			Circle()
				.stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
				.frame(width: 260, height: 260, alignment: .center)
		}
		.blur(radius: isAnimating ? 0 : 10)
		.opacity(isAnimating ? 1 : 0)
		.scaleEffect(isAnimating ? 1 : 0.5)
		.animation(.easeOut(duration: 1), value: isAnimating)
		.onAppear {
			isAnimating = true
		}
    }
}

struct BackgroundCircles_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("ColorBlue")
				.ignoresSafeArea()
			BackgroundCircles(shapeColor: .white, shapeOpacity: 0.2)
		}
    }
}
