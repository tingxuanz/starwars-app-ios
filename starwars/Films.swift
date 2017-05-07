//
//  Films.swift
//  starwars
//
//  Created by kaka93 on 7/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import Foundation
import Alamofire

enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}

class FilmsWrapper {
    var films: [Films]?
    var count: Int?
//    var next: String?
//    var previous: String?
}

enum FilmAttributes: String {
    case Title = "title"
    case Director = "director"
    case ReleaseDate = "release_date"
    case OpeningCrawl = "opening_crawl"
    case Characters = "characters"
    case Url = "url"
}

class Films {
    var id: Int?
    var title: String?
    var director: String?
    var openingCrawl: String?
    var url: String?
    var characters: [String]?
    var releaseDate: String?
    
    required init(json: [String: Any]) {
        self.title = json[FilmAttributes.Title.rawValue] as? String
        self.director = json[FilmAttributes.Director.rawValue] as? String
        self.releaseDate = json[FilmAttributes.ReleaseDate.rawValue] as? String
    }
    
    //MARK: Endpoints
    class func endpointsForFilms() -> String {
        return "https://swapi.co/api/films/"
    }
    
    private class func filmsFromResponse(_ response: DataResponse<Any>) -> Result<FilmsWrapper> {
        
        //handle error
        guard response.result.error == nil else {
            return .failure(response.result.error!)
        }
        
        guard let json = response.result.value as? [String: Any] else {
            return .failure(BackendError.objectSerialization(reason: "Didn't get json dictionary in response"))
        }
        
        //parse the json
        let wrapper:FilmsWrapper = FilmsWrapper()
        wrapper.count = json["count"] as? Int
        
        var allFilms: [Films] = []
        if let results = json["results"] as? [[String: Any]] {
            for jsonFilm in results {
                let film = Films(json: jsonFilm)
                allFilms.append(film)
            }
        }
        
        wrapper.films = allFilms
        return .success(wrapper)
    }
    
    fileprivate class func getFilmsAtPath(_ path: String, completionHandler: @escaping (Result<FilmsWrapper>) -> Void) {
        guard var urlComponents = URLComponents(string: path) else {
            let error = BackendError.urlError(reason: "invalid url")
            completionHandler(.failure(error))
            return
        }
        
        //make sure https is used
        urlComponents.scheme = "https"
        
        guard let url = try? urlComponents.asURL() else {
            let error = BackendError.urlError(reason: "invalid url")
            completionHandler(.failure(error))
            return
        }
        
        let _ = Alamofire.request(url)
            .responseJSON { response in
                if let error = response.result.error {
                    completionHandler(.failure(error))
                    return
                }
                
                let filmsWarpperResult = Films.filmsFromResponse(response)
                completionHandler(filmsWarpperResult)
            }
    }
    
    class func getFilms(_ completionHandler: @escaping (Result<FilmsWrapper>) -> Void) {
        getFilmsAtPath(Films.endpointsForFilms(), completionHandler: completionHandler)
    }
    
    
}
