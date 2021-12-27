//
//  JXTopListInfo.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2019/8/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXTopListInfo : NSObject<NSCoding, NSCopying, NSMutableCopying>

/*!
 * @brief 排行版id
 */
@property (nonatomic, strong) NSString *topListOpenID;
/*!
 * @brief 排行版名称
 */
@property (nonatomic, strong) NSString *name;
/*!
 * @brief 排行榜歌曲数
 */
@property (nonatomic, assign) unsigned int trackNum;
/*!
 * @brief 更新时间
 */
@property (nonatomic, strong) NSString *updateTime;

@end

NS_ASSUME_NONNULL_END
