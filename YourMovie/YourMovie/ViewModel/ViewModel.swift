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
    
    //MARK: - Methods
    func carregaFilmesNoVetor(onComplete: @escaping () -> Void) {
        REST.loadSimilarMovie { (listMovies) in
            var listSimilarMovies = listMovies.results
            self.popularMovies = listSimilarMovies
            onComplete()
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
