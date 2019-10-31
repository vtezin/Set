//
//  Card.swift
//  Set
//
//  Created by test on 27.10.2019.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

/// playing card structure
struct PlayingCard: CustomStringConvertible, Equatable {
    
    var description: String {

        var description = ""
        for _ in 1...countOfSymbols {
            description += stringOfImage
        }
        return description
    }
    
    /// count of symbols on the card face
    let countOfSymbols: Int
    /// type of filling of the symbol
    let typeOfFilling: TypeOfFilling
    /// color of the card
    let color: Color
    /// string of image (emoji) of the symbol
    let stringOfImage: String

    enum TypeOfFilling: CaseIterable {
        case empty, painted, hatched
    }
    
    enum Color: String, CaseIterable {
        case Red = "red", Green = "green", Violet = "violet"
    }
}


