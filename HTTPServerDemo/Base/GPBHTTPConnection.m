//
//  GPBHTTPConnection.m
//  HTTPDemoWithGoogleProtocolBuffer
//
//  Created by iceberg on 2018/8/1.
//  Copyright © 2018年 industriousonesoft. All rights reserved.
//

#import "GPBHTTPConnection.h"
#import "GPBHTTPDataResponse.h"
#import "HTTPMessage.h"
#import "RequestLogin.pbobjc.h"
#import <CocoaHTTPServer/HTTPDataResponse.h>
#import <CocoaHTTPServer/HTTPLogging.h>

static const int httpLogLevel = HTTP_LOG_LEVEL_VERBOSE;

@implementation GPBHTTPConnection

- (BOOL)supportsMethod:(NSString *)method atPath:(NSString *)path
{
    if ([method isEqualToString:@"GET"])
        return YES;
    
    if ([method isEqualToString:@"HEAD"])
        return YES;
    
    if ([method isEqualToString:@"POST"])
        return YES;
    
    return NO;
}

- (BOOL)expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path {
    if ([method isEqualToString:@"POST"])
        return YES;
    
    return [super expectsRequestBodyFromMethod:method atPath:path];
}

- (void)processBodyData:(NSData *)postDataChunk
{
    HTTPLogTrace();
    
    // Remember: In order to support LARGE POST uploads, the data is read in chunks.
    // This prevents a 50 MB upload from being stored in RAM.
    // The size of the chunks are limited by the POST_CHUNKSIZE definition.
    // Therefore, this method may be called multiple times for the same POST request.
    
    BOOL result = [request appendData:postDataChunk];
    if (!result)
    {
        HTTPLogError(@"%@[%p]: %@ - Couldn't append bytes!", THIS_FILE, self, THIS_METHOD);
    }
}


- (NSObject<HTTPResponse> *)httpResponseForMethod:(NSString *)method URI:(NSString *)path {
 
    if ([path isEqualToString:@"/login"]) {
        NSData *bodyData = [request body];
        NSError *parseError = nil;
        Login *loginMsg = [Login parseFromData:bodyData error:&parseError];
        if (loginMsg) {
            NSLog(@"Received => %@", loginMsg);
        }
        
        Login *responeMsg = [[Login alloc] init];
        [responeMsg setIdentify:200];
        [responeMsg setName:@"I'm a server."];
        [responeMsg setPassword:@"There is no password."];
        [responeMsg setType:4];

        GPBHTTPDataResponse *response = [[GPBHTTPDataResponse alloc] initWithData:[responeMsg data]];
        [response setValue:@"application/x-protobuf" forHTTPHeaderField:@"Content-Type"];
        
        return response;
    }
    
    return [[HTTPDataResponse alloc] initWithData:nil];
}

@end
