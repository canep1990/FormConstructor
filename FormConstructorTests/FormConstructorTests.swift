//
//  FormConstructorTests.swift
//  FormConstructorTests
//
//  Created by Alexey Ivankov on 25.03.17.
//  Copyright © 2017 Alexey Ivankov. All rights reserved.
//

import XCTest
@testable import FormConstructor

class FormConstructorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAddSection()
    {
        let container:TableContainer = TableContainer(threadsafe: false)
        
        let count = 10;
        
        for index in 0..<10
        {
            let section:Section = Section(id: String(index), sortKey: String(index));
            container.add(item: section);
        }
        
        XCTAssert(container.allItems().count == count);
    }
    
    func testRemoveSections()
    {
        let container:TableContainer = TableContainer(threadsafe: false)
        
        let count = 10;
        
        for index in 0..<count
        {
            let section:Section = Section(id: String(index), sortKey: String(index));
            container.add(item: section);
        }
        
        for index in (0..<count).reversed()
        {
            container.remove(id: String(index));
        }
         XCTAssert(container.allItems().count == 0);
        
        
        for index in 0..<count
        {
            let section:Section = Section(id: String(index), sortKey: String(index));
            container.add(item: section);
        }
        
        for index in (0..<count).reversed()
        {
            container.remove(index: index)
        }
        XCTAssert(container.allItems().count == 0);
    }
    
    func testSearchSection()
    {
        let container:TableContainer = TableContainer(threadsafe: false)
        
        let count = 10;
        
        
        for index in 0..<count
        {
            let section:Section = Section(id: String(index), sortKey: String(index));
            container.add(item: section);
        }
        
        for index in 0..<count
        {
            let item = container.item(id: String(index))
            XCTAssertNotNil(item);
            
            let searchIndex = container.index(item: item!);
            XCTAssertNotNil(searchIndex);
            XCTAssertEqual(index, searchIndex)
            
        }
        
        for index in 0..<count
        {
            XCTAssertNotNil(container.item(index: index));
        }
    }
    
    
    func testAddRow()
    {
        let container:TableContainer = TableContainer(threadsafe: false)
        let section:Section = Section(id: "1", sortKey: "1");
        container.add(item: section);
        
        let count = 10;
        
        for index in 0..<10
        {
            let row:Row = Row(id: String(index), sortKey: String(index))
            section.add(item: row)
        }
        
        XCTAssert(section.allItems().count == count);
    }
    
    func testRemoveRows()
    {
        let container:TableContainer = TableContainer(threadsafe: false)
        let section:Section = Section(id: "1", sortKey: "1");
        container.add(item: section);
        
        let count = 10;
        
        for index in 0..<count
        {
            let row:Row = Row(id: String(index), sortKey: String(index))
            section.add(item: row)
        }
        
        for index in (0..<count).reversed()
        {
            section.remove(id: String(index));
        }
        XCTAssert(section.allItems().count == 0);
        
        
        for index in 0..<count
        {
            let row:Row = Row(id: String(index), sortKey: String(index))
            section.add(item: row)
        }
        
        for index in (0..<count).reversed()
        {
            section.remove(index: index)
        }
        XCTAssert(section.allItems().count == 0);
    }
    
    func testSearchRows()
    {
        let container:TableContainer = TableContainer(threadsafe: false)
        let section:Section = Section(id: "1", sortKey: "1");
        container.add(item: section);
        
        let count = 10;
        
        
        for index in 0..<count
        {
            let row:Row = Row(id: String(index), sortKey: String(index))
            section.add(item: row)
        }
        
        for index in 0..<count
        {
            let item = section.item(id: String(index))
            XCTAssertNotNil(item);
            
            let searchIndex = section.index(item: item!);
            XCTAssertNotNil(searchIndex);
            XCTAssertEqual(index, searchIndex)
            
        }
        
        for index in 0..<count
        {
            XCTAssertNotNil(section.item(index: index));
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
