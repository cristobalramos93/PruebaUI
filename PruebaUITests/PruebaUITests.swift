

import XCTest
import Combine
import SwiftUI
@testable import PruebaUI

class TestCharactersListViewModel: XCTestCase {

    func test_Given_characterList_When_The_List_Is_Empty_Then_The_20_Are_Added() {
        let expectation = expectation(description: "list")
        var viewModel = CharactersListViewModel(api: ApiMock(json: "CharacterListJSON"))
        viewModel.loadCharacterList(page: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            XCTAssertEqual(viewModel.charactersDataList.characterList.count, 20)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
    
    func test_Given_Error_JSON_When_The_List_Is_Empty_Then_State_is_Error() {
        let expectation = expectation(description: "list")
        var viewModel = CharactersListViewModel(api: ApiMock(json: "Empty"))
        viewModel.loadCharacterList(page: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            XCTAssertEqual(viewModel.state, .error)
            expectation.fulfill()
        })
        waitForExpectations(timeout: 5)
    }
}
