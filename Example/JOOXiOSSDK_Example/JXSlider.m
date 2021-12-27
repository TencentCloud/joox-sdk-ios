//
//  JXSlider.m
//  JOOXiOSSDK_Example
//
//  Created by JINPING SHI on 2019/8/9.
//  Copyright © 2019 jinpingshi. All rights reserved.
//

#import "JXSlider.h"

@implementation JXSlider

- (CGRect)trackRectForBounds:(CGRect)bounds
{
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

@end
