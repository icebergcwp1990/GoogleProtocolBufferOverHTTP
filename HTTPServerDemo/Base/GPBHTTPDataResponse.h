//
//  GPBHTTPDataResponse.h
//  HTTPDemoWithGoogleProtocolBuffer
//
//  Created by iceberg on 2018/8/1.
//  Copyright © 2018年 industriousonesoft. All rights reserved.
//

#import "HTTPDataResponse.h"

@interface GPBHTTPDataResponse : HTTPDataResponse

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)key;

@end
