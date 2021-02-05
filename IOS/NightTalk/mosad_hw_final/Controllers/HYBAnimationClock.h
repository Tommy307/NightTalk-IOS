//
//  HYBAnimationClock.h
//  HYBClockDemo
//
//  Created by huangyibiao on 16/3/15.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBAnimationClock : UIView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;
- (void)addSecondAnimationWithAngle:(CGFloat)angle;
- (void)addMinuteAnimationWithWithAngle:(CGFloat)angle;
- (void)addHourAnimationWithAngle:(CGFloat)angle;
@end
