//
//  HttpService.h
//  iosSandbox
//
//  Created by Rafael on 4/17/15.
//  Copyright (c) 2015 slikcode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RestService : NSObject

-(void)get:(NSString *)url onSuccess:(void (^)(NSDictionary *dict))successHandler onError:(void (^)(NSError *error))errorHandler;

-(void)get:(NSString *)url withQuery:(NSDictionary *)query onSuccess:(void (^)(NSDictionary *dict))successHandler onError:(void (^)(NSError *error))errorHandler;

@end
