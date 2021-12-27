//
//  JOOXiOSSDK.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/7/23.
//  Copyright © 2019 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JOOXiOSSDK/JOOXiOSSDKDef.h>
#import <JOOXiOSSDK/JOOXiOSSDKDelegate.h>
#import <JOOXiOSSDK/JXSongBaseInfo.h>
#import <JOOXiOSSDK/JXSongDownloadTask.h>
#import <JOOXiOSSDK/JXAudioADBaseInfo.h>

//! Project version number for JOOXiOSSDK.
FOUNDATION_EXPORT double JOOXiOSSDKVersionNumber;

//! Project version string for JOOXiOSSDK.
FOUNDATION_EXPORT const unsigned char JOOXiOSSDKVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <JOOXiOSSDK/PublicHeader.h>
NS_ASSUME_NONNULL_BEGIN
@interface JOOXiOSSDK : NSObject

/*!
 * @brief The object that acts as the delegate of JOOXiOSSDK.
 */
@property (nonatomic, weak) id<JOOXiOSSDKDelegate> delegate;

@property (nonatomic, weak) id<JOOXiOSSDKPlayerDelegate> playerDelegate;

/*!
 * @brief  Default auth type: qrcode/phone/email.
 */
@property (nonatomic, strong) NSString *defaultAuthMode;

/*!
 * @brief Current auth status.
 */
@property (nonatomic, assign, readonly) JX_AUTH_STATE currentAuthState;

/*!
 * @brief Current playing song's infomation.
 */
@property (nonatomic, strong, readonly) JXSongBaseInfo *currentSongBaseInfo;

/*!
* @brief Current playing audio ad's infomation.
*/
@property (nonatomic, strong, readonly) JXAudioADBaseInfo *currentAudioADBaseInfo;

/*!
 * @brief Current player state.
 */
@property (nonatomic, assign, readonly) JX_PLAYER_STATE currentPlayerState;

/*!
 * @brief Current error.
 */
@property (nonatomic, strong, readonly) NSError *error;

/*!
 * @brief unavailable，please call serviceWithAppID to init.
 */
+ (instancetype)alloc __attribute__((unavailable("alloc not available, call serviceWithAppID:appName: instead")));

/*!
 * @brief unavailable，please call serviceWithAppID to init.
 */
- (instancetype)init __attribute__((unavailable("init not available, call serviceWithAppID:appName: instead")));

/*!
 * @brief unavailable，please call serviceWithAppID to init.
 */
+ (instancetype)new __attribute__((unavailable("new not available, call serviceWithAppID:appName: instead")));

/**
 @brief Initializes and returns a JOOXiOSSDK object.
 
 @param appID Application's ID.
 @param appName Application's name.
 @param scopeList Scope list.
 @param defaultAuthMode default auth type: qrcode/phone/email.
 @param delegate A JOOXiOSSDKDelegate object.
 
 @return A JOOXiOSSDK object.
 */
+ (instancetype)serviceWithAppID:(NSString *)appID
                         appName:(NSString *)appName
                       scopeList:(NSArray<NSString *> *)scopeList
                 defaultAuthMode:(NSString *)defaultAuthMode
                        delegate:(id<JOOXiOSSDKDelegate>)delegate;

/**
 @brief Handle auth callback, need call this funcation at AppDelegate's funcation: application:openURL:options:
 
 @param url The URL resource to open. This resource can be a network resource or a file. For information about the Apple-registered URL schemes, see Apple URL Scheme Reference.
 @param options A dictionary of URL handling options. For information about the possible keys in this dictionary and how to handle them, see UIApplicationOpenURLOptionsKey. By default, the value of this parameter is an empty dictionary.
 */
+ (void)handleOpenURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options;

/**
 @brief Auth.
 */
- (void)auth;

/**
 @brief Obtain authorization by ticket token.
 
 @param ticketToken The ticket token obtained from server.
 */
- (void)authWithTicketToken:(NSString *)ticketToken;

/**
 @brief Logout.
 */
- (void)logout;

