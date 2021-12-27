//
//  JXAudioADParser.m
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2020/2/27.
//  Copyright © 2020 jinpingshi. All rights reserved.
//

#import "JXAudioADParser.h"
#import <JOOXiOSSDK/JXJsonHelper.h>

@interface JXAudioADParser()

@property (nonatomic, strong, readwrite) NSMutableArray<JXAudioADBaseInfo *> *audioADBaseInfoArray;

@end

@implementation JXAudioADParser

- (void)parseJsonDictionary:(NSDictionary *)dictionary
{
    self.audioADBaseInfoArray = [[NSMutableArray alloc] init];
    NSDictionary *tracks = [dictionary objectForKey:@"result"];
    for(NSDictionary *adInfo in [tracks objectForKey:@"ad_infos"]){
        JXAudioADBaseInfo *audioADBaseInfo = [[JXAudioADBaseInfo alloc] init];
        audioADBaseInfo.adID = [JXJsonHelper getStringFromDictionary:adInfo forKey:@"ad_id" isBase64Format:NO];
        NSDictionary *item = [adInfo objectForKey:@"adcreative_elements"];
        audioADBaseInfo.title = [JXJsonHelper getStringFromDictionary:item forKey:@"title" isBase64Format:NO];
        audioADBaseInfo.duration = [JXJsonHelper getDoubleFromDictionary:item forKey:@"audio_duration"] / 1000;
        audioADBaseInfo.imageURL = [JXJsonHelper getStringFromDictionary:item forKey:@"image_url" isBase64Format:NO];
        audioADBaseInfo.subTitle = [JXJsonHelper getStringFromDictionary:item forKey:@"subtitle" isBase64Format:NO];
        audioADBaseInfo.audioURL = [JXJsonHelper getStringFromDictionary:item forKey:@"audio_url" isBase64Format:NO];
        
        [self.audioADBaseInfoArray addObject:audioADBaseInfo];
    }
}

@end
