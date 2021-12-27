//
//  JXPlayerViewController.h
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2019/8/27.
//  Copyright © 2019 jinpingshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JOOXiOSSDK;
@class JXSongBaseInfo;
@class JXAudioADBaseInfo;
NS_ASSUME_NONNULL_BEGIN

@interface JXPlayerViewController : UIViewController

@property (strong, nonatomic) JOOXiOSSDK *sdk;
@property (strong, nonatomic) JXSongBaseInfo *songBaseInfo;
@property (strong, nonatomic) JXAudioADBaseInfo *audioADBaseInfo;

@end

NS_ASSUME_NONNULL_END
