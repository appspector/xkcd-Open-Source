//
//  DataManagerTests.m
//  xkcd Open Source
//
//  Created by Mike on 5/22/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DataManager.h"
#import "StubManager.h"

static NSString *kRealmPathForTesting = @"test.realm";

@interface DataManagerTests : XCTestCase {
    DataManager *_dataManager;
    RLMRealm *_testRealm;
}

@end

@implementation DataManagerTests

- (void)setUp {
    [super setUp];

    [self deleteAllRealmFiles];

    _testRealm = [RLMRealm realmWithPath:[self testRealmPath] readOnly:NO error:nil];

    _dataManager = [DataManager sharedInstance];
    _dataManager.realm = _testRealm;

    [_dataManager setLatestComicDownloaded:0];

    [[StubManager sharedInstance] removeAllStubs];
}

- (void)tearDown {
    [self deleteAllRealmFiles];

    [_dataManager setLatestComicDownloaded:0];

    _testRealm = nil;
    _dataManager = nil;

    [[StubManager sharedInstance] removeAllStubs];

    [super tearDown];
}

- (void)deleteAllRealmFiles {
    NSString *testRealmPath = [self testRealmPath];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:testRealmPath error:nil];

    NSString *lockPath = [testRealmPath stringByAppendingString:@".lock"];
    [fileManager removeItemAtPath:lockPath error:nil];
}

- (NSString *)testRealmPath {
    NSString *basePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [basePath stringByAppendingPathComponent:kRealmPathForTesting];
}

- (void)testSingleton {
    XCTAssertNotNil([DataManager sharedInstance]);
    XCTAssertNotNil(_dataManager.realm);
}

- (void)testSaveComics {
//    NSDictionary *comicDict = @{
//                                kNumKey: @123,
//                                kTitleKey: @"Title",
//                                kSafeTitleKey: @"Safe title",
//                                kAltKey: @"Alt",
//                                kTranscriptKey: @"Trans",
//                                kImageURLStringKey: @"www.imageURL.com",
//                                kDayKey: @"1",
//                                kMonthKey: @"12",
//                                kYearKey: @"1881",
//                                kAspectRatioKey: @(1.0)
//                                };
//
//    Comic *comic = [Comic comicFromDictionary:comicDict];
//
//    [_dataManager saveComics:@[comic]];
//
//    RLMResults *comics = [Comic allObjects];
//    XCTAssertNotEqual([comics indexOfObject:comic], NSNotFound);
}

- (void)testLatestComicDownloaded {
    NSInteger latest = 4;

    [_dataManager setLatestComicDownloaded:latest];
    XCTAssertEqual([_dataManager latestComicDownloaded], latest);

    latest = 11;

    [_dataManager setLatestComicDownloaded:latest];
    XCTAssertEqual([_dataManager latestComicDownloaded], latest);
}

- (void)testDownloadLatestComics {
//    XCTestExpectation *expectation = [self expectationWithDescription:nil];
//
//    NSInteger latest = 2;
//    NSDictionary *comic1 = @{
//                             kNumKey: @1,
//                             kTitleKey: @"Title",
//                             kSafeTitleKey: @"Safe title",
//                             kAltKey: @"Alt",
//                             kTranscriptKey: @"Trans",
//                             kImageURLStringKey: @"www.imageURL.com",
//                             kDayKey: @"1",
//                             kMonthKey: @"12",
//                             kYearKey: @"1881",
//                             kAspectRatioKey: @(1.0)
//                             };
//
//    NSDictionary *comic2 = @{
//                             kNumKey: @(latest),
//                             kTitleKey: @"Title2",
//                             kSafeTitleKey: @"Safe title2",
//                             kAltKey: @"Alt2",
//                             kTranscriptKey: @"Trans2",
//                             kImageURLStringKey: @"www.imageURL2.com",
//                             kDayKey: @"2",
//                             kMonthKey: @"11",
//                             kYearKey: @"1882",
//                             kAspectRatioKey: @(2.0)
//                             };
//
//    NSArray *comics = @[comic1, comic2];
//
//    [[StubManager sharedInstance] stubResponseWithStatusCode:202 object:comics delay:0.0];
//
//    [_dataManager downloadLatestComicsWithCompletionHandler:^(NSError *error, NSInteger numberOfNewComics) {
//        XCTAssertNil(error);
//        XCTAssertEqual(numberOfNewComics, comics.count);
//        XCTAssertEqual([_dataManager latestComicDownloaded], latest);
//
//        XCTAssertGreaterThanOrEqual([Comic objectsWhere:@"title = Title"].count, 1);
//        XCTAssertGreaterThanOrEqual([Comic objectsWhere:@"title = Title2"].count, 1);
//
//        [expectation fulfill];
//    }];
//
//    [self waitForExpectationsWithTimeout:2.0 handler:nil];
}

