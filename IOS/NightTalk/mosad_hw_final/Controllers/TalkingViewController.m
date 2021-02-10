//
//  TalkingViewController.m
//  mosad_hw_final
//
//  Created by Jason on 2020/12/18.
//  Copyright © 2020 Jason. All rights reserved.
//

#import "TalkingViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AppDelegate.h"

@interface TalkingViewController ()

@end

@implementation TalkingViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        haveAudio = NO;
        audioNameArray = [[NSArray alloc] init];
        complaintArray = [[NSMutableArray alloc] initWithCapacity:0];
        recordAnimationArray = [[NSMutableArray alloc] initWithCapacity:0];
        for(int i = 1; i < 10; i++) {
            [recordAnimationArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"record%d.png", i]]];
        }
        self.userArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.voiceArray = [[NSMutableArray alloc] initWithCapacity:0];
//        [self.userArray addObject:@"we"];
//        [self.userArray addObject:@"gh"];
//        [self.userArray addObject:@"yu"];
//        [self.userArray addObject:@"yu"];
//        [self.userArray addObject:@"yu"];
//        [self.userArray addObject:@"yu"];
//        [self.userArray addObject:@"yu"];
//        [self.userArray addObject:@"yu"];
//
//        NSString*filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"m4a"];
//               NSData* data= [NSData dataWithContentsOfFile:filePath];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
//        [self.voiceArray addObject:data];
        
//        NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:0];
//        NSFileManager *manger = [NSFileManager defaultManager];
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//
//        //  获得当前文件的所有子文件subpathsAtPath
//        NSArray *pathlList = [manger subpathsAtPath:path];
//        //  遍历所有这个文件夹下的子文件
//        //NSLog(@"%@",path);
//        for (NSString *audioPath in pathlList) {
//            //    通过对比文件的延展名（扩展名 尾缀） 来区分是不是录音文件
//            if ([audioPath.pathExtension isEqualToString:@"wav"]) {
//                //    把筛选出来的文件放到数组中
//                NSURL * audioURL = [[NSURL alloc] initFileURLWithPath:[NSString stringWithFormat:@"%@/%@",path, audioPath]];
//                NSData *audioData = [[NSData alloc] initWithContentsOfURL:audioURL];
//                [self.voiceArray addObject:audioData];
//                [array addObject:audioPath.stringByDeletingPathExtension];
//            }
//        }
//        [self sort:array];
        
        //    for(int i = 0; i < 10; i++){
        //        //用于工程文件
        //        NSString * str = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%d", i%4+1] ofType:@"m4a"];
        //        //将字符串转化为url
        //        NSURL * urlMusic = [NSURL fileURLWithPath:str];
        //        [self.voiceArray addObject:urlMusic];
        //    }
    }
    
    return self;
}

//直接插入排序
- (void)sort:(NSMutableArray *)arr {
    // 外层循环用于跑多少趟
    for (int i = 1; i < arr.count; i ++) {
        int temp = (int)[arr[i] integerValue];
        NSData * data = self.voiceArray[i];
        // 内层循环用于移动元素位置
        for (int j = i - 1; j >= 0 && temp < [arr[j] integerValue]; j --) {
            arr[j + 1] = arr[j];
            //arr[j] = [NSNumber numberWithInt:temp];
            arr[j] = [NSString stringWithFormat:@"%d", temp];
            self.voiceArray[j+1] = self.voiceArray[j];
            self.voiceArray[j] = data;
        }
    }
    NSLog(@"插入排序结果：%@",arr);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //1.首先获取沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString * CacheImage = [NSString stringWithFormat:@"Image/background.png"];
    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:CacheImage];
    NSData *data = [fileManage contentsAtPath:myDirectory];
    UIImage * backgroundImage = [UIImage imageWithData:data];
    if(backgroundImage != nil) {
        backgroundView.image = backgroundImage;
    } else {
        backgroundView.image = [UIImage imageNamed:@"liaotianbackground.jpg"];
    }
    [self.view addSubview:backgroundView];
    //self.view.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];

    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-80-96) style:UITableViewStylePlain];
    //自动调整子视图的大小
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.backgroundColor = [UIColor clearColor];
    
    //设置代理
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //数据视图的头部视图的设定 UIView类型
    tableView.tableHeaderView = nil;
    //数据视图的尾部视图
    tableView.tableFooterView = nil;
    //去除分割线
    [tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    
//顶部导航栏
    UIView * navigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    navigationBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationBar];
    
    UILabel * exit = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, 50, 40)];
    exit.backgroundColor = [UIColor clearColor];
    exit.text = @"退出";
    exit.textAlignment = NSTextAlignmentCenter;
    [exit setFont:[UIFont systemFontOfSize:18]];
    [exit setTextColor:[UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1.0]];
    [navigationBar addSubview:exit];
    exit.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(exit)];
    [tap setNumberOfTapsRequired:1];
    [exit addGestureRecognizer:tap];
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    title.center = CGPointMake(navigationBar.frame.size.width/2, navigationBar.frame.size.height/2+18);
    title.text = @"夜谈";
    title.textAlignment = NSTextAlignmentCenter;
    [title setFont:[UIFont systemFontOfSize:19]];
    [title setTextColor:[UIColor blackColor]];
    [navigationBar addSubview:title];
    UIButton * picture = [[UIButton alloc] init];
    [picture setImage:[UIImage imageNamed:@"tupian.png"] forState:UIControlStateNormal];
    picture.frame = CGRectMake(navigationBar.frame.size.width-42, 50, 25, 20);
    picture.backgroundColor = [UIColor clearColor];
    [picture addTarget:self action:@selector(selectBackgroundPicture:) forControlEvents:UIControlEventTouchUpInside];
    [navigationBar addSubview:picture];
    navigationBar.layer.shadowOpacity = 0.7f;
    navigationBar.layer.shadowRadius = 2.0f;
    navigationBar.layer.shadowOffset = CGSizeMake(0, 1);
    
