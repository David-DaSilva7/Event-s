//
//  CoreDataTestCase.swift
//  Event'sTests
//
//  Created by David Da Silva on 01/03/2022.
//

@testable import Reciplease
import CoreData
import XCTest
@testable import Event_s

class CoreDataTestCase: XCTestCase {
    // MARK: - Private property
    private let fakeRecipe = Events(date: "18/03/2021", numberDays: "4 jours", nameEvents: "Anniversaire Rico")
    
    // MARK: - Life cycle
    /// XCTestCase has two methods, setUp() and tearDown(), for setting up your test case before each run and cleaning up any test data afterwards. Since each test gets to start with a clean slate, these methods help make your tests isolated and repeatable.
    override func setUp() {
        EventsEntity.deleteBy(fakeRecipe.image)
    }
    
    override func tearDown() {
        EventsEntity.deleteBy(fakeRecipe.image)
    }
 
    // MARK: - Tests functions
    func testGivenFavoriteAvailable_WhenAddFavorite_ThenFavoriteIsAddedAndExists() {
        EventsEntity.addEventsToSave(fakeRecipe)
        XCTAssertTrue(EventsEntity.existBy("https://www.fakeurl.com/web-img/f08/f08811025f77fe47088dc50833259abd.jpg"))
    }
    
    func testGivenFavoriteCreatedAndRemoved_WhenAddFavoriteTestAndDeleteIt_ThenFavoriteTestShouldNotExist() {
        EventsEntity.addEventsToSave(fakeRecipe)
        XCTAssertTrue(EventsEntity.existBy("https://www.fakeurl.com/web-img/f08/f08811025f77fe47088dc50833259abd.jpg"))
        EventsEntity.deleteBy("https://www.fakeurl.com/web-img/f08/f08811025f77fe47088dc50833259abd.jpg")
        XCTAssertFalse(EventsEntity.existBy("https://www.fakeurl.com/web-img/f08/f08811025f77fe47088dc50833259abd.jpg"))
    }
    
    func testGivenFavorites_WhenDeleteAllAndAddThreeRecipes_ThenFavoritesListReturnThreeWhenCount() {
        EventsEntity.deleteAll()
        EventsEntity.addEventsToSave(fakeRecipe)
        XCTAssertEqual(EventsEntity.all().count, 1)
    }
    
    func testGivenFavorites_WhenDeleteAll_ThenFavoritesListReturnedIsEmpty() {
        EventsEntity.deleteAll()
        XCTAssertEqual(EventsEntity.all().count, 0)
    }
}
