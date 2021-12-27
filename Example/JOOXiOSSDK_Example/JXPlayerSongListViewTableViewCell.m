//
//  JXPlayerSongListViewTableViewCell.m
//  WeMusic
//
//  Created by satyapeng on 27/7/2018.
//

#import "JXPlayerSongListViewTableViewCell.h"

@interface JXPlayerSongListViewTableViewCell()

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *songNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *songDurationTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *songLabelFlagLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *songQualitySegmentedControl;

@end

@implementation JXPlayerSongListViewTableViewCell

- (void)updateWithSongInfo:(JXDemoSongInfo *)songInfo
                     index:(NSInteger)index
{
    self.index = index;
    if (songInfo) {
        self.songNameLabel.text = songInfo.name;
        NSMutableString *singerName = [[NSMutableString alloc] init];
        for (JXSingerInfo *singerInfo in songInfo.singerInfoArray) {
            if (singerName.length == 0) {
                [singerName appendString:singerInfo.name];
            } else {
                [singerName appendString:@","];
                [singerName appendString:singerInfo.name];
            }
        }
        self.singerNameLabel.text = singerName;
        self.songDurationTimeLabel.text = [self _timeDescOf:songInfo.duration];
        self.songLabelFlagLabel.text = [NSString stringWithFormat:@"%d", songInfo.labelFlag];
        self.songQualitySegmentedControl.selectedSegmentIndex = [self _segmentedControlSelectedIndexFromSongQuality:songInfo.quality];
    }
}

- (void)updateWithAudioADBaseInfo:(JXAudioADBaseInfo *)audioADBaseInfo
                            index:(NSInteger)index
{
    self.index = index;
    if (audioADBaseInfo) {
        self.songNameLabel.text = audioADBaseInfo.title;
        self.singerNameLabel.text = audioADBaseInfo.subTitle;
        self.songDurationTimeLabel.text = [self _timeDescOf:audioADBaseInfo.duration];
        self.songQualitySegmentedControl.hidden = YES;
        self.songLabelFlagLabel.hidden = YES;
    }
}

- (IBAction)songQualityChanged:(id)sender {
    if (self.delegate) {
        [self.delegate onSongQualityChanged:[self _songQualityFromSegmentedControlSelectedIndex:self.songQualitySegmentedControl.selectedSegmentIndex]
                                  songIndex:self.index];
    }
}

#pragma mark - private method
- (JXSongQuality)_songQualityFromSegmentedControlSelectedIndex:(NSInteger)selectedIndex
{
    JXSongQuality songQuality = JXSongQuality_48KAAC;
    switch (self.songQualitySegmentedControl.selectedSegmentIndex) {
        case 0:
            songQuality = JXSongQuality_48KAAC;
            break;
        case 1:
            songQuality = JXSongQuality_96KAAC;
            break;
        case 2:
            songQuality = JXSongQuality_192KAAC;
            break;
        default:
            break;
    }
    return songQuality;
}

- (NSInteger)_segmentedControlSelectedIndexFromSongQuality:(JXSongQuality)songQuality
{
    NSInteger selectedSegmentIndex = 1;
    switch (songQuality) {
        case JXSongQuality_48KAAC:
            selectedSegmentIndex = 0;
            break;
        case JXSongQuality_96KAAC:
            selectedSegmentIndex = 1;
            break;
        case JXSongQuality_192KAAC:
            selectedSegmentIndex = 2;
            break;
        default:
            break;
    }
    return selectedSegmentIndex;
}

- (NSString *)_timeDescOf:(double)duration
{
    if (duration <= 0) {
        return @"00:00";
    }
    
    NSInteger minute = ((NSInteger)duration)/60;
    NSInteger second = ((NSInteger)duration)%60;
    
    NSMutableString *result = [NSMutableString stringWithString:@""];
    if (minute < 10) [result appendString:@"0"];
    [result appendString:[@(minute) stringValue]];
    [result appendString:@":"];
    if (second < 10) [result appendString:@"0"];
    [result appendString:[@(second) stringValue]];
    return result;
}

@end
