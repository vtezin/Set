//
//  GameSet.swift
//  Set
//
//  Created by test on 28.10.2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

/// game structure
struct GameSet {
    
    /// deck of playing cards
    private(set) var deck = PlayingCardDeck()
    /// cards on the table, the key in dictionary is the index of the card button
    private(set) var cardsOnTheTable = [Int: PlayingCard?]()
    /// indexes of the current srelected cards
    private(set) var selectedCardsIndexes = [Int]()
    /// max cjunt cards on the table
    let maxCountCardsOnTheTable: Int?
    /// empty card
    let emptyCard = PlayingCard(countOfSymbols: 0,
                                typeOfFilling: .empty,
                                color: .Green,
                                stringOfImage: "")
    
    /// cards of the last detected set
    private(set) var lastSetCards = [PlayingCard]()
    
    /// current scores in the game
    private(set) var scores = 0
    
    init(maxCountCardsOnTheTable: Int?) {
        
        self.maxCountCardsOnTheTable = maxCountCardsOnTheTable
        
        if let maxCountCardsOnTheTable = maxCountCardsOnTheTable {
            //добавляем на стол заданное количество карт
            drawCardsOnTheTable(countNewCards: maxCountCardsOnTheTable)
        } else {
            //добавляем на стол всю колоду
            drawCardsOnTheTable(countNewCards: deck.cards.count)
        }
        
    }
    
    /// drawing new cards on the table
    /// - Parameter countNewCards: countNewCards количество новых карт
    mutating func drawCardsOnTheTable(countNewCards: Int) {
        
        guard !deck.isEmpty else { return }
        
        var cardsRequired = countNewCards
        
        while cardsRequired > 0 && !deck.isEmpty {
            
            let takenCard = deck.drawOneCard()
            
            // first fill in the "empty spaces" in the current cards
            // on the table
            let keysOfNills = cardsOnTheTable.filter { $1 == emptyCard }.map { $0.0 }
            
            if keysOfNills.count > 0 {
                cardsOnTheTable[keysOfNills[0]] = takenCard
            } else {
                // adding new card on the table
                cardsOnTheTable[cardsOnTheTable.count] = takenCard
            }
            
            cardsRequired -= 1
        }
        
    }
    
    /// checking that Set is come
    /// - Parameter cardsSelected: array of selected cards
    private func setIsFounded() -> Bool {
        
        guard selectedCardsIndexes.count == 3 else {
            return false
        }
        
        let selectedCard1 = cardsOnTheTable[selectedCardsIndexes[0]]!!
        let selectedCard2 = cardsOnTheTable[selectedCardsIndexes[1]]!!
        let selectedCard3 = cardsOnTheTable[selectedCardsIndexes[2]]!!
        
        let setByCount = (selectedCard1.countOfSymbols == selectedCard2.countOfSymbols
            && selectedCard2.countOfSymbols == selectedCard3.countOfSymbols)
            || (selectedCard1.countOfSymbols != selectedCard2.countOfSymbols
                && selectedCard2.countOfSymbols != selectedCard3.countOfSymbols
                && selectedCard1.countOfSymbols != selectedCard3.countOfSymbols)
        
        let setByTypeOfSymbols = (selectedCard1.stringOfImage == selectedCard2.stringOfImage
            && selectedCard2.stringOfImage == selectedCard3.stringOfImage)
            || (selectedCard1.stringOfImage != selectedCard2.stringOfImage
                && selectedCard2.stringOfImage != selectedCard3.stringOfImage
                && selectedCard1.stringOfImage != selectedCard3.stringOfImage)
        
        let setByColor = (selectedCard1.color == selectedCard2.color
            && selectedCard2.color == selectedCard3.color)
            || (selectedCard1.color != selectedCard2.color
                && selectedCard2.color != selectedCard3.color
                && selectedCard1.color != selectedCard3.color)
        
        return setByColor && setByCount && setByTypeOfSymbols
        
    }
    
    
    /// selecting the card & checking set
    /// - Parameter index: index of the selected card
    mutating func selectCardAndCheckSet(at index: Int) {
        
        if selectedCardsIndexes.contains(index) {
            // the card is already selected
            // unselect the card
            
            let indexInSelectedCards = selectedCardsIndexes.firstIndex(of: index)
            selectedCardsIndexes.remove(at: indexInSelectedCards!)
            return
            
        }
        
        // if 3 cards are already open, then apparently there is no set
        // (it is checked when the card is opened) - clear the selected cards
        if selectedCardsIndexes.count == 3 {
            selectedCardsIndexes.removeAll()
        }
        
        // adding new card to selected cards
        if selectedCardsIndexes.contains(index) == false {
            selectedCardsIndexes.append(index)
        }
        
        // if this is the third card, then we need to check for a set
        if selectedCardsIndexes.count == 3 {
            
            if setIsFounded() {
                // adding scores
                scores += 1
                // remember the last cards of the set
                lastSetCards.removeAll()
                for selectedCardIndex in selectedCardsIndexes {
                    lastSetCards.append(cardsOnTheTable[selectedCardIndex]!!)
                }
                
                // delete cards of the detecting set from the table
                for indexOfSelectedCard in selectedCardsIndexes {
                    cardsOnTheTable[indexOfSelectedCard] = emptyCard
                }
                // clean selected cards array
                selectedCardsIndexes.removeAll()
                // draw 3 new cards
                drawCardsOnTheTable(countNewCards: 3)
            } else {
                // score reduction
                scores = scores > 0 ? (scores - 1) : scores
            }
            
        }
        
        
    }
    
}








