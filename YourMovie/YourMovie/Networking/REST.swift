//
//  REST.swift
//  YourMovie
//
//  Created by Bruno Silva on 02/12/20.
//

import Foundation

enum MovieError {
    case url
    case taskError
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class REST {
    
    //MARK: - Variables
    private static let key = "f50f471d04a15b749b92b1c3de43e22d"
    private static let movieId = "299534"
    private static let basePathMovie = "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(key)&language=en-US"
    private static let basePathSimilarMovie = "https://api.themoviedb.org/3/movie/\(movieId)/similar?api_key=\(key)&language=en-US&page=1"
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Contet-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    //MARK: - Functions
    class func loadMovie(onComplete: @escaping (Movie) -> Void, onError: @escaping (MovieError) -> Void) {
        
        guard let url = URL(string: basePathMovie) else {
            onError(.url)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            if error == nil {
                guard let responseURL = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if responseURL.statusCode == 200 {
                    guard let receivingData = data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        let movie = try decoder.decode(Movie.self, from: receivingData)
                        onComplete(movie)
                    } catch {
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(code: responseURL.statusCode))
                }
            } else {
                onError(.taskError)
            }
        }
        dataTask.resume()
    }
    
    class func loadSimilarMovie(onComplete: @escaping (SimilarMovie) -> Void, onError: @escaping (MovieError) -> Void) {
        
        guard let url = URL(string: basePathSimilarMovie) else {
            onError(.url)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in

            if error == nil {
                guard let responseURL = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                
                if responseURL.statusCode == 200 {
                    guard let receivingData = data else {
                        onError(.noData)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let similarMovies = try decoder.decode(SimilarMovie.self, from: receivingData)
                        onComplete(similarMovies)
                    } catch {
                        onError(.invalidJSON)
                    }
                } else {
                    onError(.responseStatusCode(code: responseURL.statusCode))
                }
            } else {
                onError(.taskError)
            }
        }
        dataTask.resume()
    }
}