//语音栏
    microphoneBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width+60, 100)];
    microphoneBar.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-50);
    microphoneBar.backgroundColor = [UIColor clearColor];
//    UIImage*_maskingImage =[UIImage imageNamed:@"liaotian1.png"];
//    CALayer*_maskingLayer =[CALayer layer];
//    _maskingLayer.frame = microphoneBar.bounds;
//    [_maskingLayer setContents:(id)[_maskingImage CGImage]];
//    [microphoneBar.layer setMask:_maskingLayer];
    UIImage * image = [UIImage imageNamed:@"liaotian1.png"];
    
    [microphoneBar setBackgroundColor:[UIColor colorWithPatternImage:[self scaleToSize:image size:CGSizeMake(self.view.frame.size.width+60, 100)]]];
    microphoneBar.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:microphoneBar];
    microphoneBar.layer.shadowOpacity = 0.8f;
    microphoneBar.layer.shadowRadius = 4.0f;
    microphoneBar.layer.shadowOffset = CGSizeMake(0, 2);
    
    microphone = [[UIButton alloc] init];
    [microphone setImage:[UIImage imageNamed:@"huatong"] forState:UIControlStateNormal];
    microphone.backgroundColor = [UIColor colorWithRed:30.0/255 green:144.0/255 blue:255.0/255 alpha:1.0];
    microphone.frame = CGRectMake(0, 0, 70, 70);
    microphone.center = CGPointMake(microphoneBar.frame.size.width/2, microphoneBar.frame.size.height/2);
    microphone.layer.cornerRadius = 35;
    //microphone.layer.borderWidth = 1;
   // microphone.clipsToBounds = YES;
    microphone.layer.borderColor = [UIColor blackColor].CGColor;
    [microphoneBar addSubview:microphone];
    microphone.layer.shadowColor = [UIColor blackColor].CGColor;
    microphone.layer.shadowOpacity = 0.8f;
    microphone.layer.shadowRadius = 4.0f;
    microphone.layer.shadowOffset = CGSizeMake(0, 0);
    //microphone.userInteractionEnabled = YES;
    [microphone addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [microphone addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [microphone addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit];
    [microphone addTarget:self action:@selector(touchDragEnter:) forControlEvents:UIControlEventTouchDragEnter];
    [microphone addTarget:self action:@selector(touchUpOutside:) forControlEvents:UIControlEventTouchUpOutside];
    
    UILabel * tip = [[UILabel alloc] initWithFrame:CGRectMake(microphoneBar.frame.size.width/2+50, microphoneBar.frame.size.height/2, 100, 20)];
    tip.text = @"←长按录音";
    tip.font = [UIFont systemFontOfSize:15];
    [tip setTextColor:[UIColor lightGrayColor]];
    [microphoneBar addSubview:tip];
    
    recordOrCancel = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 180, 180)];
    recordOrCancel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+100);
    recordOrCancel.layer.cornerRadius = 8.0f;
    recordOrCancel.backgroundColor = [UIColor colorWithRed:50.0/255 green:50.0/255 blue:50.0/255 alpha:0.8];
    recordOrCancel.layer.shadowOpacity = 0.8f;
    recordOrCancel.layer.shadowRadius = 2.5f;
    recordOrCancel.layer.shadowOffset = CGSizeMake(0, 0);
    recordOrCancel.image = [UIImage imageNamed:@"record1.png"];
    [self.view addSubview:recordOrCancel];
    recordOrCancel.alpha = 0.0f;
}

