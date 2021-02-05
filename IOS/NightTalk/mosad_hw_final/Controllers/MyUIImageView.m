//
//  MyUIImageView.m
//  NightTalk
//
//  Created by Jason on 2020/12/23.
//  Copyright © 2020 Jason. All rights reserved.
//

#import "MyUIImageView.h"

@implementation MyUIImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)attachTapHandler
{
    //用户交互的总开关
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    //点击次数
    //touch.numberOfTapsRequired = 2;
    touch.minimumPressDuration = 1;
    [self addGestureRecognizer:touch];
    
}

//绑定事件
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self attachTapHandler];
    }
    return self;
}
//同上
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self attachTapHandler];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer
{
    [self becomeFirstResponder];
}

@end
