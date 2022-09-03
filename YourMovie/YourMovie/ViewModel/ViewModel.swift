import UIKit

protocol ViewModelProtocol {
    func loadingMoviesAtList(onComplete: @escaping () -> Void)
    func loagingMovieSelected(onComplete: @escaping (Movie) -> Void)
    func numberOfRowsInSection(section: Int) -> Int
    func cellForRowAt (indexPath: IndexPath) -> Results
}

final class ViewModel {
    
    //MARK: - Variables
    
    private var popularMovies = [Results]()
    private var nameMovie: String?
}

// MARK: - Extension

extension ViewModel: ViewModelProtocol {
    
    func loadingMoviesAtList(onComplete: @escaping () -> Void) {
        REST.loadSimilarMovie { [weak self] listMovies in
            guard let self = self else { return }
            self.popularMovies = listMovies.results
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
