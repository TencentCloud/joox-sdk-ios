//
//  JXPlayListInfo.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/2/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXPlayListInfo : NSObject<NSCoding, NSCopying, NSMutableCopying>

/*!
 * @brief 歌单id
 */
@property (nonatomic, strong) NSString *playListOpenID;

/*!
 * @brief 歌单名称
 */
@property (nonatomic, strong) NSString *name;

/*!
 * @brief 歌单封面url
 */
@property (nonatomic, strong) NSString *coverUrl;

/*!
 * @brief 歌单歌曲数
 */
@property (nonatomic, assign) unsigned int trackNum;

/*!
 * @brief 更新时间
 */
@property (nonatomic, strong) NSString *publishDate;

@end

NS_ASSUME_NONNULL_END
