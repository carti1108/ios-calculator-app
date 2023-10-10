//
//  OperatorTests.swift
//  OperatorTests
//
//  Created by Kiseok on 2023/10/11.
//

import XCTest
@testable import Calculator

final class OperatorTests: XCTestCase {
    var sut: Operator!

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_operator가add케이스이고lhs와rhs가각각1일때_add호출시2가나오는지() throws {
        //given
        sut = Operator.add
        let lhs: Double = 1
        let rhs: Double = 1
        
        //when
        let result = try sut.calculate(lhs: lhs, rhs: rhs)
        
        //then
        XCTAssertEqual(result, 2)
    }

    

}
