//
//  ViewController.m
//  iosSandbox
//
//  Created by Rafael on 4/17/15.
//  Copyright (c) 2015 slikcode. All rights reserved.
//

#import "ViewController.h"
#import "RestService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RestService *svc = [[RestService alloc]init];
    [svc get:@"https://itunes.apple.com/search?term=apple&media=software"
   onSuccess:^(NSDictionary *dict) {
       NSLog(@"%@", dict);
   }
     onError:^(NSError *error) {
         NSLog(@"%@", error.localizedDescription);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
