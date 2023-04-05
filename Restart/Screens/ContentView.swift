//
//  ContentView.swift
//  Restart
//
//  Created by Oleksii Vasyliev on 12.12.2021.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    /// Define is onboarding is active.
    @AppStorage("onboarding") var isOnboarding = true
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if isOnboarding {
                OnboardingView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
