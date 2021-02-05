//
//  MatchViewController.m
//  mosad_hw_final
//
//  Created by Jason on 2020/12/17.
//  Copyright © 2020 Jason. All rights reserved.
//

#import "MatchViewController.h"
#import "TalkingViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/CoreAnimation.h>
#import "HYBClockView.h"
#import "HYBAnimationClock.h"
#import "UserPlaneView.h"

@interface MatchViewController ()

@property (nonatomic, strong) HYBClockView *clockView;
@property (nonatomic, strong) HYBAnimationClock *aniClockView;
@end

@implementation MatchViewController

@synthesize fireEmitter;
@synthesize smokeEmitter;

#pragma mark -
#pragma mark View Lifecycle

-(void)viewWillAppear:(BOOL)animated {
    //添加时钟动画
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - 200) / 2;
    //    self.clockView = [[HYBClockView alloc] initWithFrame:CGRectMake(x, 40, 200, 200)
    //                                               imageName:@"clock"];
    //  [self.view addSubview:self.clockView];
    matchTime = 0;
    self.aniClockView = [[HYBAnimationClock alloc] initWithFrame:CGRectMake(x, 110, 200, 200)
                                                       imageName:@"clock"];
    self.aniClockView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressMatch:)];
    [self.aniClockView addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
    [self.view addSubview:self.aniClockView];
    
    //    [self.clockView releaseTimer];
    //  [self.clockView removeFromSuperview];
    //    self.clockView = nil;
    
#pragma mark - 蓝色小球
    progressBar = [[TwoBallRotationProgressBar alloc] initWithFrame:CGRectMake(0, 320, self.view.frame.size.width, 100)];
    [self.view addSubview:progressBar];
    progressBar.backgroundColor = [UIColor clearColor];
    [progressBar setOneBallColor:[UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1] twoBallColor:[UIColor colorWithRed:0.10 green:0.976 blue:0.16 alpha:1]];
    //设置俩小球的半径
    [progressBar setBallRadius:13];
    [progressBar setAnimatorDistance:30];
    //设置动画时间1.5秒
    [progressBar setAnimatorDuration:1.5];
    [progressBar startAnimator];
    progressBar.alpha = 0.0f;
    
    //添加火焰动画
    CGRect viewBounds = self.view.layer.bounds;
    
    // Create the emitter layers
    self.fireEmitter    = [CAEmitterLayer layer];
    self.smokeEmitter    = [CAEmitterLayer layer];
    
    // Place layers just above the tab bar
    self.fireEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0+5, viewBounds.size.height - 140);
    self.fireEmitter.emitterSize    = CGSizeMake(viewBounds.size.width/2.0, 0);
    self.fireEmitter.emitterMode    = kCAEmitterLayerOutline;
    self.fireEmitter.emitterShape    = kCAEmitterLayerLine;
    // with additive rendering the dense cell distribution will create "hot" areas
    self.fireEmitter.renderMode        = kCAEmitterLayerAdditive;
    
    self.smokeEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0+5, viewBounds.size.height - 140);
    self.smokeEmitter.emitterMode    = kCAEmitterLayerPoints;
    
    // Create the fire emitter cell
    CAEmitterCell* fire = [CAEmitterCell emitterCell];
    [fire setName:@"fire"];
    
    fire.birthRate            = 100;
    fire.emissionLongitude  = M_PI;
    fire.velocity            = -80;
    fire.velocityRange        = 30;
    fire.emissionRange        = 1.1;
    fire.yAcceleration        = -200;
    fire.scaleSpeed            = 0.3;
    fire.lifetime            = 50;
    fire.lifetimeRange        = (50.0 * 0.35);
    
    fire.color = [[UIColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:0.1] CGColor];
    fire.contents = (id) [[UIImage imageNamed:@"DazFire"] CGImage];
    
    
    // Create the smoke emitter cell
    CAEmitterCell* smoke = [CAEmitterCell emitterCell];
    [smoke setName:@"smoke"];
    
    smoke.birthRate            = 10;
    smoke.emissionLongitude = -M_PI / 2;
    smoke.lifetime            = 10;
    smoke.velocity            = -40;
    smoke.velocityRange        = 20;
    smoke.emissionRange        = M_PI / 4;
    smoke.spin                = 1;
    smoke.spinRange            = 6;
    smoke.yAcceleration        = -160;
    smoke.contents            = (id) [[UIImage imageNamed:@"DazSmoke"] CGImage];
    smoke.scale                = 0.1;
    smoke.alphaSpeed        = -0.12;
    smoke.scaleSpeed        = 0.7;
    
    // Add the smoke emitter cell to the smoke emitter layer
    self.smokeEmitter.emitterCells    = [NSArray arrayWithObject:smoke];
    self.fireEmitter.emitterCells    = [NSArray arrayWithObject:fire];
    [self.view.layer addSublayer:self.smokeEmitter];
    [self.view.layer addSublayer:self.fireEmitter];
    
    [self setFireAmount:0.0];
    
    //添加点击提示
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tip.png"]];
    imageView.frame = CGRectMake(190, 230, 210, 110);
    imageView.alpha = 0.0f;
    [self.view addSubview:imageView];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addDelayAnimate1) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(addDelayAnimate2) userInfo:nil repeats:NO];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.center = CGPointMake(self.view.bounds.size.width/2+65, 433);
    label.text = @"匹配中";
    /*
     UIFontDescriptorFamilyAttribute：设置字体家族名
     UIFontDescriptorNameAttribute  ：设置字体的字体名
     UIFontDescriptorSizeAttribute  ：设置字体尺寸
     UIFontDescriptorMatrixAttribute：设置字体形变
     */
    UIFontDescriptor *attributeFontDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:
                                                 @{UIFontDescriptorFamilyAttribute: @"Marion",
                                                   UIFontDescriptorNameAttribute:@"Marion-Bold",
                                                   UIFontDescriptorSizeAttribute: @22.0,
                                                   UIFontDescriptorMatrixAttribute:[NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(M_1_PI*0.0)
                                                                                    ]}];
    label.font = [UIFont fontWithDescriptor:attributeFontDescriptor size:0.0];
    [label setTextColor:[UIColor blackColor]];
    //label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.0f;
    [self.view addSubview:label];
    
    cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    cancel.center = CGPointMake(self.view.bounds.size.width/2, 500);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1] forState:(UIControlState)UIControlStateNormal];
    cancel.layer.borderColor = [UIColor grayColor].CGColor;
    cancel.layer.borderWidth = 1;
    cancel.layer.cornerRadius = 5;
    cancel.backgroundColor = [UIColor colorWithRed:220.0/255 green:220.0/255 blue:220.0/255 alpha:0.7];
    cancel.alpha = 0.0f;
    [self.view addSubview:cancel];
    [cancel addTarget:self action:@selector(pressCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [(UserPlaneView *)myDelegate.userPlane reloadData];
    [self.view addSubview:myDelegate.userPlane];
    
//    self.userPlane.userAva
    [self.view layoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *img_m = [UIImage imageNamed:@"pipei.png"];
    UIImage *img_a;
    CGFloat width = self.view.frame.size.width+50;
    CGFloat height = self.view.frame.size.height+28.1;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    
    [img_m drawInRect:CGRectMake(-20, 0, width, height)];
    img_a = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [view setBackgroundColor:[UIColor colorWithPatternImage:img_a]];
    //view.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:view];
    
    // 登录 icon
    UIImageView *dengluImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 35, 35, 35)];
    dengluImageView.image = [UIImage imageNamed:@"denglu.png"];
    dengluImageView.layer.cornerRadius = 15;
    dengluImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapDenglu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressDenglu)];
    [dengluImageView addGestureRecognizer:tapDenglu];
    [self.view addSubview:dengluImageView];
    
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    myDelegate.userPlane = [[UserPlaneView alloc] initWithFrame:CGRectMake(-(self.view.frame.size.width-40), 0, self.view.frame.size.width-40, self.view.frame.size.height)];
//    myDelegate.userPlane = [[UserPlaneView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, self.view.frame.size.height)];
    [self.view addSubview:myDelegate.userPlane];
    
    
    // 右滑拉出控制菜单
    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(pressDenglu)];
    [swipGes setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipGes];
}

