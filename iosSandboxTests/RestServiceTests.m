//
//  RestServiceTests.m
//  iosSandbox
//
//  Created by Rafael on 4/18/15.
//  Copyright (c) 2015 slikcode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "RestService.h"

@interface RestServiceTests : XCTestCase

@end

@implementation RestServiceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGet {
    id __weak sessionMock = OCMClassMock([NSURLSession class]);
    NSString *url = @"foo.com";
    __block BOOL called = NO;
    
    OCMStub([sessionMock dataTaskWithURL:[NSURL URLWithString:url] completionHandler:OCMOCK_ANY]).andDo(^(NSInvocation *invocation){
        called = YES;
    });
    OCMStub([sessionMock sharedSession]).andReturn(sessionMock);
    
    RestService *svc = [[RestService alloc]init];
    [svc Get:url];
    XCTAssertTrue(called);
}

@end
