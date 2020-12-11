//
//  MovieTableViewCell.swift
//  YourMovie
//
//  Created by Bruno Silva on 05/12/20.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {
    
    //MARK: - IBOutlet
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDateMovie: UILabel!
    
    //MARK: - Funcoes
    func prepareCell(with movie: Results) {
        labelName.text = movie.title
        labelDateMovie.text = movie.releaseDate
        if let url = URL(string: "https://image.tmdb.org/t/p/w300\(movie.posterPath)") {
            imageMovie.kf.indicatorType = .activity
            imageMovie.kf.setImage(with: url)
        } else {
            imageMovie?.image = nil
        }
        imageMovie.layer.cornerRadius = imageMovie.frame.size.height / 5.0
        imageMovie.layer.borderColor = UIColor.white.cgColor
        imageMovie.layer.borderWidth = 2
    }
}