-(void)pressDenglu{
//    NSLog(@"here");
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [UIView animateWithDuration:0.3 animations:^{
        [myDelegate.userPlane setFrame:CGRectMake(0, 0, self.view.frame.size.width-40, self.view.frame.size.height)];
    }];
}

-(void)addDelayAnimate1
{
    //开始动画函数，准备动画的开始工作
    [UIView beginAnimations:nil context:nil];
    //设置动画时间函数
    [UIView setAnimationDuration:1];
    //设置动画开始的延时时间长度
    //进行延时动画的处理
    //参数单位：秒
    [UIView setAnimationDelay:0.5];
    //设置动画的代理对象
    [UIView setAnimationDelegate:self];
    //设置动画的运动轨迹的方向
    //默认UIViewAnimationCurveEaseInOut
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //设置动画结束调用的函数
    //[UIView setAnimationDidStopSelector:@selector(stopAmim)];
    
    imageView.alpha = 1.0f;
    //提交运行动画
    [UIView commitAnimations];
}

-(void)addDelayAnimate2
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
    [UIView setAnimationDelay:1.7];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    imageView.alpha = 0.0f;
    [UIView commitAnimations];
}

-(void)pressMatch:(UIGestureRecognizer *)tapGesture
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(myDelegate.isLogin){
        uint score = myDelegate.score;
        if(score > 10) {
            self.aniClockView.userInteractionEnabled = NO;
            NSLog(@"匹配");
            [self setFireAmount:0.55];
            [self.aniClockView addSecondAnimationWithAngle:0.0];
            [self.aniClockView addMinuteAnimationWithWithAngle:0.0];
            [self.aniClockView addHourAnimationWithAngle:0.0];
            
            [UIView animateWithDuration:0.5 animations:^{
                self->label.alpha = 1.0f;
                self->progressBar.alpha = 1.0f;
                self->cancel.alpha = 1.0f;
            }];
            
            dispatch_group_t downloadGroup0 = dispatch_group_create();
            dispatch_group_enter(downloadGroup0);
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager POST:[NSString stringWithFormat:@"%@room/join", myDelegate.URL] parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                // 直接以 key value 的形式向 formData 中追加二进制数据
                [formData appendPartWithFormData:[myDelegate.userName dataUsingEncoding:NSUTF8StringEncoding]
                                            name:@"username"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                //NSLog(@"ttt");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"success");
                NSLog(@"%@", responseObject);
                NSString * roomid = [responseObject objectForKey:@"roomid"];
                myDelegate.roomID = (uint)[roomid intValue];
                NSLog(@"roomid = %d", myDelegate.roomID);
                dispatch_group_leave(downloadGroup0);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"fail");
                NSLog(@"%@", error);
            }];
            dispatch_group_notify(downloadGroup0, dispatch_get_main_queue(), ^{
                self->matchTime = 0;
                self->timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(matchingAnimation) userInfo:nil repeats:YES];
            });
        } else {
            //信用分不够的弹窗，持续时间0.5s
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的信用分过低，无法匹配" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alertController animated:YES completion:nil];
            [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(timerAction1:) userInfo:alertController repeats:NO];
        }
    } else {
        //未登录的弹窗，持续时间0.5s
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"尚未登录！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(timerAction1:) userInfo:alertController repeats:NO];
    }
    
}

