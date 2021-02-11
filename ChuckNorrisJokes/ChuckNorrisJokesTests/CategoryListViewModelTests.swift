import XCTest
import RxSwift
import RxCocoa

@testable import ChuckNorrisJokes

class CategoryListViewModelTests: XCTestCase {
    
    func testViewModel() {
        // Given
        let viewModel = CategoryListViewModel(chuckNorrisAPI: ChuckNorrisAPIMockSuccess())
        
        // When
        viewModel.getCategoryList()
        
        // Then
        XCTAssertEqual(viewModel.requestStatusBehaviorRelay.value, .success)
        XCTAssertEqual(viewModel.categoryListBehaviorRelay.value, ["food", "dev", "fashion"])
    }
    
    func testViewModelFail() {
        // Given
        let viewModel = CategoryListViewModel(chuckNorrisAPI: ChuckNorrisAPIMockFailure())
        
        // When
        viewModel.getCategoryList()
        
        // Then
        XCTAssertEqual(viewModel.requestStatusBehaviorRelay.value, .fail)
        XCTAssertEqual(viewModel.categoryListBehaviorRelay.value, [])
    }
    
}