- (void)testPerformBackgroundFetchNewData {
//    XCTestExpectation *expectation = [self expectationWithDescription:nil];
//
//    NSInteger latest = 2;
//    NSDictionary *comic1 = @{
//                             kNumKey: @1,
//                             kTitleKey: @"Title",
//                             kSafeTitleKey: @"Safe title",
//                             kAltKey: @"Alt",
//                             kTranscriptKey: @"Trans",
//                             kImageURLStringKey: @"www.imageURL.com",
//                             kDayKey: @"1",
//                             kMonthKey: @"12",
//                             kYearKey: @"1881",
//                             kAspectRatioKey: @(1.0)
//                             };
//
//    NSDictionary *comic2 = @{
//                             kNumKey: @(latest),
//                             kTitleKey: @"Title2",
//                             kSafeTitleKey: @"Safe title2",
//                             kAltKey: @"Alt2",
//                             kTranscriptKey: @"Trans2",
//                             kImageURLStringKey: @"www.imageURL2.com",
//                             kDayKey: @"2",
//                             kMonthKey: @"11",
//                             kYearKey: @"1882",
//                             kAspectRatioKey: @(2.0)
//                             };
//
//    NSArray *comics = @[comic1, comic2];
//
//    [[StubManager sharedInstance] stubResponseWithStatusCode:202 object:comics delay:0.0];
//
//    [_dataManager performBackgroundFetchWithCompletionHandler:^(UIBackgroundFetchResult result) {
//        XCTAssertEqual(result, UIBackgroundFetchResultNewData);
//
//        [expectation fulfill];
//    }];
//
//    [self waitForExpectationsWithTimeout:2.0 handler:nil];
}

- (void)testPerformBackgroundFetchNoNewData {
    XCTestExpectation *expectation = [self expectationWithDescription:nil];

    [[StubManager sharedInstance] stubResponseWithStatusCode:200 object:@[] delay:0.0];

    [_dataManager performBackgroundFetchWithCompletionHandler:^(UIBackgroundFetchResult result) {
        XCTAssertEqual(result, UIBackgroundFetchResultNoData);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:2.0 handler:nil];
}

- (void)testPerformBackgroundFetchFailed {
    XCTestExpectation *expectation = [self expectationWithDescription:nil];

    [[StubManager sharedInstance] stubResponseWithStatusCode:500 object:nil delay:0.0];

    [_dataManager performBackgroundFetchWithCompletionHandler:^(UIBackgroundFetchResult result) {
        XCTAssertEqual(result, UIBackgroundFetchResultFailed);

        [expectation fulfill];
    }];

    [self waitForExpectationsWithTimeout:2.0 handler:nil];
}

- (void)testTokenStringFromData {
    NSData *nilTokenData = nil;

    XCTAssertNotNil([_dataManager tokenStringFromData:nilTokenData]);
    XCTAssert([[_dataManager tokenStringFromData:nilTokenData] isEqualToString:@""]);

    // TODO mock up actual NSData from a token... don't recall off the top of my head
    // what the format is...
}

@end
