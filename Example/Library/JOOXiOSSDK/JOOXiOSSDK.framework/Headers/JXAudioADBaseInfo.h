//
//  JXAudioADBaseInfo.h
//  JOOXiOSSDK
//
//  Created by JINPING SHI on 2020/3/6.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface JXAudioADBaseInfo : NSObject<NSCoding, NSCopying, NSMutableCopying>

/*!
 * @brief Advertisement id.
 */
@property (nonatomic, strong) NSString *adID;
/*!
 * @brief Advertisement title.
 */
@property (nonatomic, strong) NSString *title;
/*!
 * @brief Advertisement subTtitle.
 */
@property (nonatomic, strong) NSString *subTitle;
/*!
 * @brief Advertisement image url.
 */
@property (nonatomic, strong) NSString *imageURL;
/*!
 * @brief Advertisement duration,s.
 */
@property (nonatomic, assign) double duration;
/*!
 * @brief Advertisement audio url.
 */
@property (nonatomic, strong) NSString *audioURL;

@end

NS_ASSUME_NONNULL_END
