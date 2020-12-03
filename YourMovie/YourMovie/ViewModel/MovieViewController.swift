//
//  ViewController.swift
//  YourMovie
//
//  Created by Bruno Silva on 01/12/20.
//

//https://image.tmdb.org/t/p/w300/or06FN3Dka5tukK1e9sl16pB3iy.jpg

import UIKit
import Kingfisher

class MovieViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var labelViews: UILabel!
    @IBOutlet weak var labelLikes: UILabel!
    
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
        REST.loadMovie { (theMovie) in
            DispatchQueue.main.async {
                
                guard let movieName = self.nameMovie else { return }
                guard let likesMovie = self.labelLikes else { return }
                guard let viewsMovie = self.labelViews else { return }
                
                movieName.text = theMovie.originalTitle
                likesMovie.text = String(theMovie.voteCount)
                viewsMovie.text = String(theMovie.popularity)
                if let urlImage = URL(string: "https://image.tmdb.org/t/p/w300/or06FN3Dka5tukK1e9sl16pB3iy.jpg") {
                    self.imageMovie.kf.setImage(with: urlImage)
                } else {
                    
                }
            }
        } onError: { (movieError) in
            print(movieError)
        }
    }
}

