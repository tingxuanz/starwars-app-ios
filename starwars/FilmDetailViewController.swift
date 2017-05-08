//
//  FilmDetailViewController.swift
//  starwars
//
//  Created by kaka93 on 7/05/2017.
//  Copyright © 2017 tingxuanz. All rights reserved.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    var film: Film?
    var characters: [Character]?
    var names: [String] = [] //store names of all characters that show up in the film
    var namesString: String = ""
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var openingCrawl: UITextView!
    @IBOutlet weak var namesField: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getNames()
        
        self.titleLabel.text = self.film?.title
        self.directorLabel.text = self.film?.director
        self.releaseDateLabel.text = self.film?.releaseDate
        self.openingCrawl.text = self.film?.openingCrawl
        self.namesField.text = self.namesString
    }
    
    func getNames() {
        
        /*Compare each character.url with urls in film.characters.
         If there is a match, this character shows up in the film
         */
        for c1 in characters! {
            for c2 in (film?.characters!)! {
                if c1.url == c2 {
                    names.append(c1.name! + "\n")
                }
            }
        }
        
        //append all names in a string, display this string in a text view
        for name in names {
            namesString.append(name)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
