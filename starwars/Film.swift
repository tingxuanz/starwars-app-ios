//
//  Films.swift
//  starwars
//
//  Created by kaka93 on 7/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import Foundation




class FilmsWrapper {
    var films: [Film]?
    var count: Int?
}

enum FilmAttributes: String {
    case Title = "title"
    case Director = "director"
    case ReleaseDate = "release_date"
    case OpeningCrawl = "opening_crawl"
    case Characters = "characters"
    case Url = "url"
}

class Film {
    var title: String?
    var director: String?
    var openingCrawl: String?
    var characters: [String]?
    var releaseDate: String?
    
    required init(json: [String: Any]) {
        self.title = json[FilmAttributes.Title.rawValue] as? String
        self.director = json[FilmAttributes.Director.rawValue] as? String
        self.releaseDate = json[FilmAttributes.ReleaseDate.rawValue] as? String
        self.openingCrawl = json[FilmAttributes.OpeningCrawl.rawValue] as? String
        
        self.characters = json[FilmAttributes.Characters.rawValue] as? [String]
    }
    
}
