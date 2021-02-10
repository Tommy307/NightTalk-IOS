//
//  AboutView.m
//  NightTalk
//
//  Created by itlab on 2021/1/4.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AboutView.h"

@implementation AboutView

- (instancetype)initWithFrame:(CGRect)frame{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.97];
    
    UIImageView *returnIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 45, 30, 30)];
    returnIcon.image = [UIImage imageNamed:@"fanhui.png"];
    returnIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapreturn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(return2Plane)];
    [returnIcon addGestureRecognizer:tapreturn];
    [self addSubview:returnIcon];
    
    self.regitTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120)];
    self.regitTitle.text = @"关于软件";
    self.regitTitle.textAlignment = NSTextAlignmentCenter;
    self.regitTitle.font = [UIFont systemFontOfSize:22];
    [self addSubview:self.regitTitle];
    
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-80, 150, 160, 160)];
    self.avatar.layer.masksToBounds = YES;
    // self.avatar.backgroundColor = [UIColor grayColor];
    self.avatar.image = [UIImage imageNamed:@"icon152.png"];
    self.avatar.layer.borderWidth = 1;
    self.avatar.layer.borderColor = [UIColor grayColor].CGColor;
    self.avatar.layer.cornerRadius = 10;
    [self addSubview: self.avatar];
    
    //appname
    self.appname = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-150, 350, 300, 20)];
    self.appname.textAlignment = NSTextAlignmentCenter;
    self.appname.font = [UIFont boldSystemFontOfSize:20];
    self.appname.text = @"NightTalk";
    [self addSubview:self.appname];
    
    self.appver = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width / 2 - 100, 375, 200, 10)];
    self.appver.textAlignment = NSTextAlignmentCenter;
    self.appver.font = [UIFont systemFontOfSize:10];
    self.appver.textColor = [UIColor grayColor];
    self.appver.text = @"Version: 0.2";
    [self addSubview:self.appver];
    
    
    self.copyright = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-150, self.bounds.size.height - 160, 300, 20)];
    self.copyright.textAlignment = NSTextAlignmentCenter;
    self.copyright.font = [UIFont systemFontOfSize:10];
    self.copyright.textColor = [UIColor grayColor];
    self.copyright.text = @"Copyright © 2020-∞ DaGe Inc.";
    [self addSubview:self.copyright];
    
    self.copyright2 = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-150, self.bounds.size.height - 140, 300, 20)];
    self.copyright2.textAlignment = NSTextAlignmentCenter;
    self.copyright2.font = [UIFont systemFontOfSize:10];
    self.copyright2.textColor = [UIColor grayColor];
    self.copyright2.text = @"All Rights Reserved";
    [self addSubview:self.copyright2];
    
    self.func = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/2-150, 430, 300, 80)];
    self.func.numberOfLines = 0;
    self.func.textAlignment = NSTextAlignmentCenter;
    self.func.font = [UIFont boldSystemFontOfSize:17];
    self.func.text = @"Let's talk!\nAn Easy and Beautifual Social Chat App";
    [self addSubview:self.func];
    
    return self;
}

-(void)return2Plane{
    NSLog(@"return to user plane");
    [self removeFromSuperview];
}

@end
