//
//  JXSongDownloadTask.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/2/13.
//

#import <Foundation/Foundation.h>
#import "JOOXiOSSDKDef.h"
#import "JXSongBaseInfo.h"

/*!
@brief Start download callback

@param errorCode The error code when start download. See JX_START_DOWNLOAD_ERROR_CODE.
*/
typedef void (^jxSongDownloadStartDownloadCallbackBlock)(JX_START_DOWNLOAD_ERROR_CODE errorCode);

/*!
@brief Download task's progress is changed callback.

@param totalBytesRead The total bytes read.
@param totalBytesExpectedToRead The expected total bytes to read.
*/
typedef void (^jxSongDownloadProgressCallbackBlock)(long long totalBytesRead, long long totalBytesExpectedToRead);

/**
@brief Download task's state is changed callback.
 
@param state The state of http task. See JXHttpDownloadTaskState.
*/
typedef void (^jxSongDownloadStateChangedCallbackBlock)(JXHttpDownloadTaskState state);
/**
@brief Download task is finished callback.

@param success The task result, YES if success, NO if failed.
@param error The task error, nil if have no error.
*/
typedef void (^jxSongDownloadFinishCallbackBlock)(BOOL success, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface JXSongDownloadTask : NSObject

/**
@brief JXSongBaseInfo object.
*/
@property (nonatomic, strong, readonly) JXSongBaseInfo *currentSongBaseInfo;
/**
@brief Current download state.
*/
@property (nonatomic, assign, readonly) JXHttpDownloadTaskState currentState;
/**
@brief  Start download result callback.
*/
@property (nonatomic, copy) jxSongDownloadStartDownloadCallbackBlock startDownloadCallback;
/**
@brief  Download progress callback.
*/
@property (nonatomic, copy) jxSongDownloadProgressCallbackBlock progressCallback;
/**
@brief  Download state is changed callback.
*/
@property (nonatomic, copy) jxSongDownloadStateChangedCallbackBlock stateChangedCallback;
/**
@brief  Download is finished callback.
*/
@property (nonatomic, copy) jxSongDownloadFinishCallbackBlock finishCallback;

/**
 @brief Start download one song.
 
 @param songBaseInfo The JXSongBaseInfo object.
 @param startDownloadCallback The callback of start download, see jxSongDownloadStartDownloadCallbackBlock.
 @param progressCallback The callback of download progress, see jxSongDownloadProgressCallbackBlock.
 @param stateChangedCallback The callback when download state is changed, see jxSongDownloadStateChangedCallbackBlock.
 @param finishCallback The callback when download is finished, see jxSongDownloadFinishCallbackBlock.
 */
- (void)startDownloadWithSongBaseInfo:(JXSongBaseInfo *)songBaseInfo
                startDownloadCallback:(jxSongDownloadStartDownloadCallbackBlock)startDownloadCallback
                     progressCallback:(jxSongDownloadProgressCallbackBlock)progressCallback
                 stateChangedCallback:(jxSongDownloadStateChangedCallbackBlock)stateChangedCallback
                       finishCallBack:(jxSongDownloadFinishCallbackBlock)finishCallback;

/**
@brief Cancel current download task.
*/
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
