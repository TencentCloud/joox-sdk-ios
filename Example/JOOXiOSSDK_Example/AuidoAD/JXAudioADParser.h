//
//  JXAudioADParser.h
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2020/2/27.
//  Copyright © 2020 jinpingshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JOOXiOSSDK/JXAudioADBaseInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXAudioADParser : NSObject

// parse
- (void)parseJsonDictionary:(NSDictionary *)dictionary;

// response
@property (nonatomic, strong, readonly) NSMutableArray<JXAudioADBaseInfo *> *audioADBaseInfoArray;

@end

NS_ASSUME_NONNULL_END
