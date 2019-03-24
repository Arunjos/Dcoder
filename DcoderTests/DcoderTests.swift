//
//  DcoderTests.swift
//  DcoderTests
//
//  Created by Arun Jose on 22/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import XCTest
@testable import Dcoder

class DcoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFetchChatListData() {
        let bundle = Bundle(for: type(of: self))
        guard let testUrl = bundle.url(forResource: "test_chat", withExtension: "json") else {
            XCTAssert(false, "Failed to load local url");
            return
        }
        do {
            let testData = try Data(contentsOf: testUrl)
            let jsonTestObject = try JSONSerialization.jsonObject(with: testData, options: [])
            let jsonTestChatList = Chat.getChatListFrom(jsonArray: jsonTestObject as! [[String : Any]])
            
            let viewModel = ChatViewModelFromChat()
            viewModel.fetchChatList(url: testUrl.absoluteString)
            self.wait(for: 1)
            let chatListResponse = viewModel.getFullChatList()
            XCTAssertTrue(jsonTestChatList == chatListResponse)
            
        } catch {
            XCTAssert(false, "Failed to get data from url");
        }
    }
    
    func testFetchChatListCount() {
        let jsonCountInLocalFile = 7
        let bundle = Bundle(for: type(of: self))
        guard let testUrl = bundle.url(forResource: "test_chat", withExtension: "json") else {
            XCTAssert(false, "Failed to load local url");
            return
        }
        let viewModel = ChatViewModelFromChat()
        viewModel.fetchChatList(url: testUrl.absoluteString)
        self.wait(for: 1)
        XCTAssertTrue(viewModel.chatCount.value == jsonCountInLocalFile)
        
    }
    
    
    func testFetchChatListFailForInvalidJSON() {
        let bundle = Bundle(for: type(of: self))
        guard let testUrl = bundle.url(forResource: "test_invalid", withExtension: "json") else {
            XCTAssert(false, "Failed to load local url");
            return
        }
        let viewModel = ChatViewModelFromChat()
        viewModel.fetchChatList(url: testUrl.absoluteString)
        self.wait(for: 1)
        XCTAssertTrue(viewModel.error.value == "Failed to parse chat list response")
    }
    
    func testFetchCodeListData() {
        let bundle = Bundle(for: type(of: self))
        guard let testUrl = bundle.url(forResource: "test_code", withExtension: "json") else {
            XCTAssert(false, "Failed to load local url");
            return
        }
        do {
            let testData = try Data(contentsOf: testUrl)
            let jsonTestObject = try JSONSerialization.jsonObject(with: testData, options: [])
            let jsonTestCodeList = Code.getCodeListFrom(jsonArray: jsonTestObject as! [[String : Any]])
            
            let viewModel = CodeViewModelFromCode()
            viewModel.fetchCodeList(url: testUrl.absoluteString)
            self.wait(for: 1)
            let codeListResponse = viewModel.getFullCodeList()
            XCTAssertTrue(jsonTestCodeList == codeListResponse)
            
        } catch {
            XCTAssert(false, "Failed to get data from url");
        }
    }
    
    func testFetchCodeListCount() {
        let jsonCountInLocalFile = 8
        let bundle = Bundle(for: type(of: self))
        guard let testUrl = bundle.url(forResource: "test_code", withExtension: "json") else {
            XCTAssert(false, "Failed to load local url");
            return
        }
        let viewModel = CodeViewModelFromCode()
        viewModel.fetchCodeList(url: testUrl.absoluteString)
        self.wait(for: 1)
        XCTAssertTrue(viewModel.codeListCount.value == jsonCountInLocalFile)
        
    }
    
    func testFetchCodeListFailForInvalidJSON() {
        let bundle = Bundle(for: type(of: self))
        guard let testUrl = bundle.url(forResource: "test_invalid", withExtension: "json") else {
            XCTAssert(false, "Failed to load local url");
            return
        }
        let viewModel = CodeViewModelFromCode()
        viewModel.fetchCodeList(url: testUrl.absoluteString)
        self.wait(for: 1)
        XCTAssertTrue(viewModel.error.value == "Failed to parse code list response")
    }
    
}
extension XCTestCase {
    
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
