//
//  FilmsTableViewController.swift
//  starwars
//
//  Created by kaka93 on 7/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import UIKit

class FilmsTableViewController: UITableViewController {
    var films: [Films]?
    var filmsWrapper: FilmsWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFilms()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadFilms() {
        Films.getFilms { result in
            let filmsWrapper = result.value
            self.addFilmsFromWrapper(filmsWrapper)
            self.tableView.reloadData()
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
    
    

   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
