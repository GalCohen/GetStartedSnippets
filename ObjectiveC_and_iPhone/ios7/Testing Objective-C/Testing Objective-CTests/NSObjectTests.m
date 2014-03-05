//
//  NSObjectTests.m
//  Testing Objective-C
//
//  Created by Gal Cohen on 3/5/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSObjectTests : XCTestCase

@end

@implementation NSObjectTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testTrue
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    XCTAssert(true, @"true should be true");
}


- (void)testFalse
{
    XCTAssertFalse(false, @"false should be false");
}


- (void)testNil
{
    XCTAssertNil(nil, @"nil should be nil");
}

- (void)testNotNil
{
    XCTAssertNotNil(@"hello", @"hello should not be nil");
}


- (void)testObjectIsNil
{
    NSObject* object;
    XCTAssertNil(object, @"object should be nil");
}

- (void)testObjectIsNotNil
{
    NSObject *object = [NSObject new];
    XCTAssertNotNil(object, @"object should not be nil");
}


- (void)testObjectIsFalse
{
    NSObject* object;
    XCTAssertFalse(object, @"nill should be false");
}


- (void)testNonNilObjectIsTrue
{
    NSObject* object = [NSObject new];
    XCTAssert(object, @"non nill should be true");
}

- (void)testObjectIsKindOfClass
{
    NSObject* object = [NSObject new];
    XCTAssert([object isKindOfClass:[NSObject class]], @"object should be kindd of class NSObject");
}

@end
