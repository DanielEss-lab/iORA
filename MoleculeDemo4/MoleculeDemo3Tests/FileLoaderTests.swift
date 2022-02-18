//
//  FileLoaderTests.swift
//  MoleculeDemo4Tests
//
//  Created by Jared Rossberg on 9/28/21.
//  Copyright © 2021 Gabriel Reed. All rights reserved.
//

import XCTest

class Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFileLoader1() {
        let fileLoader = FileLoader()
        do {
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource: "testMol1", ofType: "sdf")
            let reaction = try fileLoader.parseReactionFile(inputFile: path).getReaction()
            XCTAssertEqual(reaction.getStates().count, 1)
            XCTAssertEqual(reaction.getStates()[0].atoms.count, 20)
            XCTAssertEqual(reaction.getStates()[0].bonds.count, 22)
        } catch {
            XCTFail()
        }
    }
    
    func testFileLoader2() {
        let fileLoader = FileLoader()
        do {
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource: "testMol2", ofType: "sdf")
            let reaction = try fileLoader.parseReactionFile(inputFile: path).getReaction()
            XCTAssertEqual(reaction.getStates().count, 2)
            XCTAssertEqual(reaction.getStates()[0].atoms.count, 20)
            XCTAssertEqual(reaction.getStates()[0].bonds.count, 22)
            XCTAssertEqual(reaction.getStates()[1].atoms.count, 20)
            XCTAssertEqual(reaction.getStates()[1].bonds.count, 22)
        } catch {
            XCTFail()
        }
    }
    
    func testFileLoader3() {
        let fileLoader = FileLoader()
        do {
            let bundle = Bundle(for: type(of: self))
            let path = bundle.path(forResource: "testMol3", ofType: "sdf")
            let reaction = try fileLoader.parseReactionFile(inputFile: path).getReaction()
            XCTAssertEqual(reaction.getStates().count, 3)
            XCTAssertEqual(reaction.getStates()[0].atoms.count, 10)
            XCTAssertEqual(reaction.getStates()[0].bonds.count, 9)
            XCTAssertEqual(reaction.getStates()[1].atoms.count, 10)
            XCTAssertEqual(reaction.getStates()[1].bonds.count, 9)
            XCTAssertEqual(reaction.getStates()[2].atoms.count, 10)
            XCTAssertEqual(reaction.getStates()[2].bonds.count, 9)
        } catch {
            XCTFail()
        }
        
    }

}