-(void)viewWillAppear:(BOOL)animated {
    getAudioTimer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_group_t downloadGroup0 = dispatch_group_create();
        dispatch_group_enter(downloadGroup0);
        AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
        [manager POST:[NSString stringWithFormat:@"%@room/audios",myDelegate.URL] parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 直接以 key value 的形式向 formData 中追加二进制数据
            [formData appendPartWithFormData:[myDelegate.userName dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"username"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%d", myDelegate.roomID] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"roomid"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //NSLog(@"ttt");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //NSLog(@"拿取音频名字成功");
            NSLog(@"%@", responseObject);
            if([[responseObject objectForKey:@"msg"] isKindOfClass:[NSArray class]]) {
                self->haveAudio = YES;
                self->audioNameArray = [responseObject objectForKey:@"msg"];
            }
            dispatch_group_leave(downloadGroup0);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"拿取音频名字错误");
        }];
        dispatch_group_notify(downloadGroup0, dispatch_get_main_queue(), ^{
            if(self->haveAudio) {
                self->haveAudio = NO;
                __block NSInteger timerCount = 0;
                NSTimer *timer = [NSTimer timerWithTimeInterval:0.25 repeats:YES block:^(NSTimer * _Nonnull timer) {
                    NSString * audioName = self->audioNameArray[timerCount];
                    
                    //创建传话管理者
                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@wav/%@",myDelegate.URL, audioName]]];
                    //下载文件
                    /*
                     第一个参数:请求对象
                     第二个参数:progress 进度回调
                     第三个参数:destination 回调(目标位置)
                     有返回值
                     targetPath:临时文件路径
                     response:响应头信息
                     第四个参数:completionHandler 下载完成后的回调
                     filePath:最终的文件路径
                     */
                    NSURLSessionDownloadTask * download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                        //下载进度
                        //NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                        //保存的文件路径
                        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
                        return [NSURL fileURLWithPath:fullPath];
                    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                        NSLog(@"%@",filePath);
                        self->filePath = filePath;
                        NSData *audioData = [[NSData alloc] initWithContentsOfURL:filePath];
                        [self.voiceArray addObject:audioData];
                        NSRange range = [audioName rangeOfString:@"_"];
                        NSString * username = [audioName substringWithRange:NSMakeRange(0, range.location)];
                        [self.userArray addObject:username];
                        
                        //删除最新下载的音频
                        //创建文件管理器
                        NSFileManager * fileManager = [NSFileManager defaultManager];
                        [fileManager removeItemAtPath:[self->filePath path] error:nil];
                        [self->tableView reloadData];
                        dispatch_async(dispatch_get_main_queue(),^{
                            if (self->tableView.contentSize.height > self->tableView.bounds.size.height) {
                                [self->tableView setContentOffset:CGPointMake(0, self->tableView.contentSize.height - self->tableView.bounds.size.height) animated:NO];
                            }
                        });
                    }];
                    //执行Task
                    [download resume];
                    
                    timerCount ++ ;
                    if (timerCount>=self->audioNameArray.count) {
                        [timer invalidate];
                        timer = nil;
                    }
                    
                    NSLog(@"timer block 执行 %ld 次",timerCount);
                }];
                [timer fire];
                [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
                
                
                
                //                for(NSString * audioName in self->audioNameArray) {
                //NSLog(@"api = %@", [NSString stringWithFormat:@"%@wav/%@",myDelegate.URL, audioName]);
                //                    dispatch_group_t downloadGroup = dispatch_group_create();
                //                    dispatch_group_enter(downloadGroup);
                //
                //                    //创建传话管理者
                //                    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                //                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@wav/%@",myDelegate.URL, audioName]]];
                //                    //下载文件
                //                    /*
                //                     第一个参数:请求对象
                //                     第二个参数:progress 进度回调
                //                     第三个参数:destination 回调(目标位置)
                //                     有返回值
                //                     targetPath:临时文件路径
                //                     response:响应头信息
                //                     第四个参数:completionHandler 下载完成后的回调
                //                     filePath:最终的文件路径
                //                     */
                //                    NSURLSessionDownloadTask * download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                //                        //下载进度
                //                        //NSLog(@"%f",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                //                    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                //                        //保存的文件路径
                //                        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
                //                        return [NSURL fileURLWithPath:fullPath];
                //                    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                //                        NSLog(@"%@",filePath);
                //                        self->filePath = filePath;
                //                        NSData *audioData = [[NSData alloc] initWithContentsOfURL:filePath];
                //                        [self.voiceArray addObject:audioData];
                //                        NSRange range = [audioName rangeOfString:@"_"];
                //                        NSString * username = [audioName substringWithRange:NSMakeRange(0, range.location)];
                //                        [self.userArray addObject:username];
                //                        NSLog(@"%@", username);
                //                        //NSLog(@"%@", audioData);
                //                        dispatch_group_leave(downloadGroup);
                //                    }];
                //                    //执行Task
                //                    [download resume];
                //
                //                    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
                //                        //刷新tableview
                //                        NSLog(@"test");
                //                        //删除最新下载的音频
                //                        //创建文件管理器
                //                        NSFileManager * fileManager = [NSFileManager defaultManager];
                //                        [fileManager removeItemAtPath:[self->filePath path] error:nil];
                //                        [self->tableView reloadData];
                //                        dispatch_async(dispatch_get_main_queue(),^{
                //                            if (self->tableView.contentSize.height > self->tableView.bounds.size.height) {
                //                                [self->tableView setContentOffset:CGPointMake(0, self->tableView.contentSize.height - self->tableView.bounds.size.height) animated:NO];
                //                            }
                //                        });
                //                    });
                //                }
            }
            
        });
    }];
}

