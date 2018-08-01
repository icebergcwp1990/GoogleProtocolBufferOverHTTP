//
//  ViewController.m
//  HTTPServerDemo
//
//  Created by iceberg on 2018/8/1.
//  Copyright © 2018年 industriousonesoft. All rights reserved.
//

#import "ViewController.h"
#import "GPBHTTPConnection.h"
#import <CocoaHTTPServer/HTTPServer.h>

@interface ViewController ()

@property (nonatomic, readwrite, strong) HTTPServer *server;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark -Creator

- (HTTPServer *)server {
    if (!_server) {
        _server = [[HTTPServer alloc] init];
        [_server setInterface:@"192.168.31.248"];
        [_server setPort:60000];
        [_server setConnectionClass:[GPBHTTPConnection class]];
    }
    return _server;
}

#pragma mark - Helper

- (void)startServer {
    if (![self.server isRunning]) {
        NSError *error = nil;
        [self.server start:&error];
        
        if (error) {
            NSLog(@"%s => error: %@" , __func__, error.localizedDescription);
            self.server = nil;
            return;
        }else {
            NSLog(@"started server: %@:%d", [self.server interface], [self.server port]);
        }
    }
}

- (void)stopServer {
    if ([self.server isRunning]) {
        [self.server stop];
    }
}

#pragma mark - IBAction

- (IBAction)startServerButtonDidClicked:(id)sender {
    if ([(NSButton *)sender state] == NSOnState) {
        [self startServer];
    }else {
        [self stopServer];
    }
}

@end
