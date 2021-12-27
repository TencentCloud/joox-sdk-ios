//
//  JXOpenAPIOnePlayListParser.m
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/1/12.
//

#import "JXOpenAPIOnePlayListParser.h"
#import <JOOXiOSSDK/JXJsonHelper.h>

@interface JXOpenAPIOnePlayListParser()

@property (nonatomic, strong, readwrite) JXPlayListInfo *playListInfo;
@property (nonatomic, assign, readwrite) uint32_t listCount;
@property (nonatomic, assign, readwrite) uint32_t nextIndex;
@property (nonatomic, assign, readwrite) uint32_t totalCount;
@property (nonatomic, strong, readwrite) NSMutableArray<JXDemoSongInfo *> *songInfoArray;

@end

@implementation JXOpenAPIOnePlayListParser

- (void)parseJsonDictionary:(NSDictionary *)dictionary
{
    JXPlayListInfo *playListInfo = [[JXPlayListInfo alloc] init];
    playListInfo.playListOpenID = [JXJsonHelper getStringFromDictionary:dictionary forKey:@"id" isBase64Format:NO];
    playListInfo.name = [JXJsonHelper getStringFromDictionary:dictionary forKey:@"name" isBase64Format:NO];
    for (NSDictionary *coverImgUrlDic in [dictionary objectForKey:@"images"]) {
        NSString *imgUrl = [JXJsonHelper getStringFromDictionary:coverImgUrlDic forKey:@"url" isBase64Format:NO];
        if (imgUrl.length > 0) {
            playListInfo.coverUrl = imgUrl;
            break;
        }
    }
    playListInfo.trackNum = [JXJsonHelper getUnsignedIntFromDictionary:dictionary forKey:@"track_count"];
    playListInfo.publishDate = [JXJsonHelper getStringFromDictionary:dictionary forKey:@"publish_date" isBase64Format:NO];
    self.playListInfo = playListInfo;
    
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
        
        songInfo.quality = JXSongQuality_48KAAC;
        
        [self.songInfoArray addObject:songInfo];
    }
}

@end