-(void) exit
{
    [self.navigationController popViewControllerAnimated:YES];
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
        [self->getAudioTimer invalidate];
        self->getAudioTimer = nil;
       // [self->getAudioTimer setFireDate:[NSDate distantPast]];
//        [self dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"back");
//        }];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//默认组数返回1
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.voiceArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * strCell = [NSString stringWithFormat:@"cell%ld", indexPath.section];
    //尝试获取可以复用的单元格
    //如果得不到，返回为nil
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell == nil) {
        //UITableViewCellStyleDefault
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCell];
    }
    cell.backgroundColor = [UIColor clearColor];
    //点击cell没点击阴影效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//头像
    MyUIImageView * image = [[MyUIImageView alloc] init];
    dispatch_group_t downloadGroup = dispatch_group_create();
    dispatch_group_enter(downloadGroup);
    AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //获取AFHTTPSection对象
    AFHTTPSessionManager * session = [AFHTTPSessionManager manager];
    __block NSString * imageName = [[NSString alloc] init];
    //拿取用户头像
    [session GET:[NSString stringWithFormat:@"%@user/%@",myDelegate.URL, self->_userArray[indexPath.section]] parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"下载content中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"获取头像成功");
        //NSLog(@"dic = %@", responseObject);
        imageName = [responseObject objectForKey:@"Avatar"];
        dispatch_group_leave(downloadGroup);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"获取头像失败");
    }];
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        //NSLog(@"%@", self->imageName);
        if(imageName.length == 0) {
            image.image = [UIImage imageNamed:@"defaultImage.png"];
        } else {
            [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@picture/%@", myDelegate.URL, imageName]]];
            //NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@picture/%@", myDelegate.URL, imageName]];
            //image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        }
    });
    
    image.layer.cornerRadius = 22.5;
    image.layer.borderWidth = 1;
    image.layer.borderColor = [UIColor blackColor].CGColor;
    image.clipsToBounds = YES;
    image.contentMode = UIViewContentModeScaleAspectFit;
    [cell.contentView addSubview:image];

//名称
    UILabel * name = [[UILabel alloc] init];
    name.text = self.userArray[indexPath.section];
    CGSize size = [self getSize:name.text];
    [name setTextColor:[UIColor blackColor]];
    name.backgroundColor = [UIColor clearColor];
    [name setFont:[UIFont systemFontOfSize:15]];
    [cell.contentView addSubview:name];
//聊天框
//    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.voiceArray[indexPath.section] error:nil];
    AVAudioPlayer * player = [[AVAudioPlayer alloc] initWithData:self.voiceArray[indexPath.section] error:nil];
    // NSLog(@"%@",player);

    CGFloat width = 60+140*floor(player.duration)/60;
    
    UIView * voice = [[UIView alloc] init];
    voice.layer.cornerRadius = 5;
    //voice.layer.borderWidth = 1;
    voice.layer.borderColor = [UIColor blackColor].CGColor;
    [cell.contentView addSubview:voice];

    voice.layer.shadowColor = [UIColor blackColor].CGColor;
    voice.layer.shadowOpacity = 1.0f;
    voice.layer.shadowRadius = 3.0f;
    voice.layer.shadowOffset = CGSizeMake(0, 0);
    voice.userInteractionEnabled = YES;
    voice.tag = 0;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressPlay:)];
    [voice addGestureRecognizer:tapGesture];
    [tapGesture setNumberOfTapsRequired:1];
    
    UIImageView * sound = [[UIImageView alloc] init];
    sound.image = [UIImage imageNamed:@"voice3.png"];
    sound.backgroundColor = [UIColor clearColor];
    sound.tag = indexPath.section;
    [voice addSubview:sound];
    
    UILabel * voiceTime = [[UILabel alloc] init];
    voiceTime.font = [UIFont systemFontOfSize:15];
    voiceTime.textColor = [UIColor blackColor];
    voiceTime.text = [NSString stringWithFormat:@"%.f\"", ceil(player.duration)];
    [voice addSubview:voiceTime];

    if([self.userArray[indexPath.section] isEqualToString:myDelegate.userName])
    {
        image.frame = CGRectMake(self.view.frame.size.width-10-45, 10, 45, 45);
        image.backgroundColor = [UIColor whiteColor];
        
        name.frame = CGRectMake(self.view.frame.size.width-65-size.width, 5, size.width, 17);
        
        voice.frame = CGRectMake(self.view.frame.size.width-70-width, 30, width, 40);
        voice.backgroundColor = [UIColor colorWithRed:127.0/255 green:255.0/255 blue:0.0/255 alpha:1.0];
        
        sound.frame = CGRectMake(voice.frame.size.width-20-7, 10, 20, 20);
        sound.transform = CGAffineTransformMakeScale(-1, 1);
        
        voiceTime.frame = CGRectMake(voice.frame.size.width-30-30, 10, 30, 20);
        voiceTime.textAlignment = NSTextAlignmentRight;

        CAShapeLayer * layer = [[CAShapeLayer alloc] init];
        UIBezierPath * bezier = [[UIBezierPath alloc] init];
        [bezier moveToPoint:CGPointMake(self.view.frame.size.width-71, 38)];
        [bezier addLineToPoint:CGPointMake(self.view.frame.size.width-58, 42)];
        [bezier addLineToPoint:CGPointMake(self.view.frame.size.width-71, 50)];
        layer.path = bezier.CGPath;
        layer.fillColor = [[UIColor colorWithRed:127.0/255 green:255.0/255 blue:0.0/255 alpha:1.0] CGColor];
        //layer.strokeColor = UIColor.blackColor.CGColor;
        [cell.contentView.layer addSublayer:layer];
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 1.0f;
        layer.shadowRadius = 1.5f;
        layer.shadowOffset = CGSizeMake(2.2, 0);
    }
    else
    {
        image.frame = CGRectMake(10, 10, 45, 45);
        image.backgroundColor = [UIColor whiteColor];
        
        name.frame = CGRectMake(65, 5, size.width, 17);
        
        voice.frame = CGRectMake(70, 30, width, 40);
        voice.backgroundColor = [UIColor colorWithRed:253.0/255 green:253.0/255 blue:253.0/255 alpha:1.0];
        
        sound.frame = CGRectMake(7, 10, 20, 20);
        
        voiceTime.frame = CGRectMake(30, 10, 30, 20);
        
        CAShapeLayer * layer = [[CAShapeLayer alloc] init];
        UIBezierPath * bezier = [[UIBezierPath alloc] init];
        [bezier moveToPoint:CGPointMake(71, 38)];
        [bezier addLineToPoint:CGPointMake(58, 42)];
        [bezier addLineToPoint:CGPointMake(71, 50)];
        layer.path = bezier.CGPath;
        layer.fillColor = [[UIColor colorWithRed:253.0/255 green:253.0/255 blue:253.0/255 alpha:1.0] CGColor];
        //layer.strokeColor = UIColor.blackColor.CGColor;
        [cell.contentView.layer addSublayer:layer];
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOpacity = 1.0f;
        layer.shadowRadius = 1.5f;
        layer.shadowOffset = CGSizeMake(-2.2, 0);
        
        image.tag = indexPath.section;
        image.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addUIMenuItem:)];
        [tap setNumberOfTapsRequired:1];
        [image addGestureRecognizer:tap];
    }
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  80;
}

