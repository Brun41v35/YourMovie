import XCTest
@testable import YourMovie

final class RESTTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var sut = ViewModel()
    
    // MARK: - Methods
    
    func test_callSomething_shouldReturnSomething() {
        // Given
        
        // When
        
        // Then
    }
    
    func testValidatingAPIReturn() {
        
        let key = "f50f471d04a15b749b92b1c3de43e22d"
        let movieId = "299534"
        guard let basePath = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=\(key)&language=en-US") else { return }
        let task = URLSession.shared.dataTask(with: basePath) { (data, response, error) in
            
            XCTAssertNil(error == nil, "Something went wrong")
            guard let responseAPI = response as? HTTPURLResponse else { return }
            XCTAssertEqual(200, responseAPI.statusCode)
        }
        task.resume()
    }
}
