//
//  JOOXiOSSDKDelegate.h
//  Pods
//
//  Created by JINPING SHI on 2019/8/7.
//

#ifndef JOOXiOSSDKDelegate_h
#define JOOXiOSSDKDelegate_h
#import <Foundation/Foundation.h>
#import <JOOXiOSSDK/JOOXiOSSDKDef.h>

@protocol JOOXiOSSDKPlayerDelegate <NSObject>
@optional
/*!
 @brief Player state change callback.
 
 @param playState The new player state.
 */
- (void)jxPlayerUpdateWithState:(JX_PLAYER_STATE)playState;

/*!
 @brief Player progress change callback.
 
 @param progressTime Current progress time(s).
 @param durationTime Total duration time(s).
 @param bufferedProgress Buffered data progress, from 0.00 to 1.00.
 */
- (void)jxPlayerUpdateWithProgressTime:(double)progressTime
                          durationTime:(double)durationTime
                      bufferedProgress:(double)bufferedProgress;

/*!
 @brief Player remote control callback (On lock screen).
 
 @param type The remote control type, see JX_REMOTE_CONTROL_TYPE.
 @param time The seek time(s) when type is JX_REMOTE_CONTROL_TYPE_SEEK.
 */
- (void)jxPlayerRemoteControlType:(JX_REMOTE_CONTROL_TYPE)type
                 progressWhenSeek:(float)time;

@end

/*!
@brief Methods for listening auth state changed, song list update finish, player state or progress changed, and log callback in a JOOXiOSSDK object.
*/
@protocol JOOXiOSSDKDelegate <NSObject>

@optional
/*!
 @brief Auth state change callback.
 
 @param authState The new auth state.
 */
- (void)jxAuthStateUpdate:(JX_AUTH_STATE)authState;

/*!
 @brief JOOXiOSSDK's inner log callback.
 
 @param level Log level, for example:Debug
 @param moduleName Log module.
 @param fileName The file name.
 @param lineNumber The line number.
 @param funName The funcation name.
 @param message Log message.
 */
- (void)jxLogWithLevel:(NSString *)level
            moduleName:(const char*)moduleName
              fileName:(const char *)fileName
            lineNumber:(NSInteger)lineNumber
               funName:(const char *)funName
               message:(NSString *)message;

@end

#endif /* JOOXiOSSDKDelegate_h */
