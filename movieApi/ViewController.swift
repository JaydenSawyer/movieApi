//
//  ViewController.swift
//  movieApi
//
//  Created by JAYDEN SAWYER on 1/14/25.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    let apiKey = "905e5757"
    var movieName = ""
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        label1.text = "Enter a movie name and press the button"
    }
    
    @IBAction func button1(_ sender: UIButton) {
        if let usr = textField.text, !usr.isEmpty {
            self.movieName = usr
            getMovies()
        } else {
            label1.text = "Please enter a valid movie name"
        }
    }
    
    
    func getMovies() {
        if let movieURL = URL(string: "http://www.omdbapi.com/?s=\(movieName)&apikey=\(apiKey)"){
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: movieURL) { data, response, error in
                if let error = error {
                    print("Error finding movies: \(error)")
                    DispatchQueue.main.async {
                        self.label1.text = "Error getting movies"
                    }
                    return
                }
                
                if let data = data {
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                        if let searchResults = jsonObj["Search"] as? [[String: Any]] {
                            self.movies = searchResults
                        } else {
                            self.movies = []
                        }
                    }
                    DispatchQueue.main.async {
                        if self.movies.isEmpty {
                            self.label1.text = "No movies found for \"\(self.movieName)\""
                        } else {
                            self.label1.text = "Found \(self.movies.count) movies"
                        }
                        self.tableViewOutlet.reloadData()
                    }
                }
            }
            dataTask.resume()
        }
        
        
        
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let movie = movies[indexPath.row]
        cell.textLabel?.text = movie["Title"] as? String ?? "Unknown Title"
        cell.detailTextLabel?.text = movie["Year"] as? String ?? "Unknown Year"
        return cell
    }


    }
