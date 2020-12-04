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
    
    //MARK: - Variaveis
    private static let basePath = "https://api.themoviedb.org/3/movie/299534?api_key=f50f471d04a15b749b92b1c3de43e22d&language=en-US"
    private static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Contet-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        config.httpMaximumConnectionsPerHost = 5
        return config
    }()
    private static let session = URLSession(configuration: configuration)
    
    //MARK: - Metodos
    class func loadMovie(onComplete: @escaping (Movie) -> Void, onError: @escaping (MovieError) -> Void) {
        
        guard let url = URL(string: basePath) else {
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
}
