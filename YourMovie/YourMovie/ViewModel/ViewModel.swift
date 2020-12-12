//
//  ViewModel.swift
//  YourMovie
//
//  Created by Bruno Silva on 11/12/20.
//

import Foundation

class ViewModel {
    
    //MARK: - Variables
    private var popularMovies = [Results]()
    private var nameMovie: String?
    
    //MARK: - Functions
    func loadingMoviesAtList(onComplete: @escaping () -> Void) {
        REST.loadSimilarMovie { (listMovies) in
            var listSimilarMovies = listMovies.results
            self.popularMovies = listSimilarMovies
            onComplete()
        } onError: { (movieError) in
            print(movieError)
        }
    }
    
    func loagingMovieSelected(onComplete: @escaping (Movie) -> Void) {
        REST.loadMovie { (movie) in
            onComplete(movie)
        } onError: { (movieError) in
            print(movieError)
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMovies.count != 0 {
            return popularMovies.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Results {
        return popularMovies[indexPath.row]
    }
}
