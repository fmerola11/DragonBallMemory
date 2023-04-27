//
//  Card.swift
//  MemoryGame
//
//  Created by Francesco Merola on 18/04/23.
//

import Foundation

class Card: Identifiable, ObservableObject, Equatable{
    
    var id = UUID()
    @Published var isFaceUp: Bool = false
    @Published var isMatched: Bool = false
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    func turnOver() {
        self.isFaceUp.toggle()
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
            return lhs.id == rhs.id
        }
}

let imageNames: [String] = [
    "Goku", "Yamcha", "Jiaozi", "Crilin", "Gohan", "Tenshinhan", "Piccolo", "Maestro Muten", "Yajirobei", "Re Kaioh del Nord"
]

func createCardList () -> [Card] {
    // create a blank list
    var cardList = [Card]()
    
    for imageName in imageNames {
        cardList.append(Card(imageName: imageName))
        cardList.append(Card(imageName: imageName))
    }
    
    return cardList
}

let totalCards: Int = 20
