//
//  Characters.swift
//  starwars
//
//  Created by kaka93 on 7/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import Foundation



class CharactersWrapper {
    var characters: [Character]?
    var count: Int?
}

enum CharacterAttributes: String {
    case Name = "name"
    case Url = "url"
}

class Character {
    
    var name: String?
    var url: String?
   
    
    required init(json: [String: Any]) {
        
        self.name = json[CharacterAttributes.Name.rawValue] as? String
        self.url = json[CharacterAttributes.Url.rawValue] as? String
    }
}

