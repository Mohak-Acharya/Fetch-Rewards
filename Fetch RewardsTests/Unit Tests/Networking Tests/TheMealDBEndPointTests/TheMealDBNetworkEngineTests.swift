

import XCTest
@testable import Fetch_Rewards

class TheMealDBNetworkEngineTests: XCTestCase {
    var sut: TheMealDBNetworkEngine!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_getMeals() throws {
        //arrange input data
        let json = try XCTUnwrap(
        """
        {
        "meals": [
        {
        "strMeal": "Apam balik",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
        "idMeal": "53049"
        },
        {
        "strMeal": "Apple & Blackberry Crumble",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/xvsurr1511719182.jpg",
        "idMeal": "52893"
        },
        {
        "strMeal": "Apple Frangipan Tart",
        "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg",
        "idMeal": "52768"
        }]
        }
        """.data(using: .utf8))
        
        let url = try XCTUnwrap (URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
        let inputURL = [url:json]
        
        //setup mock data to send input

        URLProtocolMock.testURLs = inputURL
        let urlConfig = URLSessionConfiguration.ephemeral
        urlConfig.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: urlConfig)
        let stubNetworkModel = NetworkModel(with: session)
        sut = TheMealDBNetworkEngine(networkModel: stubNetworkModel)
        
        //arrange expected data
        let image1 = try XCTUnwrap(UIImage(named: "Apam balik"))
        let image2 = try XCTUnwrap(UIImage(named: "Apple & Blackberry Crumble"))
        let image3 = try XCTUnwrap(UIImage(named: "Apple Frangipan Tart"))
        let expectedMeals = [
            Meal(name: "Apam balik", image: image1, id: 53049),
            Meal(name: "Apple & Blackberry Crumble", image: image2, id: 52893),
            Meal(name: "Apple Frangipan Tart", image: image3, id: 52768)
        ]
                
        //act
        let expectation = expectation(description: "expected meals")
        sut.getMeals(for: .dessert){ actualMeals in
            //assert
            XCTAssertEqual(expectedMeals.count, actualMeals.count)
            
            for i in 0..<expectedMeals.count {
                let expectedMeal = expectedMeals[i]
                let actualMeal = actualMeals[i]
                XCTAssertEqual(expectedMeal.id, actualMeal.id)
                XCTAssertEqual(expectedMeal.name, actualMeal.name)
                let expectedImageData = expectedMeal.image.pngData()
                let actualImageData = actualMeal.image.pngData()
                XCTAssertEqual(expectedImageData, actualImageData)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
