//
//  AppDelegate.m
//  mosad_hw_final
//
//  Created by Jason on 2020/12/17.
//  Copyright © 2020 Jason. All rights reserved.
//

#import "AppDelegate.h"
#import "MatchViewController.h"
#import "TalkingViewController.h"
#import "UIImage+GIF.h"

@interface AppDelegate ()
@property (nonatomic , strong)UIImageView *adView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.isLogin = false;
    self.userId = (uint)-1;           // 未登录 id 为 -1，正常的 id 从 1 开始
    self.userName = @"";
    self.password = @"";
    self.userAvatar = [UIImage imageNamed:@"haimianbaobao.jpg"];
    self.score = (uint)0;
//    self.isLogin = true;
//    self.userId = (uint)-1;           // 未登录 id 为 -1，正常的 id 从 1 开始
//    self.userName = @"11";
//    self.password = @"11";
//    self.userAvatar = [UIImage imageNamed:@"haimianbaobao.jpg"];
//    self.score = (uint)100;
    
    self.topicIsChosed = NO;
    self.notificationIsOpen = NO;
    
    self.roomID = (uint)0;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.matchViewController = [[MatchViewController alloc] init];
    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:_matchViewController];
    [self.window setRootViewController:nvc];
    
//    TalkingViewController * talkingViewController = [[TalkingViewController alloc] init];
//    [self.window setRootViewController:talkingViewController];
    
//    self.matchViewController = [[TopicBankTableViewController alloc] init];
//    UINavigationController * nvc = [[UINavigationController alloc] initWithRootViewController:_matchViewController];
//    [self.window setRootViewController:nvc];
    
//    self.URL = @"http://172.26.103.135:8081/";
    self.URL = @"http://172.26.72.61:8000/";
//添加启动动画
//    self.adView = [[UIImageView alloc] initWithFrame:self.window.bounds];
//    [self.window addSubview: self.adView ];
//    NSString  *name = @"gouhuo.gif";
//    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
//
//    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
//
//    self.adView.image = [UIImage sd_animatedGIFWithData:imageData];
//
//    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    self.adView .layer.anchorPoint = CGPointMake(.5,.5);
//    animation.fillMode=kCAFillModeForwards;
//    animation.removedOnCompletion = NO;
//    [animation setAutoreverses:NO];
//
//    //动画时间
//    animation.duration=3.1;
//    animation.delegate=(id)self;
//
//    [self.adView.layer addAnimation:animation forKey:@"scale"];
    return YES;
}

//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(addRefreshAnimate) userInfo:nil repeats:NO];
//
//}
//
//-(void)addRefreshAnimate{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.adView.alpha = 0;
//    }];
//    //[self.adView  removeFromSuperview];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
