//
//  ViewController.swift
//  YourMovie
//
//  Created by Bruno Silva on 01/12/20.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    //MARK: - Variaveis
    var similarMovies: [Results] = []
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var labelViews: UILabel!
    @IBOutlet weak var labelLikes: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - IBAction
    @IBAction func actionLike(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.tintColor = UIColor.red
        } else {
            sender.tintColor = UIColor.white
        }
    }
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        REST.loadSimilarMovie { (movies) in
            DispatchQueue.main.async {
                var listSimilarMovies = movies.results
                self.similarMovies = listSimilarMovies
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        } onError: { (someError) in
            print(someError)
        }
        
        REST.loadMovie { (theMovie) in
            DispatchQueue.main.async {
                
                guard let movieName = self.nameMovie else { return }
                guard let likesMovie = self.labelLikes else { return }
                guard let viewsMovie = self.labelViews else { return }
                
                movieName.text = theMovie.title
                likesMovie.text = String(theMovie.voteCount)
                viewsMovie.text = String(theMovie.popularity)
                if let urlImage = URL(string: "https://image.tmdb.org/t/p/w300\(theMovie.posterPath)") {
                    self.imageMovie.kf.setImage(with: urlImage)
                } else {
                    self.imageMovie.image = nil
                }
            }
        } onError: { (movieError) in
            print(movieError)
        }
    }
}

// MARK: - TableView
extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        let movie = similarMovies[indexPath.row]
        cell.prepareCell(with: movie)
        
        return cell
    }
}

