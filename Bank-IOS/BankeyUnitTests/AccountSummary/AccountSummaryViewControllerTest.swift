//
//  AccountSummaryViewControllerTest.swift
//  BankeyUnitTests
//
//  Created by Huang Yan on 10/1/22.
//
import Foundation
import XCTest

@testable import Bank_IOS

class AccountSummaryViewControllerTests: XCTestCase {
    var vc: AccountSummaryViewController!
    var mockManager: MockProfileManager!
    
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        // vc.loadViewIfNeeded()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)
    }
    func testTitleAndMessageForDecodeError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodeError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    func testAlertForServerError() throws {
        mockManager.error = .serverError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.alert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.alert.message)
        
    }
    func testAlertForDecodeError() throws {
        mockManager.error = .decodeError
        vc.forceFetchProfile()
        
        XCTAssertEqual("Network Error", vc.alert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.alert.message)
        
    }
}

class MockProfileManager: ProfileManageable {
       var profile: Profile?
       var error: NetworkError?
       
       func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
           if error != nil {
               completion(.failure(error!))
               return
           }
           profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
           completion(.success(profile!))
       }
   }
