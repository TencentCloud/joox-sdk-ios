//
//  JOOXiOSSDKDef.h
//  Pods
//
//  Created by JINPING SHI on 2020/2/7.
//

#ifndef JOOXiOSSDKDef_h
#define JOOXiOSSDKDef_h
#import <Foundation/Foundation.h>

/*!
 @brief Auth state.
 */
typedef NS_ENUM(NSInteger, JX_AUTH_STATE) {
    /*!
     @brief Not auth.
     */
    JX_AUTH_STATE_INITED    = 0,
    /*!
     @brief Auth running.
     */
    JX_AUTH_STATE_RUNNING   = 1,
    /*!
     @brief Auth cancelled.
     */
    JX_AUTH_STATE_CANCELLED  = 2,
    /*!
     @brief Auth failed.
     */
    JX_AUTH_STATE_FAILED    = 3,
    /*!
     @brief Auth success.
     */
    JX_AUTH_STATE_SUCCESS   = 4,
};

/*!
 @brief Player state.
 */
typedef NS_ENUM(NSInteger, JX_PLAYER_STATE) {
    /*!
     @brief Player init.
     */
    JX_PLAYER_STATE_INITED      = -1,
    /*!
     @brief Player opened.
     */
    JX_PLAYER_STATE_OPENED      = 0,
    /*!
     @brief Player playing.
     */
    JX_PLAYER_STATE_PLAYING     = 1,
    /*!
     @brief Player buffering.
     */
    JX_PLAYER_STATE_BUFFERING   = 2,
    /*!
     @brief Player pause.
     */
    JX_PLAYER_STATE_PAUSE       = 3,
    /*!
     @brief Player wait seek.
     */
    JX_PLAYER_STATE_WAITSEEK    = 4,
    /*!
     @brief Player seeking.
     */
    JX_PLAYER_STATE_SEEKING     = 5,
    /*!
     @brief Player error.
     */
    JX_PLAYER_STATE_ERR         = 10,
    /*!
     @brief Player finish.
     */
    JX_PLAYER_STATE_FINISH      = 11,
    /*!
     @brief Player stop.
     */
    JX_PLAYER_STATE_STOP        = 12,
};


/*!
 @brief Remote control type.
 */
typedef NS_ENUM(NSInteger, JX_REMOTE_CONTROL_TYPE) {
    /*!
     @brief Resume play.
     */
    JX_REMOTE_CONTROL_TYPE_RESUEM   = 0,
    /*!
     @brief Pause play.
     */
    JX_REMOTE_CONTROL_TYPE_PAUSE    = 1,
    /*!
     @brief Play next song.
     */
    JX_REMOTE_CONTROL_TYPE_NEXT     = 2,
    /*!
     @brief Play previous song.
     */
    JX_REMOTE_CONTROL_TYPE_PREVIOUS = 3,
    /*!
     @brief Seek current song.
     */
    JX_REMOTE_CONTROL_TYPE_SEEK     = 4,
};

/*!
 @brief Error code when start play.
 */
typedef NS_ENUM(NSInteger, JX_START_PLAY_ERROR_CODE) {
    /*!
     @brief Unknown error.
     */
    JX_START_PLAY_ERROR_CODE_UNKNOWN           = -1,
    /*!
     @brief No error.
     */
    JX_START_PLAY_ERROR_CODE_NONE              = 0,
    /*!
     @brief Update songinfo failed.
     */
    JX_START_PLAY_ERROR_CODE_UPDATE_SONG_INFO  = 1,
    /*!
     @brief Over label limit.
     */
    JX_START_PLAY_ERROR_CODE_OVER_LABEL_LIMIT  = 2,
    /*!
     @brief No downloaded file.
     */
    JX_START_PLAY_ERROR_CODE_NO_DOWNLOADED_FILE  = 3,
    /*!
     @brief Have no url.
     */
    JX_START_PLAY_ERROR_CODE_HAVE_NO_URL  = 4,
    /*!
     @brief Have no authority.
     */
    JX_START_PLAY_ERROR_CODE_HAVE_NO_AUTHORITY  = 5,
};

