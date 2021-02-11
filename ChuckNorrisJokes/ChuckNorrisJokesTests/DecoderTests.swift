import XCTest
@testable import ChuckNorrisJokes

class DecoderTests: XCTestCase {
    
    func testCategoryDecoder() {
        // Given
        let json = #"""
        ["animal","career","celebrity","dev","explicit","fashion","food","history","money","movie","music","political","religion","science","sport","travel"]
        """#
        
        // When
        let data = json.data(using: .utf8)
        let categoryList = Decoder().decode(type: [String].self, data: data!)
        
        // Then
        XCTAssertEqual(categoryList, ["animal", "career", "celebrity", "dev", "explicit", "fashion", "food", "history", "money", "movie", "music", "political", "religion", "science", "sport", "travel"])
    }

    func testJokeDecoder() {
        // Given
        let json = #"""
        {"categories":["dev"],"created_at":"2020-01-05 13:42:19.324003","icon_url":"https://assets.chucknorris.host/img/avatar/chuck-norris.png","id":"nmlts0sqrwifigqta-rv_g","updated_at":"2020-01-05 13:42:19.324003","url":"https://api.chucknorris.io/jokes/nmlts0sqrwifigqta-rv_g","value":"Chuck Norris's log statements are always at the FATAL level."}
        """#
        
        // When
        let data = json.data(using: .utf8)
        let joke = Decoder().decode(type: Joke.self, data: data!)
         
        // Then
        XCTAssertEqual(joke?.icon_url, "https://assets.chucknorris.host/img/avatar/chuck-norris.png")
        XCTAssertEqual(joke?.value, "Chuck Norris's log statements are always at the FATAL level.")
        XCTAssertEqual(joke?.url, "https://api.chucknorris.io/jokes/nmlts0sqrwifigqta-rv_g")
        XCTAssertEqual(joke?.categories, ["dev"])
    }
}
