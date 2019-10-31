//
//  ViewController.swift
//  Set
//
//  Created by test on 27.10.2019.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game = GameSet(maxCountCardsOnTheTable: cardButtons.count)
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var labelsLastSetCards: [UILabel]!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game = GameSet(maxCountCardsOnTheTable: cardButtons.count)
        updateViewFromModel()
    }
    
    
    @IBAction func touchCardButton(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.firstIndex(of: sender)
        {
            game.selectCardAndCheckSet(at: cardNumber)

        }
        
        updateViewFromModel()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViewFromModel()
        
        //print(game.cardsOnTheTable.count)
        
    }

    private func updateViewFromModel() {
        
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = game.cardsOnTheTable[index]
            
            if let card = card, card != game.emptyCard {
                
                //button.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                
                //let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: cardColorForUI(cardColor: card!.color)]
                //button.setAttributedTitle(NSAttributedString(string: card!.description, attributes: attributes), for: UIControl.State.normal)
                
                let cardIsSelected = game.selectedCardsIndexes.contains(index)
                
                button.setTitle(card!.description, for: UIControl.State.normal)
                //button.setTitleColor(cardColorForUI(cardColor: card!.color), for: UIControl.State.normal)
                button.backgroundColor = cardColorForUI(cardColor: card!.color)
                button.layer.borderWidth = cardIsSelected ? 3 : 0
                button.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                
            } else {
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
                button.layer.borderWidth = 0
                button.setTitle("", for: UIControl.State.normal)
                //button.setAttributedTitle(NSAttributedString(string: ""), for: UIControl.State.normal)
                
            }
            
        }
        
        for index in labelsLastSetCards.indices {
            
            let label = labelsLastSetCards[index]
            
            if game.lastSetCards.indices.contains(index) {
                let card = game.lastSetCards[index]
                label.text = card.description
                label.backgroundColor = cardColorForUI(cardColor: card.color)
            } else {
                label.text = ""
                label.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0)
            }
            
            
        }
        scoresLabel.text = "Scores: \(game.scores) (cards left: \(game.deck.cards.count))"
        
    }
    
    func cardColorForUI(cardColor: PlayingCard.Color) -> UIColor {
        switch cardColor {
        case .Green:
            return #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        case .Red:
            return #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case .Violet:
            return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        }
    }

}

