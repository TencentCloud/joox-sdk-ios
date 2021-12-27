# JOOXiOSSDK

## Getting Started

### Apply for App ID

Apply for **App ID** through JOOX Open API platform: http://open.joox.ibg.com/main/application/add (Only support our partnter now, please contact us if you need).

### Installation

1. Use pods to install following library:

   `KVOController (version: 1.2.0)`

   `WebViewJavascriptBridge (version: 6.0.3)`

   `AFNetworking (version: 3.2.1)`

   `CocoaAsyncSocket (version: 7.6.3)`

   `MMKV (version: 1.0.23)`

   `SSZipArchive (version: 2.2.2)`

2. Select `TARGETS` of your application, add `LSApplicationQueriesSchemes`  under `info`,  add one string item: `wemusic`

3. Select `TARGETS` of your application, add `URL Types` under `info`,  `URL scheme` is the **App ID** that you applied through JOOX Open API platform.

4. If need use background play, select `Singing & Capabilities`, add `Background Modes,` select `Audio,AirPlay,and Picture in Picture` `External accessory communication` `Background fetch` `Remote notifications`

5. Unzip `JOOXiOSSDK.zip` to your project folder, and add the `JOOXiOSSDK` folder to your project.

6. Select `Build Settings`, add `$(inherited)` , `{SDK_ROOT}/usr/include/libxml2` and `(SRCROOT)/[Where you unzip JOOXiOSSDK.zip to]/Dependency/openSSLSDK/include/` to  `Header Search Paths` .

7. Select `General`, add `libz.tdb, libiconv.tbd, libresolve.tbd, libc++.tbd, libxml2.tbd` to `Frameworks, Libraries, and Embedded Content`.

8. Select `Build Settings`, set `Enable Bitcode` to `NO`.

9. Select `Build Settings`, add `$(inherited)`, `-ObjC` to  `Other Linker Flags` .

10. Select `Build Settings`, set `C Language Dialect` to `GNU99`.

11. Add `#import <JOOXiOSSDK/JOOXiOSSDK.h>`to your `appdelegate` source file and add following lines:

```objective-c
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
	[JOOXiOSSDK handleOpenURL:url options:options];
	return YES;
}
```

### API Document

https://docs.google.com/document/d/1QewXeKDu02llwFJVRCWLyFccK_4Wov93X4cwXCM4aUM/edit?usp=sharing

### Quick Tutorial

#### Init service（Must call this at first）

```objective-c
self.sdk = [JOOXiOSSDK serviceWithAppID://your app id
                                appName://your app name
                              scopeList:@[@"public",
                                          @"user_profile",
                                          @"playmusic"]
                        defaultAuthMode://qrcode/phone/email
                               delegate:self];
```

#### Auth（Must call this after Init service）

```objective-c
// Auth
[self.sdk auth];
// Or
// Auth with ticket token
[self.sdk authWithTicketToken:ticketToken];
```

#### Logout

```objective-c
[self.sdk logout];
```

#### Auth delegate

```objective-c
- (void)jxAuthStateUpdate:(JX_AUTH_STATE)authState
{
    if (authState == JX_AUTH_STATE_SUCCESS) {
        // auth success
    } else if (authState == JX_AUTH_STATE_RUNNING) {
        // auth running
    } else if (authState == JX_AUTH_STATE_CANCELLED) {
        // auth cancelled
    } else if (authState == JX_AUTH_STATE_FAILED) {
        // auth failed
    }
}
```

#### doJOOXRequest (path&query See API Document)

```objective-c
[self.sdk doJOOXRequestWithUrlPathString://The path part of openapi url(scheme://host:port/path?query).
                          urlQueryString:The query part of openapi url(scheme://host:port/path?query).
                                callback:^(JX_API_RESPONSE_ERROR_CODE errorCode, NSString * _Nonnull jsonResult) {
            if (JX_API_RESPONSE_ERROR_CODE_NONE == errorCode) {
                // do something when success
            } else {
                // do something when failed
            }
}];
```

#### Play Song

