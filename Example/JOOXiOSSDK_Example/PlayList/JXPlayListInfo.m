//
//  JXPlayListInfo.m
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/1/12.
//

#import "JXPlayListInfo.h"

@implementation JXPlayListInfo

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.playListOpenID forKey:@"_playListOpenID"];
    [coder encodeObject:self.name forKey:@"_name"];
    [coder encodeObject:self.coverUrl forKey:@"_coverUrl"];
    [coder encodeObject:@(self.trackNum) forKey:@"_trackNum"];
    [coder encodeObject:self.publishDate forKey:@"_publishDate"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        self.playListOpenID = [coder decodeObjectForKey:@"_playListOpenID"];
        self.name = [coder decodeObjectForKey:@"_name"];
        self.coverUrl = [coder decodeObjectForKey:@"_coverUrl"];
        self.trackNum = [[coder decodeObjectForKey:@"_trackNum"] unsignedIntValue];
        self.publishDate = [coder decodeObjectForKey:@"_publishDate"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    JXPlayListInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.playListOpenID = [_playListOpenID copyWithZone:zone];
    copy.name = [_name copyWithZone:zone];
    copy.coverUrl = [_coverUrl copyWithZone:zone];
    copy.trackNum = self.trackNum;
    copy.publishDate = [_publishDate copyWithZone:zone];
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    JXPlayListInfo *copy = [[[self class] allocWithZone:zone] init];
    copy.playListOpenID = [_playListOpenID mutableCopyWithZone:zone];
    copy.name = [_name mutableCopyWithZone:zone];
    copy.coverUrl = [_coverUrl mutableCopyWithZone:zone];
    copy.trackNum = self.trackNum;
    copy.publishDate = [_publishDate mutableCopyWithZone:zone];
    return copy;
}

@end
