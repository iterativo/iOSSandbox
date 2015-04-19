//
//  HttpService.m
//  iosSandbox
//
//  Created by Rafael on 4/17/15.
//  Copyright (c) 2015 slikcode. All rights reserved.
//

#import "RestService.h"

@implementation RestService

-(void)get:(NSString *)url onSuccess:(void (^)(NSDictionary *dict))successHandler onError:(void (^)(NSError *error))errorHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if(error != nil){
            errorHandler(error);
        } else {
            NSError *jsonError;
            NSDictionary *jsonAsDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (jsonError != nil){
                errorHandler(jsonError);
            } else {
                successHandler(jsonAsDict);
            }
        }
        
    }];
    [dataTask resume];
}

-(void)get:(NSString *)url withQuery:(NSDictionary *)query onSuccess:(void (^)(NSDictionary *json))successHandler onError:(void (^)(NSError *error))errorHandler{
    
}

@end
