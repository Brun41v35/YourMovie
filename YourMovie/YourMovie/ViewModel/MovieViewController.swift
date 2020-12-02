//
//  ViewController.swift
//  YourMovie
//
//  Created by Bruno Silva on 01/12/20.
//

import UIKit

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
            }
        } onError: { (movieError) in
            print(movieError)
        }
    }
}

