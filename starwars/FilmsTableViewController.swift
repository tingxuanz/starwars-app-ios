//
//  FilmsTableViewController.swift
//  starwars
//
//  Created by kaka93 on 7/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import UIKit
import Alamofire


class FilmsTableViewController: UITableViewController {
    var films: [Film]?
    var filmsWrapper: FilmsWrapper?
    var characters: [Character]?
    var charactersWrapper: CharactersWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        let filmUrl = "https://swapi.co/api/films/"
        let characterUrls = ["https://swapi.co/api/people/", "https://swapi.co/api/people/?page=2", "https://swapi.co/api/people/?page=3", "https://swapi.co/api/people/?page=4", "https://swapi.co/api/people/?page=5", "https://swapi.co/api/people/?page=6", "https://swapi.co/api/people/?page=7", "https://swapi.co/api/people/?page=8", "https://swapi.co/api/people/?page=9"]
        
        //use DispatchGroup to handle multiple requests
        let group = DispatchGroup()
        group.enter()
        Alamofire.request(filmUrl).responseJSON { response in
            //print(response)
            //print(response.result.value)
            let json = response.result.value as? [String: Any]
            //parse the json
            let wrapper:FilmsWrapper = FilmsWrapper()
            wrapper.count = json?["count"] as? Int
            
            var allFilms: [Film] = []
            if let results = json?["results"] as? [[String: Any]] {
                for jsonFilm in results {
                    let film = Film(json: jsonFilm)
                    allFilms.append(film)
                }
            }
            
            wrapper.films = allFilms
            self.filmsWrapper = wrapper
            self.films = self.filmsWrapper?.films
            self.tableView?.reloadData()
            group.leave()
        }
        
        var allCharacters: [Character] = []
        let wrapper:CharactersWrapper = CharactersWrapper()

        for i in 0 ... (characterUrls.count - 1) {
            group.enter()
            
            let url = characterUrls[i]
            Alamofire.request(url).responseJSON { response in
                
                let json = response.result.value as? [String: Any]
                
                //only do this once, because the "count" in every response is the same
                
                if (i == 0) {
                    wrapper.count = json?["count"] as? Int
                }
                
                if let results = json?["results"] as? [[String: Any]] {
                    for jsonCharacter in results {
                        let character = Character(json: jsonCharacter)
                        allCharacters.append(character)
                    }
                }
                
                //only assign when all characters are received
                if allCharacters.count == wrapper.count {
                    wrapper.characters = allCharacters
                    self.charactersWrapper = wrapper
                    self.characters = self.charactersWrapper?.characters
                }
                
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("all requests done")
        }
            
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if self.films == nil {
            return 0
        } else {
            return self.films!.count
        }
 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "FilmsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? FilmsTableViewCell else {
                fatalError("dequeued cell is not instance of MealTableViewCell")
        }
        
        let film = films![indexPath.row]
        
        //Configure the cell...
        cell.titleLabel.text = film.title
        cell.directorlabel.text = film.director
        cell.releaseDateLabel.text = film.releaseDate
        
        
        return cell

    }
    
    

   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let filmDetailViewController = segue.destination as? FilmDetailViewController else {
            fatalError("Unexpected destination")
        }
        
        guard let selectedFilmCell = sender as? FilmsTableViewCell else {
            fatalError("Wrong sender")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedFilmCell) else {
            fatalError("selected cell not displayed")
        }
        
        let selectedFilm = films?[indexPath.row]
        filmDetailViewController.film = selectedFilm
        filmDetailViewController.characters = self.characters
    }
    

}
