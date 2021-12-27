//
//  JXAlbumBaseInfo.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/30.
//

#import <Foundation/Foundation.h>
#import "JXSingerInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface JXAlbumBaseInfo : NSObject<NSCoding, NSCopying, NSMutableCopying>

/*!
 * @brief Album openid.
 */
@property (nonatomic, strong) NSString *albumOpenID;
/*!
 * @brief Album name.
 */
@property (nonatomic, strong) NSString *name;
/*!
 * @brief Album cover url.
 */
@property (nonatomic, strong) NSString *coverUrl;
/*!
 * @brief Album singer array.
 */
@property (nonatomic, strong) NSArray<JXSingerInfo *> *singerInfoArray;

@end

NS_ASSUME_NONNULL_END
