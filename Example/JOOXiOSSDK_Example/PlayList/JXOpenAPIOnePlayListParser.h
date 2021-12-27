//
//  JXOpenAPIOnePlayList.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/1/12.
//

#import "JXDemoSongInfo.h"
#import "JXPlayListInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXOpenAPIOnePlayListParser : NSObject

// parse
- (void)parseJsonDictionary:(NSDictionary *)dictionary;

// response
@property (nonatomic, strong, readonly) JXPlayListInfo *playListInfo;
@property (nonatomic, assign, readonly) uint32_t listCount;
@property (nonatomic, assign, readonly) uint32_t nextIndex;
@property (nonatomic, assign, readonly) uint32_t totalCount;
@property (nonatomic, strong, readonly) NSMutableArray<JXDemoSongInfo *> *songInfoArray;

@end

NS_ASSUME_NONNULL_END
