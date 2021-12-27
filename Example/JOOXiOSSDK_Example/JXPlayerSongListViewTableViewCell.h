//
//  JXPlayerSongListViewTableViewCell.h
//  WeMusic
//
//  Created by satyapeng on 27/7/2018.
//

#import <UIKit/UIKit.h>
#import "JXDemoSongInfo.h"
#import <JOOXiOSSDK/JXAudioADBaseInfo.h>

@protocol JXPlayerSongListViewTableViewCellDelegate <NSObject>

- (void)onSongQualityChanged:(JXSongQuality)songQuality
                   songIndex:(NSInteger)songIndex;

@end

@interface JXPlayerSongListViewTableViewCell : UITableViewCell

@property (nonatomic, weak) id<JXPlayerSongListViewTableViewCellDelegate> delegate;

- (void)updateWithSongInfo:(JXDemoSongInfo *)songInfo
                     index:(NSInteger)index;

- (void)updateWithAudioADBaseInfo:(JXAudioADBaseInfo *)audioADBaseInfo
                            index:(NSInteger)index;

@end
