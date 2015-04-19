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

- (void)testGetShouldHandleRequestError {
    id __weak sessionMock = OCMClassMock([NSURLSession class]);
    id dataTaskMock = OCMClassMock([NSURLSessionDataTask class]);
    
    NSString *url = @"foo.com";
    
    OCMStub([sessionMock dataTaskWithURL:[NSURL URLWithString:url]
                       completionHandler:OCMOCK_ANY])
        .andCall(self, @selector(dataTaskWithURL:completionHandlerWithRequestError:))
        .andReturn(dataTaskMock);
    OCMStub([sessionMock sharedSession]).andReturn(sessionMock);
    
    RestService *svc = [[RestService alloc]init];
    [svc get:url onSuccess:^(NSDictionary *json) {
        XCTFail(@"Expected errorHandler");
    } onError:^(NSString *errorMssg) {
        XCTAssertEqualObjects(@"foo", errorMssg);
    }];
    
    OCMVerify([dataTaskMock resume]);
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandlerWithRequestError:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    NSError *error = OCMClassMock([NSError class]);
    OCMStub([error localizedDescription]).andReturn(@"foo");
    completionHandler(nil, nil, error);
    return nil;
}

//- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandlerWithJsonSerializationError:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
//    id __weak serializerMock = OCMClassMock([NSJSONSerialization class]);
//    OCMStub([serializerMock]);
//    
//    NSError *error = OCMClassMock([NSError class]);
//    
//    OCMStub([error localizedDescription]).andReturn(@"foo");
//    completionHandler(nil, nil, error);
//    return nil;
//}

@end
