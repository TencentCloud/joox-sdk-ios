//
//  JXPlayerViewController.m
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2019/8/27.
//  Copyright © 2019 jinpingshi. All rights reserved.
//

#import "JXPlayerViewController.h"
#import <JOOXiOSSDK/JOOXiOSSDK.h>
#import "JXSlider.h"
#import "JXPlayerSongListViewController.h"
#import <JOOXiOSSDK/JXSongDownloadTask.h>
#import <JOOXiOSSDK/JXAudioADBaseInfo.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface JXPlayerViewController () <JOOXiOSSDKPlayerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *albumImageView;
@property (strong, nonatomic) IBOutlet UIProgressView *cacheProgressView;
@property (strong, nonatomic) IBOutlet JXSlider *playProgressSlider;
@property (strong, nonatomic) IBOutlet UILabel *currentDurationLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalDurationLabel;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UILabel *songNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *singerNameLabel;
@property (strong, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) IBOutlet UIButton *downloadButton;
@property (strong, nonatomic) IBOutlet UISegmentedControl *songQualitySegmentedControl;

@property (strong, nonatomic) JXSongDownloadTask *downloadTask;
@end

@implementation JXPlayerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.songQualitySegmentedControl.selectedSegmentIndex = [self _segmentedControlSelectedIndexFromSongQuality:self.songBaseInfo.quality];
    self.sdk.playerDelegate = self;
    __weak __typeof(self) wself = self;
    if (self.audioADBaseInfo) {
        self.downloadButton.hidden = YES;
        self.songQualitySegmentedControl.hidden = YES;
        [self.sdk playWithAduidoADBaseInfo:self.audioADBaseInfo
                                  callback:^(JX_START_PLAY_ERROR_CODE errorCode) {
            if (JX_START_PLAY_ERROR_CODE_NONE != errorCode) {
                [wself _showMessage:[NSString stringWithFormat:@"play error:%ld", (long)errorCode]];
            }
        }];
    } else {
        self.songBaseInfo.type = [self.sdk isDownloadedSongWithSongBaseInfo:self.songBaseInfo] ? JXSongType_Downloaded: JXSongType_Online;
        NSString *startString = self.songBaseInfo.type ==  JXSongType_Downloaded ? @"Remove" : @"Download";
        [self.downloadButton setTitle:startString forState:UIControlStateNormal];
        [self.sdk playWithSongBaseInfo:self.songBaseInfo
                              callback:^(JX_START_PLAY_ERROR_CODE errorCode) {
            if (JX_START_PLAY_ERROR_CODE_NONE != errorCode) {
                [wself _showMessage:[NSString stringWithFormat:@"play error:%ld", (long)errorCode]];
            }
        }];
        if (self.songBaseInfo.type == JXSongType_Downloaded) {
            [SVProgressHUD showInfoWithStatus:@"Play downloaded song"];
        } else if (self.songBaseInfo.type == JXSongType_Online) {
            [SVProgressHUD showInfoWithStatus:@"Play online song"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)updateUIWhenDataReady
{
    self.playButton.enabled = YES;
    
    if (self.audioADBaseInfo && self.sdk.currentAudioADBaseInfo) {
        self.songNameLabel.text = self.sdk.currentAudioADBaseInfo.title;
        self.singerNameLabel.text = self.sdk.currentAudioADBaseInfo.subTitle;
        self.albumImageView.image = nil;
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:self.sdk.currentAudioADBaseInfo.imageURL]
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error && data.length > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.albumImageView.image = [UIImage imageWithData:data];
                });
            }
        }];
        [task resume];
        self.currentDurationLabel.text = [self _timeDescOf:0];
    } else {
        self.songNameLabel.text = self.sdk.currentSongBaseInfo.name;
        NSMutableString *singerName = [[NSMutableString alloc] init];
        for (JXSingerInfo *singerInfo in self.sdk.currentSongBaseInfo.singerInfoArray) {
            if (singerName.length == 0) {
                [singerName appendString:singerInfo.name];
            } else {
                [singerName appendString:@","];
                [singerName appendString:singerInfo.name];
            }
        }
        self.singerNameLabel.text = singerName;
        self.albumImageView.image = nil;
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:self.sdk.currentSongBaseInfo.albumBaseInfo.coverUrl]
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error && data.length > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.albumImageView.image = [UIImage imageWithData:data];
                });
            }
        }];
        [task resume];
        self.currentDurationLabel.text = [self _timeDescOf:0];
    }
}

- (void)updateTotalDurationLabel {
    if (self.audioADBaseInfo && self.sdk.currentAudioADBaseInfo) {
        self.totalDurationLabel.text = [self _timeDescOf:self.sdk.currentAudioADBaseInfo.duration];
    } else {
        self.totalDurationLabel.text = [self _timeDescOf:self.sdk.currentSongBaseInfo.duration];
    }
}

- (IBAction)playButtonClicked:(id)sender {
    if (self.sdk.currentPlayerState == JX_PLAYER_STATE_PAUSE) {
        [self.sdk resumePlay];
    } 
}

- (IBAction)pauseButtonClicked:(id)sender {
    [self.sdk pausePlay];
}

