//
//  ViewController.swift
//  MemoryGame
//
//  Created by Francesco Merola on 24/04/23.
//

import SwiftUI

struct ViewController: View {
    
    @StateObject private var session = SessionManager()
    @StateObject var timerManager = TimerManager(countTo: 90)
    
    var body: some View {
        ZStack {
            switch session.currentState {
            case .onboarding:
                OnboardingView(action: session.completeOnboarding)
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .game:
                MemoryView(timerManager: timerManager)
                    .environmentObject(session)
                    .transition(.opacity)
            default:
                // Splash Screen
                Color.blue.ignoresSafeArea()
            }
        }
        .animation(.easeInOut, value: session.currentState)
        .onAppear(perform: session.configureInitialCurrentState)
    }
}

struct ViewController_Previews: PreviewProvider {
    
    static let timerManager = TimerManager(countTo: 100)
    
    static var previews: some View {
        ViewController(timerManager: timerManager)
    }
}
