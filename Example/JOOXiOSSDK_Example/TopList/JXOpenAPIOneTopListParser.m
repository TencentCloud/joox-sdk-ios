//
//  JXOpenAPIOneTopListParser.m
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/26.
//

#import "JXOpenAPIOneTopListParser.h"
#import <JOOXiOSSDK/JXJsonHelper.h>

@interface JXOpenAPIOneTopListParser()

@property (nonatomic, assign, readwrite) uint32_t listCount;
@property (nonatomic, assign, readwrite) uint32_t nextIndex;
@property (nonatomic, assign, readwrite) uint32_t totalCount;
@property (nonatomic, strong, readwrite) NSMutableArray<JXDemoSongInfo *> *songInfoArray;

@end

@implementation JXOpenAPIOneTopListParser

- (void)parseJsonDictionary:(NSDictionary *)dictionary
{
    self.songInfoArray = [[NSMutableArray alloc] init];
    NSDictionary *tracks = [dictionary objectForKey:@"tracks"];
    self.listCount = [JXJsonHelper getUnsignedIntFromDictionary:tracks forKey:@"list_count"];
    self.nextIndex = [JXJsonHelper getUnsignedIntFromDictionary:tracks forKey:@"next_index"];
    self.totalCount = [JXJsonHelper getUnsignedIntFromDictionary:tracks forKey:@"total_count"];
    for(NSDictionary *item in [tracks objectForKey:@"items"]){
        JXDemoSongInfo *songInfo = [[JXDemoSongInfo alloc] init];
        songInfo.songOpenID = [JXJsonHelper getStringFromDictionary:item forKey:@"id" isBase64Format:NO];
        songInfo.name = [JXJsonHelper getStringFromDictionary:item forKey:@"name" isBase64Format:NO];
        songInfo.genre = [JXJsonHelper getStringFromDictionary:dictionary forKey:@"genre" isBase64Format:NO];
        songInfo.duration = [JXJsonHelper getDoubleFromDictionary:item forKey:@"play_duration"];
        
        JXAlbumBaseInfo *albemBaseInfo = [[JXAlbumBaseInfo alloc] init];
        albemBaseInfo.albumOpenID = [JXJsonHelper getStringFromDictionary:item forKey:@"album_id" isBase64Format:NO];
        albemBaseInfo.name = [JXJsonHelper getStringFromDictionary:item forKey:@"album_name" isBase64Format:NO];
        for (NSDictionary *coverImgUrlDic in [item objectForKey:@"images"]) {
//            int width = [JXJsonHelper getIntFromDictionary:coverImgUrlDic forKey:@"width"];
//            int height = [JXJsonHelper getIntFromDictionary:coverImgUrlDic forKey:@"height"];
            NSString *imgUrl = [JXJsonHelper getStringFromDictionary:coverImgUrlDic forKey:@"url" isBase64Format:NO];
            if (imgUrl.length > 0) {
                albemBaseInfo.coverUrl = imgUrl;
                break;
            }
        }
        songInfo.albumBaseInfo = albemBaseInfo;
        
        NSMutableArray *singerInfoArray = [[NSMutableArray alloc] init];
        for (NSDictionary *artistDic in [item objectForKey:@"artist_list"]) {
            JXSingerInfo *singerInfo = [[JXSingerInfo alloc] init];
            singerInfo.singerOpenID = [JXJsonHelper getStringFromDictionary:artistDic forKey:@"id" isBase64Format:NO];
            singerInfo.name = [JXJsonHelper getStringFromDictionary:artistDic forKey:@"name" isBase64Format:NO];
            [singerInfoArray addObject:singerInfo];
        }
        songInfo.singerInfoArray = singerInfoArray;
        
        songInfo.labelFlag = [JXJsonHelper getIntFromDictionary:item forKey:@"track_label_flag"];
        
        [self.songInfoArray addObject:songInfo];
    }
}

@end