//选中单元格调用此协议函数
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //NSLog(@"选中单元格 %ld, %ld", indexPath.section, indexPath.row);
}
//取消选中单元格调用此协议函数
-(void) tableView:(UITableView *) tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //NSLog(@"取消选中单元格 %ld, %ld", indexPath.section, indexPath.row);
}

//计算文本大小以确定UILabel高度
-(CGSize) getSize : (NSString *)text {
    CGSize size = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size;
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(void)pressPlay:(UITapGestureRecognizer*)tap {
    UIView * view = (UIView *)tap.view;
    UIImageView * sound = view.subviews[0];
    if(![lastSound isKindOfClass:[NSNull class]] && ![lastSound isEqual:sound]) {
        [lastSound stopAnimating];
        [lastSound performSelector:@selector(setAnimationImages:) withObject:nil];
        lastSound.superview.tag = 0;
    }
    if(view.tag == 0) {
        view.tag = 1;
        //创建音频播放器对象
        //P1：音频播放地址文件
        //_player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.voiceArray[sound.tag] error:nil];
        _player = [[AVAudioPlayer alloc] initWithData:self.voiceArray[sound.tag] error:nil];
        //准备播放，解码工作
        [_player prepareToPlay];
        
        //循环播放次数
        //-1：无限循环
        _player.numberOfLoops = 0;
        //设置音量大小
        _player.volume = 0.5;
        _player.delegate = self;
        //动画组
        NSMutableArray * animationArray = [[NSMutableArray alloc] init];
        if(sound.frame.origin.x == 7) {
            for(int i = 0; i < 4; i++){
                [animationArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"voice%d.png", i]]];
            }
        } else {
            for(int i = 1; i < 5; i++){
                [animationArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"voice%d.png", i]]];
            }
        }
        NSLog(@"播放音频");
        [_player play];
        //设置动画数组
        [sound setAnimationImages:animationArray];
        //设置动画播放次数
        [sound setAnimationRepeatCount:INFINITY];
        //设置动画播放时间
        [sound setAnimationDuration:0.8];
        //开始动画
        [sound startAnimating];
    } else {
        view.tag = 0;
        NSLog(@"停止播放");
        [_player stop];
        [sound stopAnimating];
        [sound performSelector:@selector(setAnimationImages:) withObject:nil];
        //sound.image = [UIImage imageNamed:@"voice3.png"];
    }
    
    lastSound = sound;
    [NSTimer scheduledTimerWithTimeInterval:_player.duration repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self->lastSound stopAnimating];
        self->lastSound.superview.tag = 0;
    }];
}