-(void)matchingAnimation
{
    matchTime++;
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if([label.text isEqualToString:@"匹配中"]){
        label.text = @"匹配中。";
    }
    else if([label.text isEqualToString:@"匹配中。"]){
        label.text = @"匹配中。。";
    }
    else if([label.text isEqualToString:@"匹配中。。"]){
        label.text = @"匹配中。。。";
    }
    else if([label.text isEqualToString:@"匹配中。。。"]){
        label.text = @"匹配中";
    }
    
    dispatch_group_t downloadGroup = dispatch_group_create();
    dispatch_group_enter(downloadGroup);
    //获取AFHTTPSection对象
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    //判断房间是否满员
    [session GET:[NSString stringWithFormat:@"%@room/check/%d",myDelegate.URL, myDelegate.roomID] parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载content中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //NSLog(@"下载content成功");
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            // NSLog(@"dic = %@", responseObject);
            self->message = [responseObject objectForKey:@"msg"];
            dispatch_group_leave(downloadGroup);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"失败");
    }];
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        if([self->message isEqualToString:@"full"]) {
            TalkingViewController * talkingViewController = [[TalkingViewController alloc] init];
            [self presentViewController:talkingViewController animated:YES completion:^{
                NSLog(@"跳转成功");
            }];
            [self->timer invalidate];
            self->timer = nil;
        }
    });
    
    if(self->matchTime > 240) {
        //匹配失败弹窗，持续时间0.5s
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"匹配超时，匹配失败！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction:) userInfo:alertController repeats:NO];
        [self LogoutTheRoom];
    }
    
