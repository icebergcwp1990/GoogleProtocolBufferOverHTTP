//
//  GPBHTTPDataResponse.m
//  HTTPDemoWithGoogleProtocolBuffer
//
//  Created by iceberg on 2018/8/1.
//  Copyright © 2018年 industriousonesoft. All rights reserved.
//

#import "GPBHTTPDataResponse.h"

@interface GPBHTTPDataResponse() {
    NSMutableDictionary<NSString *, NSString *> *mHttpHeaders;
}
@end

@implementation GPBHTTPDataResponse

- (NSDictionary *)httpHeaders {
    return mHttpHeaders;
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)key {
    if (!mHttpHeaders) {
        mHttpHeaders = [NSMutableDictionary new];
    }
    if (value && key) {
        [mHttpHeaders setObject:value forKey:key];
    }
    
}

@end
