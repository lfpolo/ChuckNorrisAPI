import XCTest
@testable import ChuckNorrisJokes

class ImageCacheTests: XCTestCase {
    
    func testSaveImageOnCache() {
        // Given
        let image = UIImage(named: "DefaultChuckNorris")!
        
        // When
        UIImage.saveImageOnCache(imageIdentifier: "DefaultChuckNorris", image: image)
        
        // Then
        let cachedImage = UIImage.imageCache.object(forKey: "DefaultChuckNorris")
        XCTAssertEqual(cachedImage, image)
    }
    
    func testLoadImageFromCache() {
        // Given
        let image = UIImage(named: "DefaultChuckNorris")!
        UIImage.imageCache.setObject(image, forKey: "DefaultChuckNorris")
        
        // When
        let result = UIImage.loadImageFromCache(imageIdentifier: "DefaultChuckNorris")
        
        // Then
        XCTAssertEqual(result, image)
    }
}