-(void)touchDown:(UIButton*)btn
{
    NSLog(@"touchDown");
    [UIImageView animateWithDuration:0.2 animations:^{
        self->recordOrCancel.alpha = 1.0f;
        self->recordOrCancel.image = self->recordAnimationArray[0];
    }];
    isOutside = NO;
    //  URL是本地的URL AVAudioRecorder需要一个存储的路径
    name = [NSString stringWithFormat:@"%d.wav" ,(int)[NSDate date].timeIntervalSince1970];
    //NSString *name = [NSString stringWithFormat:@"%ld.wav", self.voiceArray.count];
    
    path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:name];
    NSError *error;
    //  录音机 初始化
    _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL fileURLWithPath:path] settings:@{AVNumberOfChannelsKey:@2,AVSampleRateKey:@44100,AVLinearPCMBitDepthKey:@32,AVEncoderAudioQualityKey:@(AVAudioQualityMax),AVEncoderBitRateKey:@128000} error:&error];
    [_recorder prepareToRecord];
    [_recorder record];
    _recorder.delegate = (id)self;
    /*
     1.AVNumberOfChannelsKey 通道数 通常为双声道 值2
     2.AVSampleRateKey 采样率 单位HZ 通常设置成44100 也就是44.1k
     3.AVLinearPCMBitDepthKey 比特率 8 16 24 32
     4.AVEncoderAudioQualityKey 声音质量
     ① AVAudioQualityMin  = 0, 最小的质量
     ② AVAudioQualityLow  = 0x20, 比较低的质量
     ③ AVAudioQualityMedium = 0x40, 中间的质量
     ④ AVAudioQualityHigh  = 0x60,高的质量
     ⑤ AVAudioQualityMax  = 0x7F 最好的质量
     5.AVEncoderBitRateKey 音频编码的比特率 单位Kbps 传输的速率 一般设置128000 也就是128kbps
     */
    NSLog(@"%@",path);
    //开启测量
    _recorder.meteringEnabled = YES;
    count = 120;;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(levelTimerCallback:) userInfo:nil repeats:YES];
}

//定时方法
- (void)levelTimerCallback:(NSTimer *)timer {
    count--;
    NSLog(@"%d", count);
    if(!isOutside) {
        //跟新测量
        [_recorder updateMeters];
        //获取通道0的平均音量，声音不大的情况下avg是个负数，没有启动MIC是-160
        //CGFloat avg = [_recorder averagePowerForChannel:0];
        //获取通道0的峰值音量，声音不大的情况下avg是个负数，没有启动MIC是-160
        CGFloat max = [_recorder peakPowerForChannel:0];
        
        //NSLog(@"avg:%f---max:%f", avg, max);
        
        CGFloat lowPassResults = pow(10, (0.05*max))/2;
        //NSLog(@"%f", lowPassResults);
        
        
        if(0 <= lowPassResults <= 0.11) {
            self->recordOrCancel.image = self->recordAnimationArray[0];
            NSLog(@"0");
        } else if(0.11 < lowPassResults <= 0.22) {
            self->recordOrCancel.image = self->recordAnimationArray[1];
            NSLog(@"1");
        } else if(0.22 < lowPassResults <= 0.33) {
            self->recordOrCancel.image = self->recordAnimationArray[2];
            NSLog(@"2");
        } else if(0.33 < lowPassResults <= 0.44) {
            self->recordOrCancel.image = self->recordAnimationArray[3];
            NSLog(@"3");
        } else if(0.44 < lowPassResults <= 0.55) {
            self->recordOrCancel.image = self->recordAnimationArray[4];
            NSLog(@"4");
        } else if(0.55 < lowPassResults <= 0.66) {
            self->recordOrCancel.image = self->recordAnimationArray[5];
            NSLog(@"5");
        } else if(0.66 < lowPassResults <= 0.77) {
            self->recordOrCancel.image = self->recordAnimationArray[6];
            NSLog(@"6");
        } else if(0.77 < lowPassResults <= 0.88) {
            self->recordOrCancel.image = self->recordAnimationArray[7];
            NSLog(@"7");
        } else {
            self->recordOrCancel.image = self->recordAnimationArray[8];
            NSLog(@"8");
        }
        
        if(count <= 20 && count % 2 == 0) {
            UILabel * countDown = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
            countDown.center = CGPointMake(recordOrCancel.frame.size.width/2, recordOrCancel.frame.size.height-50);
            countDown.font = [UIFont systemFontOfSize:18];
            [countDown setTextColor:[UIColor whiteColor]];
            countDown.textAlignment = NSTextAlignmentCenter;
            countDown.text = [NSString stringWithFormat:@"倒计时%d",count/2];
            for(UILabel * label in [recordOrCancel subviews]) {
                [label removeFromSuperview];
            }
            [recordOrCancel addSubview:countDown];
        }
    }
    if(count <= 0) {
        [timer invalidate];
        timer = nil;
        [_recorder stop];
        for(UILabel * label in [recordOrCancel subviews]) {
            [label removeFromSuperview];
        }
        [UIImageView animateWithDuration:0.3 animations:^{
            self->recordOrCancel.alpha = 0.0f;
        }];
        NSLog(@"录音已满60s，结束");
    }
}

