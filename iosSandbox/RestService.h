//
//  HttpService.h
//  iosSandbox
//
//  Created by Rafael on 4/17/15.
//  Copyright (c) 2015 slikcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestService : NSObject

-(void)get:(NSString *)url onSuccess:(void (^)(NSDictionary *json))successHandler onError:(void (^)(NSString *errorMssg))errorHandler;

-(void)get:(NSString *)url withQuery:(NSDictionary *)query onSuccess:(void (^)(NSDictionary *json))successHandler onError:(void (^)(NSString *errorMssg))errorHandler;

@end
