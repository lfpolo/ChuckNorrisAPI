import XCTest
import RxSwift
import RxCocoa

@testable import ChuckNorrisJokes

class JokeViewModelTests: XCTestCase {
    
    func testViewModel() {
        // Givne
        let viewModel = JokeViewModel(chuckNorrisAPI: ChuckNorrisAPIMockSuccess(), category: "sport")
        
        // When
        viewModel.getJoke()
        
        // Then
        XCTAssertEqual(viewModel.requestStatusBehaviorRelay.value, .success)
        XCTAssertTrue(viewModel.jokeBehaviorRelay.value.categories!.contains("sport"))
    }
    
    func testViewModelFail() {
        // Given
        let viewModel = JokeViewModel(chuckNorrisAPI: ChuckNorrisAPIMockFailure(), category: "sport")
        
        // When
        viewModel.getJoke()
        
        // Then
        XCTAssertEqual(viewModel.requestStatusBehaviorRelay.value, .fail)
        XCTAssertEqual(viewModel.jokeBehaviorRelay.value.categories, nil)
        XCTAssertEqual(viewModel.jokeBehaviorRelay.value.icon_url, nil)
        XCTAssertEqual(viewModel.jokeBehaviorRelay.value.url, nil)
        XCTAssertEqual(viewModel.jokeBehaviorRelay.value.value, nil)
    }
    
}