/*!
@brief Error code of JOOX api response.
*/
typedef NS_ENUM(NSInteger, JX_API_RESPONSE_ERROR_CODE) {
    /*!
     @brief Unknown error.
     */
    JX_API_RESPONSE_ERROR_CODE_UNKNOWN = -1,
    /*!
     @brief No error.
     */
    JX_API_RESPONSE_ERROR_CODE_NONE = 0,
    /*!
     @brief Net unavailable.
     */
    JX_API_RESPONSE_ERROR_CODE_NET_UNAVAILABLE = 1001,
    /*!
     @brief Net timeout.
     */
    JX_API_RESPONSE_ERROR_CODE_NET_TIMEOUT = 1002,
    /*!
     @brief Net initError.
     */
    JX_API_RESPONSE_ERROR_CODE_NET_INIT_ERROR = 1003,
    /*!
     @brief Bad request.
     */
    JX_API_RESPONSE_ERROR_CODE_BAD_REQUEST = 2001,
    /*!
     @brief Parse exception.
     */
    JX_API_RESPONSE_ERROR_CODE_PARSE_EXCEPTION = 2002,
    /*!
     @brief Unauthorized.
     */
    JX_API_RESPONSE_ERROR_CODE_UNAUTHORIZED = 2003,
    /*!
     @brief Forbidden.
     */
    JX_API_RESPONSE_ERROR_CODE_FORBIDDEN = 2004,
    /*!
     @brief Too many requests.
     */
    JX_API_RESPONSE_ERROR_CODE_TOO_MANY_REQUESTS = 2005,
    /*!
     @brief Internal server error.
     */
    JX_API_RESPONSE_ERROR_CODE_INTERNAL_SERVER_ERROR = 2006,
    /*!
     @brief Service unavailable.
     */
    JX_API_RESPONSE_ERROR_CODE_SERVICE_UNAVAILABLE = 2007,
    /*!
     @brief Over frequency limit.
     */
    JX_API_RESPONSE_ERROR_CODE_OVER_FREQUENCY_LIMIT = 2008,
    /*!
     @brief Token is not expired.
     */
    JX_API_RESPONSE_ERROR_CODE_TOKEN_NOT_EXPIRED = 3001,
};

/*!
 @brief Error code when start download.
 */
typedef NS_ENUM(NSInteger, JX_START_DOWNLOAD_ERROR_CODE) {
    /*!
     @brief Unknown error.
     */
    JX_START_DOWNLOAD_ERROR_CODE_UNKNOWN           = -1,
    /*!
     @brief No error.
     */
    JX_START_DOWNLOAD_ERROR_CODE_NONE              = 0,
    /*!
     @brief Update songinfo failed.
     */
    JX_START_DOWNLOAD_ERROR_CODE_UPDATE_SONG_INFO  = 1,
    /*!
     @brief Have no url.
     */
    JX_START_DOWNLOAD_ERROR_CODE_HAVE_NO_URL  = 2,
    /*!
     @brief Have no authority.
     */
    JX_START_DOWNLOAD_ERROR_CODE_HAVE_NO_AUTHORITY  = 3,
};

/*!
@brief JOOX download task state.
*/
typedef NS_ENUM(NSInteger, JXHttpDownloadTaskState) { /** The task state */
    /*!
     @brief The task is ready to run.
     */
    JXHttpDownloadTaskStateReady = 0,
    /*!
     @brief The task is running.
     */
    JXHttpDownloadTaskStateRunning = 1,
    /*!
     @brief The task is paused.
     */
    JXHttpDownloadTaskStatePaused = 2,
    /*!
     @brief The task is canceling.
     */
    JXHttpDownloadTaskStateCanceling = 3,
    /*!
     @brief The task has completed and will receive no more delegate notifications.
     */
    JXHttpDownloadTaskStateFinished = 4
};

#endif /* JOOXiOSSDKDef_h */
