//
//  ViewController.swift
//  YourMovie
//
//  Created by Bruno Silva on 01/12/20.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK: - Variables
    var viewModel = ViewModel()
    
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
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadListMovies()
        loadMovieSelected()
    }
    
    //MARK: - Functions
    func loadListMovies() {
        viewModel.loadingMoviesAtList {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadMovieSelected(){
        
        viewModel.loagingMovieSelected { (movieSelected) in
            guard let movieName = self.nameMovie else { return }
            guard let likesMovie = self.labelLikes else { return }
            guard let viewsMovie = self.labelViews else { return }
            
            DispatchQueue.main.async {
                movieName.text = movieSelected.title
                likesMovie.text = String(movieSelected.voteCount)
                viewsMovie.text = String(movieSelected.popularity)
                if let urlImage = URL(string: "https://image.tmdb.org/t/p/w300\(movieSelected.posterPath)") {
                    self.imageMovie.kf.setImage(with: urlImage)
                } else {
                    self.imageMovie.image = nil
                }
            }
        }
    }
    
    //MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.prepareCell(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? 100 : 260
    }
}

