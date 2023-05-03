//
//  ContentView.swift
//  MemoryGame
//
//  Created by Francesco Merola on 18/04/23.
//

import SwiftUI

struct MemoryView: View {
    
    @State private var showWinAlert: Bool = false
    
    var fourColumsGrid = [GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible()),
                          GridItem(.flexible())
    ]
    
    var twoColumsGrid = [GridItem(.flexible()),
                         GridItem(.flexible())
    ]
    
    @ObservedObject var timerManager: TimerManager
    
    @State var cards: [Card] = createCardList().shuffled()
    @State var matchedCards = [Card]()
    @State var userChoices = [Card]()
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                Color("Background Color").ignoresSafeArea()
                
                GeometryReader { geo in
                    VStack {
                        Text("Dragon Ball Z Memory")
                            .font(.title)
                            .foregroundColor(.red)
                        
                        LazyVGrid(columns: fourColumsGrid, spacing: 20) {
                            ForEach(cards) { card in
                                CardView(card: card, width: Int(geo.size.width)/4 - 5, userChoices: $userChoices, matchedCards: $matchedCards)
                            }
                        }
                        .padding(.horizontal, 12)
                        
                        CountdownView(timerManager: timerManager, countTo: timerManager.countTo)
                            .padding(20)
                    }
                }
                .onChange(of: matchedCards) { _ in
                    if matchedCards.count == totalCards {
                        showWinAlert = true
                        timerManager.stopTimer()
                    }
                }
                .alert(isPresented: $timerManager.showLoseAlert) {
                    Alert(
                        title: Text("Time's up!"),
                        message: Text("Oh no, Vegeta is going to destroy our planet 😭"),
                        dismissButton: .default(Text("Retry")) {
                            timerManager.startTimer()
                            matchedCards = []
                            userChoices = []
                            cards.shuffle()
                        }
                    )
                }
                .alert("Well done!", isPresented: $showWinAlert) {
                    Button("Play again") {
                        timerManager.startTimer()
                        matchedCards = []
                        userChoices = []
                        cards.shuffle()
                    }
                } message: {
                    Text("The Earth thanks you. Now the Z warriors are ready to face Vegeta! 💥")
                }
            }
        }
    }
}

struct MemoryView_Previews: PreviewProvider {
    
    static let timerManager = TimerManager(countTo: 5)
    
    static var previews: some View {
        MemoryView(timerManager: timerManager)
    }
}
