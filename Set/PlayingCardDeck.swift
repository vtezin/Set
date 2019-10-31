//
//  PlayingCardDeck.swift
//  Set
//
//  Created by test on 27.10.2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

/// structure of the playing cards deck
struct PlayingCardDeck {
    
    private let setsOfPlayingCards = ["😀🥶👽", "🐸🐡🦔", "🎃👻🍏", "🚗🚎🚜"]
    private(set) var cards = [PlayingCard]()
    var isEmpty: Bool { return cards.isEmpty }
    
    mutating func drawOneCard() -> PlayingCard {
        return cards.remove(at: Int.random(in: 0..<cards.count))
    }
    
    
    init() {
        
        // choose random set of the cards
        let setOfPlayingCards = setsOfPlayingCards.randomElement()!
        let arrayOfImageChars = Array(setOfPlayingCards)
        
        // filling the deck by cards
        for color in PlayingCard.Color.allCases {
            
            for countOfSymbols in 1...arrayOfImageChars.count {
                
                for imageChar in arrayOfImageChars {
                    cards.append(PlayingCard(countOfSymbols: countOfSymbols,
                                             typeOfFilling: .empty,
                                             color: color,
                                             stringOfImage: String(imageChar)))
                }
                
            }
        }
        
        // shuffle cards in the deck
        cards.shuffle()
        
    }
}
