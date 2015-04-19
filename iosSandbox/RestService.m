//
//  HttpService.m
//  iosSandbox
//
//  Created by Rafael on 4/17/15.
//  Copyright (c) 2015 slikcode. All rights reserved.
//

#import "RestService.h"

@implementation RestService

-(void)get:(NSString *)url onSuccess:(void (^)(NSDictionary *json))successHandler onError:(void (^)(NSString *errorMssg))errorHandler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        
        if(error != nil){
            errorHandler(error.localizedDescription);
        } else {
            NSError *jsonError;
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            if (jsonError != nil){
                errorHandler(jsonError.localizedDescription);
            } else {
                successHandler(json);
            }
        }
        
    }];
    [dataTask resume];
}

-(void)get:(NSString *)url withQuery:(NSDictionary *)query onSuccess:(void (^)(NSDictionary *json))successHandler onError:(void (^)(NSString *errorMssg))errorHandler{
    
}

@end
