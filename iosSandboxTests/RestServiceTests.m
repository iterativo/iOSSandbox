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

- (void)testGetShouldHandleSuccessfulRequest {
    id __weak sessionMock = OCMClassMock([NSURLSession class]);
    id dataTaskMock = OCMClassMock([NSURLSessionDataTask class]);
    
    NSString *url = @"foo.com";
    
    OCMStub([sessionMock dataTaskWithURL:[NSURL URLWithString:url]
                       completionHandler:OCMOCK_ANY])
        .andCall(self, @selector(dataTaskWithURL:completionHandlerWithSuccessfulRequest:))
        .andReturn(dataTaskMock);
    OCMStub([sessionMock sharedSession]).andReturn(sessionMock);
    
    RestService *svc = [[RestService alloc]init];
    [svc get:url onSuccess:^(NSDictionary *dict) {
        XCTAssertEqual(1, dict.count);
        XCTAssertEqualObjects(@"bar", dict[@"foo"]);
    } onError:^(NSError *error) {
        XCTFail(@"Expected successHandler");
    }];
    
    OCMVerify([dataTaskMock resume]);
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
    [svc get:url onSuccess:^(NSDictionary *dict) {
        XCTFail(@"Expected errorHandler");
    } onError:^(NSError *error) {
        XCTAssertEqualObjects(@"boom", error.localizedDescription);
    }];
    
    OCMVerify([dataTaskMock resume]);
}

- (void)testGetShouldHandleJsonSerializationError {
    id __weak sessionMock = OCMClassMock([NSURLSession class]);
    id dataTaskMock = OCMClassMock([NSURLSessionDataTask class]);
    
    NSString *url = @"foo.com";
    
    OCMStub([sessionMock dataTaskWithURL:[NSURL URLWithString:url]
                       completionHandler:OCMOCK_ANY])
        .andCall(self, @selector(dataTaskWithURL:completionHandlerWithJsonSerializationError:))
        .andReturn(dataTaskMock);
    OCMStub([sessionMock sharedSession]).andReturn(sessionMock);
    
    RestService *svc = [[RestService alloc]init];
    [svc get:url onSuccess:^(NSDictionary *dict) {
        XCTFail(@"Expected errorHandler");
    } onError:^(NSError *error) {
        XCTAssertEqual(3840, error.code);
    }];
    
    OCMVerify([dataTaskMock resume]);
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandlerWithSuccessfulRequest:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    completionHandler([@"{\"foo\":\"bar\"}" dataUsingEncoding:NSUTF8StringEncoding], nil, nil);
    return nil;
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandlerWithRequestError:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    NSError *error = OCMClassMock([NSError class]);
    OCMStub([error localizedDescription]).andReturn(@"boom");
    completionHandler(nil, nil, error);
    return nil;
}

- (NSURLSessionDataTask *)dataTaskWithURL:(NSURL *)url completionHandlerWithJsonSerializationError:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler{
    completionHandler([@"boom" dataUsingEncoding:NSUTF8StringEncoding], nil, nil);
    return nil;
}

@end
