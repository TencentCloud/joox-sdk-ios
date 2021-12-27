//
//  JXPlayerSongListViewController.h
//  WeMusic
//
//  Created by satyapeng on 27/7/2018.
//

#import <UIKit/UIKit.h>

@class JOOXiOSSDK;

@interface JXPlayerSongListViewController : UIViewController

@property (strong, nonatomic) JOOXiOSSDK *sdk;
@property (assign, nonatomic) BOOL isADPlaylist;
@property (strong, nonatomic) NSString *playlistID;

@end