//    TalkingViewController * talkingViewController = [[TalkingViewController alloc] init];
//    [self presentViewController:talkingViewController animated:YES completion:^{
//        NSLog(@"跳转成功");
//    }];
//    [self->timer invalidate];
//    self->timer = nil;

}

-(void)viewWillDisappear:(BOOL)animated
//- (void) viewWillUnload
{
    NSLog(@"disappear");
    [super viewWillDisappear:YES];
    [self.fireEmitter removeFromSuperlayer];
    fireEmitter = nil;
    [self.smokeEmitter removeFromSuperlayer];
    smokeEmitter = nil;
    [self.aniClockView removeFromSuperview];
    self.aniClockView = nil;
    [progressBar removeFromSuperview];
    progressBar = nil;
    [label removeFromSuperview];
    label = nil;
    [cancel removeFromSuperview];
    cancel = nil;
}

#pragma mark -
#pragma mark Interaction

- (void) setFireAmount:(float)zeroToOne
{
    // Update the fire properties
    [self.fireEmitter setValue:[NSNumber numberWithInt:(zeroToOne * 500)]
                    forKeyPath:@"emitterCells.fire.birthRate"];
    [self.fireEmitter setValue:[NSNumber numberWithFloat:zeroToOne]
                    forKeyPath:@"emitterCells.fire.lifetime"];
    [self.fireEmitter setValue:[NSNumber numberWithFloat:(zeroToOne * 0.35)]
                    forKeyPath:@"emitterCells.fire.lifetimeRange"];
    self.fireEmitter.emitterSize = CGSizeMake(50 * zeroToOne, 0);

    [self.smokeEmitter setValue:[NSNumber numberWithInt:zeroToOne * 4]
                     forKeyPath:@"emitterCells.smoke.lifetime"];
    [self.smokeEmitter setValue:(id)[[UIColor colorWithRed:1 green:1 blue:1 alpha:zeroToOne * 0.2] CGColor]
                     forKeyPath:@"emitterCells.smoke.color"];
}

-(void)pressCancel:(UIButton *)btn
{
    NSLog(@"取消匹配");
    [self LogoutTheRoom];
}

-(void)timerAction:(NSTimer *) timer {
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}
                          
-(void)timerAction1:(NSTimer *) timer {
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}

-(void)LogoutTheRoom {
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    dispatch_group_t downloadGroup0 = dispatch_group_create();
    dispatch_group_enter(downloadGroup0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@room/cancel", myDelegate.URL] parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 直接以 key value 的形式向 formData 中追加二进制数据
        [formData appendPartWithFormData:[myDelegate.userName dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"username"];
        [formData appendPartWithFormData:[[NSString stringWithFormat:@"%d", myDelegate.roomID] dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"roomid"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //NSLog(@"ttt");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"退出房间");
        NSLog(@"%@", responseObject);
        dispatch_group_leave(downloadGroup0);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"退出房间失败");
        //NSLog(@"%@", error);
    }];
    dispatch_group_notify(downloadGroup0, dispatch_get_main_queue(), ^{
        [self->timer invalidate];
        self->timer = nil;
        [self.fireEmitter removeFromSuperlayer];
        self->fireEmitter = nil;
        [self.smokeEmitter removeFromSuperlayer];
        self->smokeEmitter = nil;
        [self.aniClockView removeFromSuperview];
        self.aniClockView = nil;
        [self->progressBar removeFromSuperview];
        self->progressBar = nil;
        [self->label removeFromSuperview];
        self->label = nil;
        [self->cancel removeFromSuperview];
        self->cancel = nil;
        [self viewWillAppear:YES];
    });
}

// 上传头像
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    NSLog(@"finish pick image");
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [self.view layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
    /* 此处参数 info 是一个字典，下面是字典中的键值 （从相机获取的图片和相册获取的图片时，两者的info值不尽相同）
     * UIImagePickerControllerMediaType; // 媒体类型
     * UIImagePickerControllerOriginalImage;  // 原始图片
     * UIImagePickerControllerEditedImage;    // 裁剪后图片
     * UIImagePickerControllerCropRect;       // 图片裁剪区域（CGRect）
     * UIImagePickerControllerMediaURL;       // 媒体的URL
     * UIImagePickerControllerReferenceURL    // 原件的URL
     * UIImagePickerControllerMediaMetadata    // 当数据来源是相机时，此值才有效
     */
    
    // 从info中将图片取出，并加载到imageView当中
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    myDelegate.userAvatar = image;
}

@end
