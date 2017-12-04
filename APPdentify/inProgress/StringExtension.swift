//
//  StringHelper.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/4/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation

extension String {
    
    func removeExtraWhiteSpaces() -> String {
        var newString = ""
        // first space we've seen since the last character
        var isFirstSpace = true
        for character in trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters {
            
            if character != " " {
                newString.append(character)
                // New characters will reset our variable
                isFirstSpace = true
            } else {
                // Add the space if it is the first one
                if isFirstSpace { newString.append(character) }
                // After we add a space we know the next one can't be the first
                isFirstSpace = false
            }
            
        }
        
        return newString
    }
    
    func removeDoubleSpace() -> String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
}
