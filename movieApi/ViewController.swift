//
//  ViewController.swift
//  movieApi
//
//  Created by JAYDEN SAWYER on 1/14/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    let apiKey = "905e5757"
    let movieName = "Ghost"
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieRelease()
    
    }

    func getMovieRelease(){
        let session = URLSession.shared
        let movieURL = URL(string: "http://www.omdbapi.com/?t=\(movieName)&apikey=\(apiKey)")!
        let dataTask = session.dataTask(with: movieURL) { data, response, error in if let e = error{
            print("No movie \(e)")
        } else{
            
        }
            
        }
        
    }
}
