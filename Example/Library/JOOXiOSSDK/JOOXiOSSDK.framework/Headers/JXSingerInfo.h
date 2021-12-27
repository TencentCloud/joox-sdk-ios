//
//  JXSingerInfo.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXSingerInfo : NSObject<NSCoding, NSCopying, NSMutableCopying>

/*!
 * @brief Singer openid.
 */
@property (nonatomic, strong) NSString *singerOpenID;
/*!
 * @brief Singer name.
 */
@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
