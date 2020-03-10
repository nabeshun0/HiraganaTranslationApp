import APIKit
@testable import HiraganaTranslationApp
import XCTest

class HiraganaTranslatorDataStoreTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testHiraganaTranslatorDataStore() {
        let exp = expectation(description: "HiraganaTranslator")

        Session.send(HiraganaTranslatorAPI.Request(sentence: "入力してください"), callbackQueue: nil) { (result) in
            switch result {
            case .success(let response):
                print(response)
                exp.fulfill()
            case .failure(let error):
                exp.fulfill()
                XCTAssert(false, error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 3.0, handler: nil)
    }
}
