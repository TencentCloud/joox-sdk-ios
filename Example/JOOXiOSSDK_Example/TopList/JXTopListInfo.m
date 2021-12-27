//
//  JXTopListInfo.m
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/26.
//

#import "JXTopListInfo.h"

@implementation JXTopListInfo

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.topListOpenID forKey:@"_topListOpenID"];
    [coder encodeObject:self.name forKey:@"_name"];
    [coder encodeInt32:self.trackNum forKey:@"_trackNum"];
    [coder encodeObject:self.updateTime forKey:@"_updateTime"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.topListOpenID = [coder decodeObjectForKey:@"_topListOpenID"];
        self.name = [coder decodeObjectForKey:@"_name"];
        self.trackNum = [coder decodeInt32ForKey:@"_trackNum"];
        self.updateTime = [coder decodeObjectForKey:@"_updateTime"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    JXTopListInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.topListOpenID = [_topListOpenID copyWithZone:zone];
    copy.name = [_name copyWithZone:zone];
    copy.trackNum = self.trackNum;
    copy.updateTime = [_updateTime copyWithZone:zone];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    JXTopListInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.topListOpenID = [_topListOpenID mutableCopyWithZone:zone];
    copy.name = [_name mutableCopyWithZone:zone];
    copy.trackNum = self.trackNum;
    copy.updateTime = [_updateTime mutableCopyWithZone:zone];
    return copy;
}

@end
