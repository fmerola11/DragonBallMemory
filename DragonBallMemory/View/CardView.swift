//
//  CardView.swift
//  MemoryGame
//
//  Created by Francesco Merola on 18/04/23.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var card: Card
    
    let width: Int
    
    @Binding var userChoices: [Card]
    @Binding var matchedCards: [Card]
    
    var body: some View {
        if card.isFaceUp || matchedCards.contains(where: {$0.id == card.id}) {
            Image(card.imageName)
                .resizable()
                .scaledToFit()
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color(red: 0.6, green: 0.83, blue: 0.96))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.red), lineWidth: 2)
                }
        } else {
            Image("Card Retro")
                .resizable()
                .scaledToFit()
                .font(.system(size: 50))
                .padding()
                .frame(width: CGFloat(width), height: CGFloat(width))
                .background(Color(red: 0.6, green: 0.83, blue: 0.96))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.18, green: 0.32, blue: 0.46), lineWidth: 1)
                }
                .onTapGesture {
                    if userChoices.count == 0 {
                        card.turnOver()
                        userChoices.append(card)
                    } else if userChoices.count == 1 {
                        card.turnOver()
                        userChoices.append(card)
                        withAnimation(Animation.linear.delay(1)) {
                            for thisCard in userChoices {
                                thisCard.turnOver()
                            }
                        }
                        checkForMatch()
                    }
                }
        }
    }
    
    func checkForMatch () {
        if userChoices[0].imageName == userChoices[1].imageName {
            matchedCards.append(userChoices[0])
            matchedCards.append(userChoices[1])
        }
        userChoices.removeAll()
    }
}

