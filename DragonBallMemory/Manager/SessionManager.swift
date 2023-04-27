//
//  ViewController.swift
//  MemoryGame
//
//  Created by Francesco Merola on 24/04/23.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum CurrentState {
        case onboarding
        case game
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func configureInitialCurrentState () {
        currentState = .onboarding
    }
    
    func completeOnboarding() {
        currentState = .game
    }
}



