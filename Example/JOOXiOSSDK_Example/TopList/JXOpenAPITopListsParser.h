//
//  JXOpenAPITopListsParser.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/26.
//

#import "JXTopListInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXOpenAPITopListsParser : NSObject

// parse
- (void)parseJsonDictionary:(NSDictionary *)dictionary;

// response
@property (nonatomic, strong, readonly) NSMutableArray<JXTopListInfo *> *topListArray;

@end

NS_ASSUME_NONNULL_END
