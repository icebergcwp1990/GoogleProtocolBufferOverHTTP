//
//  ViewController.m
//  HTTPClientDemo
//
//  Created by iceberg on 2018/8/1.
//  Copyright © 2018年 industriousonesoft. All rights reserved.
//

#import "ViewController.h"
#import "RequestLogin.pbobjc.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark - IBAction

- (IBAction)requestButtonDidClicked:(id)sender {
    
    Login *loginMsg = [[Login alloc] init];
    [loginMsg setIdentify:100];
    [loginMsg setName:@"Iceberg"];
    [loginMsg setType:3];
    [loginMsg setPassword:@"wei123456"];
    
    NSData *data = [loginMsg data];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://192.168.31.248:60000/login"]];
    
    [request setTimeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-protobuf" forHTTPHeaderField:@"Content-Type"];
    
    if (data) {
        [request setHTTPBody:data];
    }
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
        }else {
            if ([data length] > 0) {
                NSError *parseError = nil;
                Login *receivedMsg = [Login parseFromData:data error:&parseError];
                if (parseError) {
                    NSLog(@"parseError => %@", parseError.localizedDescription);
                }else {
                    NSLog(@"repone data => %@" , receivedMsg);
                }
            }else {
                NSLog(@"response => %@", response);
            }
        }
    }] resume];
}


@end