- (IBAction)sliderValueChanged:(id)sender {
    JXSlider *slider = (JXSlider *)sender;
    float seekTime = slider.value * self.sdk.currentSongBaseInfo.duration;
    [self.sdk seekTo:seekTime];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self.sdk stopPlay];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)downloadButtonClicked:(id)sender {
    if ([self.downloadButton.currentTitle isEqualToString:@"Remove"]) {
        [self.sdk cleanDownloadedSongWithSongBaseInfo:self.songBaseInfo];
        [self.downloadButton setTitle:@"Download" forState:UIControlStateNormal];
        [SVProgressHUD showSuccessWithStatus:@"This song has been removed."];
        self.downloadTask = nil;
        return;
    }
    __weak __typeof(self)weakSelf = self;
    if (self.downloadTask.currentState == JXHttpDownloadTaskStateReady) {
        self.downloadTask = [self.sdk startDownloadWithSongBaseInfo:self.songBaseInfo
                                              startDownloadCallback:^(JX_START_DOWNLOAD_ERROR_CODE errorCode) {
            if (JX_START_DOWNLOAD_ERROR_CODE_NONE != errorCode) {
                [weakSelf _showMessage:[NSString stringWithFormat:@"download error:%ld", (long)errorCode]];
            }
        } progressCallback:^(long long totalBytesRead, long long totalBytesExpectedToRead) {
            [weakSelf _updateDownloadButtonWithTotalBytesRead:totalBytesRead
                                     totalBytesExpectedToRead:totalBytesExpectedToRead];
        } stateChangedCallback:^(JXHttpDownloadTaskState state) {
            [weakSelf _updateDownloadButtonWithDownloadState:state];
        } finishCallBack:^(BOOL success, NSError * _Nullable error) {
            [weakSelf _updateDownloadButtonWithDownloadResult:success];
            if (error) {
                [weakSelf _showMessage:[NSString stringWithFormat:@"download error:%ld", (long)error.code]];
            }
        }];
    } else if (self.downloadTask.currentState == JXHttpDownloadTaskStateRunning) {
        [self.downloadTask cancel];
    }
}
#pragma mark - JOOXiOSSDKPlayerDelegate
- (void)jxPlayerUpdateWithState:(JX_PLAYER_STATE)playState
{
    switch (playState) {
        case JX_PLAYER_STATE_INITED: // 播放器初始值
            break;
        case JX_PLAYER_STATE_OPENED: //已初始化数据，但是需要调用play来开始播放
            [self updateUIWhenDataReady];
            break;
        case JX_PLAYER_STATE_PLAYING: //播放
            self.playButton.hidden = YES;
            self.pauseButton.hidden = NO;
            [self updateTotalDurationLabel];
            break;
        case JX_PLAYER_STATE_BUFFERING: //播放中出现的缓冲
            break;
        case JX_PLAYER_STATE_PAUSE: //暂停
            self.playButton.hidden = NO;
            self.pauseButton.hidden = YES;
            break;
        case JX_PLAYER_STATE_WAITSEEK://等待seek
            break;
        case JX_PLAYER_STATE_SEEKING: //seeking
            break;
        case JX_PLAYER_STATE_ERR://错误
            break;
        case JX_PLAYER_STATE_FINISH://结束
            break;
        case JX_PLAYER_STATE_STOP://停止
            self.playButton.hidden = NO;
            self.pauseButton.hidden = YES;
            break;
        default:
            break;
    }
}

- (void)jxPlayerUpdateWithProgressTime:(double)progressTime
                          durationTime:(double)durationTime
                      bufferedProgress:(double)bufferedProgress
{
    self.currentDurationLabel.text = [self _timeDescOf:progressTime];
    
    self.cacheProgressView.progress = bufferedProgress;
    if (!self.playProgressSlider.isTracking) {
        self.playProgressSlider.value = progressTime / durationTime;
    }
}

- (void)jxPlayerRemoteControlType:(JX_REMOTE_CONTROL_TYPE)type progressWhenSeek:(float)time {
    switch (type) {
        case JX_REMOTE_CONTROL_TYPE_SEEK:
            [self.sdk seekTo:time];
            break;
        case JX_REMOTE_CONTROL_TYPE_PAUSE:
            [self.sdk pausePlay];
            break;
        case JX_REMOTE_CONTROL_TYPE_RESUEM:
            [self.sdk resumePlay];
            break;
        default:
            break;
    }
}

#pragma mark - private method
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

-(void)_showMessage:(NSString *)message
{
    [SVProgressHUD showInfoWithStatus:message];
}

- (void)_updateDownloadButtonWithDownloadState:(JXHttpDownloadTaskState)state
{
    NSString *stateString = @"Ready";
    switch (state) {
        case JXHttpDownloadTaskStateReady:
            stateString = @"Download";
            break;
        case JXHttpDownloadTaskStateRunning:
            stateString = @"Downloading";
            break;
        case JXHttpDownloadTaskStatePaused:
            stateString = @"Paused";
            break;
        case JXHttpDownloadTaskStateCanceling:
            stateString = @"Canceling";
            break;
        case JXHttpDownloadTaskStateFinished :
            stateString = @"Finished";
            break;
        default:
            break;
    }
    [self.downloadButton setTitle:stateString forState:UIControlStateNormal];
}

- (void)_updateDownloadButtonWithTotalBytesRead:(long long)totalBytesRead
                       totalBytesExpectedToRead:(long long)totalBytesExpectedToRead
{
    if (self.downloadTask.currentState == JXHttpDownloadTaskStateRunning) {
        NSString *progressString = [NSString stringWithFormat:@"%.2f/%.2fMB",totalBytesRead/1000000.0, totalBytesExpectedToRead/1000000.0];
        [self.downloadButton setTitle:progressString forState:UIControlStateNormal];
    }
}

- (void)_updateDownloadButtonWithDownloadResult:(BOOL)success
{
    NSString *finishString = success ? @"Remove" : @"Download failed";
    [self.downloadButton setTitle:finishString forState:UIControlStateNormal];
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

@end
