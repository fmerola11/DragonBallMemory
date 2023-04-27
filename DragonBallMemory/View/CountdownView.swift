//
//  CountdownView.swift
//  MemoryGame
//
//  Created by Francesco Merola on 24/04/23.
//

import SwiftUI

struct CountdownView: View {
    
    @ObservedObject var timerManager: TimerManager
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    @State private var counter: Int = 0
    var countTo: Int // seconds
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 150, height: 150)
                    .overlay(
                        Circle().stroke(Color(red: 0.6, green: 0.83, blue: 0.96), lineWidth: 25)
                    )
                
                Circle()
                    .fill(Color.clear)
                    .frame(width: 150, height: 150)
                    .overlay(
                        Circle().trim(from: 0, to: progress())
                            .stroke(
                                style: StrokeStyle (
                                    lineWidth: 25,
                                    lineCap: .round,
                                    lineJoin: .round)
                            )
                    )
                    .foregroundColor(
                        (completed() ? Color.red: Color.white)
                    )
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.2)) {}
                    }
                Clock(timerManager: timerManager, countTo: countTo)
            }
        }
        .onAppear {
            timerManager.startTimer()
            
        }
        .onReceive(timer) { time in
            if (self.counter < self.countTo) {
                self.counter += 1
            } else {
                self.timer.upstream.connect().cancel()
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(timerManager.counter) / CGFloat(countTo))
    }
}

struct Clock: View {
    
    @ObservedObject var timerManager: TimerManager

    var countTo: Int
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 30))
                .fontWeight(.medium)
                .foregroundColor(.red)
        }
    }
    
    func counterToMinutes() -> String {
        
        if timerManager.counter >= countTo {
            return "Time out"
        } else {
            let currentTime = countTo - timerManager.counter
            let seconds = currentTime % 60
            let minutes = Int(currentTime / 60)
            
            return "\(minutes) : \(seconds < 10 ? "0" : "")\(seconds)"
        }
    }
}

//struct CountdownView_Previews: PreviewProvider {
//    
//    static let timerManager = TimerManager(countTo: 10)
//    static var previews: some View {
//        CountdownView(countTo: 5)
//    }
//}
