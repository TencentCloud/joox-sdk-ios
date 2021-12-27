//
//  JXSongBaseInfo.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/2/12.
//

#import <Foundation/Foundation.h>
#import "JXAlbumBaseInfo.h"
#import "JXSingerInfo.h"

/*!
 @brief Song type, local or online.
 */
typedef NS_ENUM(NSInteger, JXSongType)
{
    /*!
     @brief Online Song.
     */
    JXSongType_Online = 0,
    /*!
     @brief Local Song.
     */
    JXSongType_Local = 1,
    /*!
     @brief Downloaded Song.
     */
    JXSongType_Downloaded = 2,
};

/*!
 @brief Song quality.
 */
typedef NS_ENUM(NSInteger, JXSongQuality)
{
    /*!
     @brief 24K AAC (not support now).
     */
    JXSongQuality_24KAAC = 0,
    /*!
     @brief 48K AAC.
     */
    JXSongQuality_48KAAC = 1,
    /*!
     @brief 96K AAC.
     */
    JXSongQuality_96KAAC = 2,
    /*!
     @brief 128K MP3 (not support now).
     */
    JXSongQuality_128KMP3 = 3,
    /*!
     @brief 192K AAC.
     */
    JXSongQuality_192KAAC = 4,
    /*!
     @brief 320K MP3 (not support now）.
     */
    JXSongQuality_320KMP3 = 5,
    /*!
     @brief APE HIFI (not support now).
     */
    JXSongQuality_APEHIFI = 6,
    /*!
     @brief FLAC HIFI (not support now).
     */
    JXSongQuality_FLACHIFI = 7,
};

NS_ASSUME_NONNULL_BEGIN

@interface JXSongBaseInfo : NSObject<NSCoding, NSCopying, NSMutableCopying>

/*!
 * @brief Song type, see JXSongType.
 */
@property (nonatomic, assign) JXSongType type;
/*!
 * @brief Song quality, see JXSongQuality.
 */
@property (nonatomic, assign) JXSongQuality quality;
/*!
 * @brief Song openid.
 */
@property (nonatomic, strong) NSString *songOpenID;
/*!
 * @brief Song name.
 */
@property (nonatomic, strong) NSString *name;
/*!
 * @brief Song genre.
 */
@property (nonatomic, strong) NSString *genre;
/*!
 * @brief Song duration, s.
 */
@property (nonatomic, assign) double duration;
/*!
 * @brief Albume info.
 */
@property (nonatomic, strong) JXAlbumBaseInfo *albumBaseInfo;
/*!
 * @brief Singer array.
 */
@property (nonatomic, strong) NSArray<JXSingerInfo *> *singerInfoArray;

@end

NS_ASSUME_NONNULL_END