```objective-c
[self.sdk playWithSongBaseInfo:self.songInfo
                      callback:^(JX_START_PLAY_ERROR_CODE errorCode) {
        if (JX_START_PLAY_ERROR_CODE_NONE != errorCode) {
          // do something if have error
        }
}];
```

#### Play Advertisement Audio

```objective-c
[self.sdk playWithAduidoADBaseInfo:self.audioADBaseInfo
                          callback:^(JX_START_PLAY_ERROR_CODE errorCode) {
        if (JX_START_PLAY_ERROR_CODE_NONE != errorCode) {
          // do something if have error
        }
}];
```

#### Pause

```objective-c
[self.sdk pausePlay];
```

#### Stop

```objective-c
[self.sdk stopPlay];
```

#### Resume

```objective-c
[self.sdk resumePlay];
```

#### SeekTo (time: s)

```objective-c
[self.sdk seekTo:time];
```


#### Get JOOX Audio Advertisement.

```objective-c
[self.sdk getAudioADWithCallback:^(NSError * _Nullable error, NSDictionary * _Nullable jsonDictionary) {
    if (error) {
        // handle error
    } else {
        // handle success, eg: parse jsonDictionary, see JXAudioADParser in Demo
    }
}];
```


#### Player status delegate

```objective-c
- (void)jxPlayerUpdateWithState:(JX_PLAYER_STATE)playState
{
    switch (playState) {
        case JX_PLAYER_STATE_INITED:
            break;
        case JX_PLAYER_STATE_OPENED:
            break;
        case JX_PLAYER_STATE_PLAYING:
            break;
        case JX_PLAYER_STATE_BUFFERING:
            break;
        case JX_PLAYER_STATE_PAUSE:
            break;
        case JX_PLAYER_STATE_WAITSEEK:
            break;
        case JX_PLAYER_STATE_SEEKING:
            break;
        case JX_PLAYER_STATE_ERR:
            break;
        case JX_PLAYER_STATE_FINISH:
            break;
        case JX_PLAYER_STATE_STOP:
            break;
        default:
            break;
    }
}
```

#### Player progress delegate

```objective-c
- (void)jxPlayerUpdateWithProgressTime:(double)progressTime
                          durationTime:(double)durationTime
                      bufferedProgress:(double)bufferedProgress
{
    // progressTime: already played time(s)
    // durationTime: song's total time(s)
    // bufferedProgress: has buffered progress, from 0.00 to 1.00
}
```

#### Player remote control delegate

```objective-c
- (void)jxPlayerRemoteControlType:(JX_REMOTE_CONTROL_TYPE)type
                 progressWhenSeek:(float)time
{
    // type: The remote control type, see JX_REMOTE_CONTROL_TYPE.
    // time: The seek time(s) when type is JX_REMOTE_CONTROL_TYPE_SEEK.
}
```

#### Start one download task

```objective-c
[self.sdk startDownloadWithSongBaseInfo:// JXSongBaseInfo object
                  startDownloadCallback:// handle start result callback
                       progressCallback:// handle progress changed callback
                   stateChangedCallback:// handle state changed callback
                         finishCallBack:// handle finish callback
];
```

#### Judge whether song has been downloaded

```objective-c
[self.sdk isDownloadedSongWithSongBaseInfo:/*JXSongBaseInfo object*/];
```

#### Clean downloaded song

```objective-c
[self.sdk cleanDownloadedSongWithSongBaseInfo:/*JXSongBaseInfo object*/];
```

#### Open JOOX(Open download page if not install JOOX on device)

```objective-c
[JOOXiOSSDK openJOOX];
```

#### Open Debug Tool

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   [JOOXiOSSDK openDebugToolOnWindow:self.window];
   return YES;

}
```



### Used OpenSource Code

`KVOController (version: 1.2.0)`

`WebViewJavascriptBridge (version: 6.0.3)`

`AFNetworking (version: 3.2.1)`

`CocoaAsyncSocket (version: 7.6.3)`

`MMKV (version: 1.0.23)`

`SSZipArchive (version: 2.2.2)`

`mars (version: 1.3.0)`

`libFLAC`

`openSSLSDK`



## Author

shchcao, shchcao@tencent.com



## License

JOOXiOSSDK is available under the MIT license. See the LICENSE file for more info.
