//
//  JXOpenAPIOneTopListParser.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/26.
//

#import "JXDemoSongInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXOpenAPIOneTopListParser : NSObject

// parse
- (void)parseJsonDictionary:(NSDictionary *)dictionary;

// response
@property (nonatomic, assign, readonly) uint32_t listCount;
@property (nonatomic, assign, readonly) uint32_t nextIndex;
@property (nonatomic, assign, readonly) uint32_t totalCount;
@property (nonatomic, strong, readonly) NSMutableArray<JXDemoSongInfo *> *songInfoArray;

@end

NS_ASSUME_NONNULL_END
