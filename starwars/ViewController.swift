//
//  ViewController.swift
//  starwars
//
//  Created by kaka93 on 6/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var films: [Films]?
    var filmsWrapper: FilmsWrapper?
    
    @IBOutlet weak var tableview: UITableView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadFilms()
        
    }
    
    func loadFilms() {
        Films.getFilms { result in
            let filmsWrapper = result.value
            
            self.addFilmsFromWrapper(filmsWrapper)
            
            self.tableview?.reloadData()
        }
    }
    
    func addFilmsFromWrapper(_ wrapper: FilmsWrapper?) {
        self.filmsWrapper = wrapper
        if self.films == nil {
            self.films = self.filmsWrapper?.films
        } else if self.filmsWrapper != nil && self.filmsWrapper!.films != nil {
            self.films = self.films! + self.filmsWrapper!.films!
        }
    }
    
    
    //MARK: TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.films == nil {
            return 0
        } else {
            return self.films!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let filmToShow = films![indexPath.row]
        cell.textLabel?.text = filmToShow.title
        cell.detailTextLabel?.text = filmToShow.director! + filmToShow.releaseDate!
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    

}