-(void)touchUpInside:(UIButton*)btn
{
    NSLog(@"touchUpInside");
    isOutside = NO;
    [_recorder stop];
    [_timer invalidate];
    if((120-count) <= 2) {
        self->recordOrCancel.image = [UIImage imageNamed:@"error.png"];
        [UIImageView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
            self->recordOrCancel.alpha = 0.0f;
        } completion:^(BOOL finished) {
        }];
        NSLog(@"录音时间太短");
        //删除最新录制的音频
        //创建文件管理器
        NSFileManager * fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:self->path error:nil];
    } else {
        [UIImageView animateWithDuration:0.2 animations:^{
            self->recordOrCancel.alpha = 0.0f;
            self->recordOrCancel.image = self->recordAnimationArray[0];
        }];
        
        dispatch_group_t downloadGroup0 = dispatch_group_create();
        dispatch_group_enter(downloadGroup0);
        AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSData* data= [NSData dataWithContentsOfFile:path];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:[NSString stringWithFormat:@"%@audio", myDelegate.URL] parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            // 直接以 key value 的形式向 formData 中追加二进制数据
            [formData appendPartWithFormData:[myDelegate.userName dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"poster"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%d", myDelegate.roomID] dataUsingEncoding:NSUTF8StringEncoding]
                                        name:@"roomid"];
            [formData appendPartWithFileData:data name:@"data" fileName:self->name mimeType:@"application/octet-stream"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //NSLog(@"ttt");
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"发送录音成功");
            NSLog(@"%@", responseObject);
            dispatch_group_leave(downloadGroup0);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"发送录音失败");
            //NSLog(@"%@", error);
        }];
        
        dispatch_group_notify(downloadGroup0, dispatch_get_main_queue(), ^{
            //删除最新录制的音频
            //创建文件管理器
            NSFileManager * fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:self->path error:nil];
        });
    }
    count = 120;;
}

-(void)touchUpOutside:(UIButton*)btn
{
    NSLog(@"touchUpOutside");
    isOutside = YES;
    [UIImageView animateWithDuration:0.3 animations:^{
        self->recordOrCancel.alpha = 0.0f;
    }];
    [_timer invalidate];
    [_recorder stop];
    
    //删除最新录制的音频
    //创建文件管理器
    NSFileManager * fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
    count = 120;;
}

-(void)touchDragExit:(UIButton*)btn
{
    NSLog(@"touchDragExit");
    isOutside = YES;
    //暂停计时
    //[_timer setFireDate:[NSDate distantFuture]];
    self->recordOrCancel.image = [UIImage imageNamed:@"annul.png"];
    for(UILabel * label in [recordOrCancel subviews]) {
        [label removeFromSuperview];
    }
}

-(void)touchDragEnter:(UIButton*)btn
{
    NSLog(@"touchDragEnter");
    isOutside = NO;
    //[self levelTimerCallback:_timer];
    //继续计时
    //[_timer setFireDate:[NSDate date]];
}

-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"录音结束");
    //  文件操作的类
    NSFileManager *manger = [NSFileManager defaultManager];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //  获得当前文件的所有子文件subpathsAtPath
    NSArray *pathlList = [manger subpathsAtPath:path];
    //  需要只获得录音文件
    NSMutableArray *audioPathList = [NSMutableArray array];
    NSMutableArray * array = [NSMutableArray array];
    //  遍历所有这个文件夹下的子文件
    for (NSString *audioPath in pathlList) {
        //    通过对比文件的延展名（扩展名 尾缀） 来区分是不是录音文件
        if ([audioPath.pathExtension isEqualToString:@"wav" ]) {
            //      把筛选出来的文件放到数组中
            [audioPathList addObject:audioPath];
            [array addObject:audioPath.stringByDeletingPathExtension];
        }
    }
    // 外层循环用于跑多少趟
    for (int i = 1; i < audioPathList.count; i ++) {
        NSString * temp = audioPathList[i];
        int num = (int)[array[i] integerValue];
        // 内层循环用于移动元素位置
        for (int j = i - 1; j >= 0 && num < [array[j] integerValue]; j --) {
            array[j+1] = array[j];
            array[j] = [NSString stringWithFormat:@"%d", num];
            audioPathList[j + 1] = audioPathList[j];
            audioPathList[j] = temp;
        }
    }
    NSLog(@"%@" ,audioPathList);
}

