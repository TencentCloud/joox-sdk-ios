#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JOOXiOSSDK.h"
#import "JOOXiOSSDKDef.h"
#import "JOOXiOSSDKDelegate.h"
#import "JXAlbumBaseInfo.h"
#import "JXAudioADBaseInfo.h"
#import "JXSingerInfo.h"
#import "JXSongBaseInfo.h"
#import "JXSongDownloadTask.h"
#import "JXJsonHelper.h"

FOUNDATION_EXPORT double JOOXiOSSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char JOOXiOSSDKVersionString[];

