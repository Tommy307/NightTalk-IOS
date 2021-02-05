//
//  MatchViewController.h
//  mosad_hw_final
//
//  Created by Jason on 2020/12/17.
//  Copyright © 2020 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoBallRotationProgressBar.h"

NS_ASSUME_NONNULL_BEGIN

@class CAEmitterLayer;

@interface MatchViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView * imageView;
    UILabel * label;
    TwoBallRotationProgressBar * progressBar;
    NSTimer * timer;
    int matchTime;
    //取消匹配
    UIButton * cancel;
    
    //用于获取房间是否已满的信息
    NSString * message;
}

@property (strong) CAEmitterLayer *fireEmitter;
@property (strong) CAEmitterLayer *smokeEmitter;

//- (void) controlFireHeight:(id)sender;
- (void) setFireAmount:(float)zeroToOne;


@end

NS_ASSUME_NONNULL_END
