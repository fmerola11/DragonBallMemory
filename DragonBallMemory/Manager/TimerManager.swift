//
//  TimerManager.swift
//  MemoryGame
//
//  Created by Francesco Merola on 24/04/23.
//

import Foundation
import Combine

class TimerManager: ObservableObject {
    
    @Published var showLoseAlert: Bool = false
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    @Published var counter : Int = 0
    var countTo: Int
    
    init(countTo: Int) {
        self.countTo = countTo
    }
    
    func startTimer () {
        
        counter = 0
        
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.counter < self.countTo {
                    self.counter += 1
                } else {
                    self.showLoseAlert = true
                    self.timer.upstream.connect().cancel()
                }
            }
            .store(in: &cancellables)
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    
    private var cancellables = Set<AnyCancellable>()
}
