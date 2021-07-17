//
//  ApplicationTests.swift
//  ApplicationTests
//
//  Created by Yovi Eka Putra on 26/06/21.
//

import XCTest
@testable import Application

class ApplicationTests: XCTestCase {

    func testMain() throws {
        print(oddNumbers(l: 2, r: 5))
    }
    
    
    func oddNumbers(l: Int, r: Int) -> [Int] {
        var arr: [Int] = []
        
        for value in l...r {
            if value % 2 != 0 {
                arr.append(value)
            }
        }

        return arr
    }
}
