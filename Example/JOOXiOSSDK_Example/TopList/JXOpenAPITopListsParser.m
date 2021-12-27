//
//  JXOpenAPITopListsParser.m
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/26.
//

#import "JXOpenAPITopListsParser.h"
#import <JOOXiOSSDK/JXJsonHelper.h>

@interface JXOpenAPITopListsParser()

@property (nonatomic, strong, readwrite) NSMutableArray<JXTopListInfo *> *topListArray;

@end

@implementation JXOpenAPITopListsParser

- (void)parseJsonDictionary:(NSDictionary *)dictionary
{
    self.topListArray = [[NSMutableArray alloc] init];
    for(NSDictionary *temp in [dictionary objectForKey:@"toplists"]){
        JXTopListInfo *topListInfo = [[JXTopListInfo alloc] init];
        topListInfo.topListOpenID = [JXJsonHelper getStringFromDictionary:temp forKey:@"id" isBase64Format:NO];
        topListInfo.name = [JXJsonHelper getStringFromDictionary:temp forKey:@"name" isBase64Format:NO];
        topListInfo.trackNum = [JXJsonHelper getUnsignedIntFromDictionary:temp forKey:@"track_num"];
        topListInfo.updateTime = [JXJsonHelper getStringFromDictionary:temp forKey:@"update_time" isBase64Format:NO];
        [self.topListArray addObject:topListInfo];
    }
}
@end