-(void)selectBackgroundPicture:(UIButton*)btn
{
    //创建UIImagePickerController对象
    UIImagePickerController *pickController = [[UIImagePickerController alloc] init];
    /**
     设置pickController读取相册资源类型（默认资源）
     共有三种选择：
     UIImagePickerControllerSourceTypePhotoLibrary,
     UIImagePickerControllerSourceTypeCamera,
     UIImagePickerControllerSourceTypeSavedPhotosAlbum
     */
    [pickController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //设置代理
    pickController.delegate = (id)self;
    //视图跳转
    [self presentViewController:pickController animated:YES completion:^{
        NSLog(@"加载图片成功");
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImagePickerControllerOriginalImage 是框架定义的提取选中的图片资源的 key
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    backgroundView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //1.首先创建在沙盒中创建一个文件夹用于保存图片
    NSFileManager * fileManager = [[NSFileManager alloc] init];
    
    NSString * pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * createPath = [NSString stringWithFormat:@"%@/Image", pathDocuments];
    
    //判断文件夹是否存在，如果不存在则创建
    if(![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"文件路径已存在");
    }
    //2.缓存我所需要的图片
    NSString * path_sandox = NSHomeDirectory();
    //创建路径
    NSString * CachePath = [NSString stringWithFormat:@"/Documents/Image/background.png"];
    //设置一个图片的存储路径
    NSString * imagePath = [path_sandox stringByAppendingString:CachePath];
    //把图片直接保存到指定的路径（同时应把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    NSLog(@"%@", imagePath);
}

//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //取消相册的显示
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) addUIMenuItem:(UITapGestureRecognizer*)tap
{
    NSLog(@"test");
    MyUIImageView * image = (MyUIImageView*)tap.view;
    [image becomeFirstResponder];

    _cellSelectDic = [[NSMutableDictionary alloc] init];
    NSNumber * tag = [NSNumber numberWithInteger:image.tag];
    [_cellSelectDic setObject:tag forKey:@"tag"];
    
    UIMenuItem * complain = [[UIMenuItem alloc] initWithTitle:@"投诉" action:@selector(menuComplainPressed:)];
    UIMenuController * menuController = [UIMenuController sharedMenuController];
    menuController.menuItems = @[complain];
    [menuController setTargetRect:image.frame inView:image.superview];
    [menuController setMenuVisible:YES animated: YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self->getAudioTimer invalidate];
    self->getAudioTimer = nil;

}

-(void)menuComplainPressed:(UIMenuItem*)menuItem
{
    NSLog(@"投诉");
    NSNumber * tag = [_cellSelectDic objectForKey:@"tag"];
    NSInteger tag1 = [tag integerValue];
    if(![complaintArray containsObject:_userArray[tag1]]) {
        [complaintArray addObject:_userArray[tag1]];
        //投诉弹窗
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"投诉" message:@"请客观输入投诉内容" preferredStyle:UIAlertControllerStyleAlert];
        //确认按钮
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"确认投诉");
            
            //将点击投诉对象回溯20条音频数据发送给后台进行审核
            NSMutableArray * nArray = (NSMutableArray *)[[self.userArray reverseObjectEnumerator] allObjects];;
            NSMutableArray * vArray = (NSMutableArray *)[[self.voiceArray reverseObjectEnumerator] allObjects];
            self->_voiceOfcomplaintArray = [[NSMutableArray alloc] initWithCapacity:0];
            if(nArray.count <= 20) {
                for(int i = 0; i < nArray.count; i++) {
                    if([nArray[i] isEqual:self->_userArray[tag1]]) {
                        [self->_voiceOfcomplaintArray addObject:vArray[i]];
                    }
                }
            } else {
                for(int i = 0; i < 20; i++) {
                    if([nArray[i] isEqual:self->_userArray[tag1]]) {
                        [self->_voiceOfcomplaintArray addObject:vArray[i]];
                    }
                }
            }
            
            for(int i = 0; i < self->_voiceOfcomplaintArray.count; i++) {
                NSLog(@"%@", self->_voiceOfcomplaintArray[i]);
            }
            
            
            
//            dispatch_group_t downloadGroup0 = dispatch_group_create();
//            dispatch_group_enter(downloadGroup0);
//            AppDelegate * myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            AFHTTPSessionManager * manage = [AFHTTPSessionManager manager];
//            //设置请求体为JSON
//            manage.requestSerializer = [AFJSONRequestSerializer serializer];
//            //设置响应体为JSON
//            manage.responseSerializer = [AFJSONResponseSerializer serializer];
//            [manage PATCH:[NSString stringWithFormat:@"%@score/%@", myDelegate.URL, self->_userArray[tag1]] parameters:nil headers:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                if([responseObject isKindOfClass:[NSDictionary class]]) {
//                    NSLog(@"%@", responseObject);
//                }
//                dispatch_group_leave(downloadGroup0);
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"投诉失败");
//            }];
//            dispatch_group_notify(downloadGroup0, dispatch_get_main_queue(), ^{});
        }];
        //取消按钮
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消投诉");
        }];
        //添加文本框 通过 alert.textFields.firstObject 获得该文本框
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请填写您的投诉信息";
        }];
         
        //3.将动作按钮 添加到控制器中
        [alert addAction:conform];
        [alert addAction:cancel];
            
        //4.显示弹框
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        //信用分不够的弹窗，持续时间0.5s
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已经投诉过他/她了！" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:nil];
        [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(timerAction1:) userInfo:alertController repeats:NO];
    }
}

-(void)timerAction1:(NSTimer *) timer {
    UIAlertController * alert = (UIAlertController *)[timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
