//
//  CoreDataTestCase.swift
//  EventsTests
//
//  Created by David Da Silva on 19/05/2022.
//

import CoreData
import XCTest
@testable import Events

class CoreDataTestCase: XCTestCase {
    // MARK: - Private property
    private let fakeEvents = Event(id: "azerty", name: "Anniversaire Rico", numberOfDays: 3, attendees: ["Eric","Hugo"], date: Date(), days: [1: "Acrobranche", 2: "Piscine", 3: "Soirée"], themes: ["Alimentation": "Soda"], imageEvent: (UIImage(named: "imageAddPicture")?.pngData())!)
    
    // MARK: - Life cycle
    /// XCTestCase has two methods, setUp() and tearDown(), for setting up your test case before each run and cleaning up any test data afterwards. Since each test gets to start with a clean slate, these methods help make your tests isolated and repeatable.
    override func setUp() {
        EventsEntity.deleteBy(fakeEvents.id)
    }
    
    override func tearDown() {
        EventsEntity.deleteBy(fakeEvents.id)
    }
 
    // MARK: - Tests functions
    func testGivenFavoriteAvailable_WhenAddFavorite_ThenFavoriteIsAddedAndExists() {
        EventsEntity.save(fakeEvents)
        XCTAssertTrue(EventsEntity.existBy("azerty"))
    }
    
    func testGivenFavoriteCreatedAndRemoved_WhenAddFavoriteTestAndDeleteIt_ThenFavoriteTestShouldNotExist() {
        EventsEntity.save(fakeEvents)
        XCTAssertTrue(EventsEntity.existBy("azerty"))
        EventsEntity.deleteBy("azerty")
        XCTAssertFalse(EventsEntity.existBy("azerty"))
    }
    
    func testGivenFavorites_WhenDeleteAllAndAddThreeRecipes_ThenFavoritesListReturnThreeWhenCount() {
        EventsEntity.save(fakeEvents)
        XCTAssertEqual(EventsEntity.all().count, 1)
    }
    
    func testGivenFavorites_WhenDeleteAll_ThenFavoritesListReturnedIsEmpty() {
        EventsEntity.save(fakeEvents)
        XCTAssertTrue(EventsEntity.existBy("azerty"))
        EventsEntity.deleteBy("azerty")
        XCTAssertEqual(EventsEntity.all().count, 0)
    }
}
