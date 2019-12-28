//
//  CognitevNearByTechnicalTaskTests.swift
//  CognitevNearByTechnicalTaskTests
//
//  Created by Mohamed Shaikhon on 12/23/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import XCTest
@testable import CognitevNearByTechnicalTask

class CognitevNearByTechnicalTaskTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuiltURL() {
        let testURL: URL = URL(string: "https://api.foursquare.com/v2/venues/search?client_id=BJL3B5TJJVDXEDOYPVPV3CLNJINGTQWEOGIGSTV3DF53AEJ3&client_secret=J0SSCV54FU0W0EPESDXHWBVMAAZPYVFJHKYPMFSWR5DVYASI&v=20191212&ll=31,30&radius=1000")!
        var urlComponents = URLComponents()
        let url = urlComponents.getPlacesURL(lat: "31", lng: "30", radius: "1000")
        XCTAssertEqual(url.pathComponents, testURL.pathComponents )
        XCTAssertEqual(url.scheme, testURL.scheme)


        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    func testPhotoFileValidity() {
        let venueID = "12321"
        let url = URL(string:  "https://api.foursquare.com/v2/venues/\(venueID)/photos?&client_id=BJL3B5TJJVDXEDOYPVPV3CLNJINGTQWEOGIGSTV3DF53AEJ3&client_secret=J0SSCV54FU0W0EPESDXHWBVMAAZPYVFJHKYPMFSWR5DVYASI&v=20191212")
        print(url)
        XCTAssertNotNil(url)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