/**
 @brief do JOOX open api request
 
 @param urlPathString The path part of openapi url(scheme://host:port/path?query).
 @param urlQueryString The query part of openapi url(scheme://host:port/path?query).
 @param callback The callback of this request. errorCode: see JX_API_RESPONSE_ERROR_CODE; jsonResult: the response json string.
 */
- (void)doJOOXRequestWithUrlPathString:(NSString *)urlPathString
                        urlQueryString:(NSString *)urlQueryString
                              callback:(void(^)(JX_API_RESPONSE_ERROR_CODE errorCode, NSString *jsonResult))callback;

/**
 @brief play song
 
 @param songBaseInfo The JXSongBaseInfo object.
 @param callback The callback of play request. error: see JX_START_PLAY_ERROR_CODE.
 */
- (void)playWithSongBaseInfo:(JXSongBaseInfo *)songBaseInfo
                    callback:(void(^)(JX_START_PLAY_ERROR_CODE errorCode))callback;

/**
@brief play audio advertisement

@param audioADBaseInfo The JXAudioADBaseInfo object.
@param callback The callback of play request. error: see JX_START_PLAY_ERROR_CODE.
*/
- (void)playWithAduidoADBaseInfo:(JXAudioADBaseInfo *)audioADBaseInfo
                        callback:(void(^)(JX_START_PLAY_ERROR_CODE errorCode))callback;

/**
 @brief Seek to time(s).
 
 @param time The time that you want seek to.
 */
- (void)seekTo:(float)time;

/**
 @brief Resume play.
 */
- (void)resumePlay;

/**
 @brief Pause play.
 */
- (void)pausePlay;

/**
 @brief Stop play.
 */
- (void)stopPlay;

/**
 @brief Start download one song.
 
 @param songBaseInfo The JXSongBaseInfo object.
 @param startDownloadCallback The callback of start download, see jxSongDownloadStartDownloadCallbackBlock.
 @param progressCallback The callback of download progress, see jxSongDownloadProgressCallbackBlock.
 @param stateChangedCallback The callback when download state is changed, see jxSongDownloadStateChangedCallbackBlock.
 @param finishCallback The callback when download is finished, see jxSongDownloadFinishCallbackBlock.
 
 @return JXSongDownloadTask object.
 */
- (JXSongDownloadTask *)startDownloadWithSongBaseInfo:(JXSongBaseInfo *)songBaseInfo
                                startDownloadCallback:(jxSongDownloadStartDownloadCallbackBlock)startDownloadCallback
                                     progressCallback:(jxSongDownloadProgressCallbackBlock)progressCallback
                                 stateChangedCallback:(jxSongDownloadStateChangedCallbackBlock)stateChangedCallback
                                       finishCallBack:(jxSongDownloadFinishCallbackBlock)finishCallback;

/**
 @brief Check whether song is  downloaded.
 
 @param songBaseInfo The JXSongBaseInfo object.
 
 @return YES if is downloaded, otherwise return NO.
 */
- (BOOL)isDownloadedSongWithSongBaseInfo:(JXSongBaseInfo *)songBaseInfo;

/**
 @brief Delete  downloaded song if exists.
 
 @param songBaseInfo The JXSongBaseInfo object.
 */
- (void)cleanDownloadedSongWithSongBaseInfo:(JXSongBaseInfo *)songBaseInfo;

/**
@brief get JOOX Audio Advertisement.

@param callback  The callback of this request. error:nil if have no error; jsonDictionary: the response json dictionary.
*/
- (void)getAudioADWithCallback:(void(^)(NSError * _Nullable error,  NSDictionary * _Nullable jsonDictionary))callback;

/**
 @brief Open JOOX, if not installed, goto JOOX download page.
 @return YES if successed, NO if failed.
 */
+ (BOOL)openJOOX;

/**
 @brief Open debug Tool, if need use this tool, call this funcation at AppDelegate's funcation: application:didFinishLaunchingWithOptions:
 @param window Current main window.
 */
+ (void)openDebugToolOnWindow:(UIWindow *)window;

@end
NS_ASSUME_NONNULL_END
