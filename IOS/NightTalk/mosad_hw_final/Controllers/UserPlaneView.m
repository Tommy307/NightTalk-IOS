//
//  UserPlaneView.m
//  NightTalk
//
//  Created by zl on 2020/12/25.
//  Copyright © 2020 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserPlaneView.h"

@implementation UserPlaneView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.97];
    
    // 用户名输入 未登录时显示
    self.input1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 70, 45)];
    self.input1.numberOfLines = 1;
    self.input1.textColor = [UIColor blackColor];
    self.input1.text = @"用户名";
    [self addSubview:self.input1];
    self.textFieldA = [[UITextField alloc]initWithFrame:CGRectMake(95, 310, 250, 45)];
    self.textFieldA.delegate = self;
    self.textFieldA.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldA.placeholder = @"请输入用户名";
    self.textFieldA.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.textFieldA];
    
    // 密码输入
    self.input2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 390, 70, 45)];
    self.input2.numberOfLines = 1;
    self.input2.textColor = [UIColor blackColor];
    self.input2.text = @"密  码";
    [self addSubview:self.input2];
    UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(95, 390, 250, 45)];
    textField2.delegate = self;
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    //textField2.keyboardType = UIKeyboardTypeASCIICapable;
    textField2.placeholder = @"请输入密码";
    textField2.clearButtonMode = UITextFieldViewModeAlways;
    textField2.secureTextEntry = YES;
    [self addSubview:textField2];
    self.textFieldB = textField2;
    
    // 密码输入2
    self.input3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 470, 70, 45)];
    self.input3.numberOfLines = 1;
    self.input3.textColor = [UIColor blackColor];
    self.input3.text = @"确认密码";
    self.input3.alpha = 0;
    [self addSubview:self.input3];
    UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectMake(95, 470, 250, 45)];
    textField3.delegate = self;
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    //textField2.keyboardType = UIKeyboardTypeASCIICapable;
    textField3.placeholder = @"请再次输入密码";
    textField3.clearButtonMode = UITextFieldViewModeAlways;
    textField3.secureTextEntry = YES;
    [self addSubview:textField3];
    self.textFieldC = textField3;
    self.textFieldC.alpha = 0;
    
    // 提示
    self.alert = [[UILabel alloc] initWithFrame:CGRectMake(20, 580, self.bounds.size.width, 45)];
    self.alert.numberOfLines = 1;
    self.alert.textColor = [UIColor redColor];
    self.alert.text = @"";
    [self addSubview:self.alert];
    
    
    // login
    self.loginTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120)];
    self.loginTitle.text = @"登录页面";
    self.loginTitle.textAlignment = NSTextAlignmentCenter;
    self.loginTitle.font = [UIFont systemFontOfSize:22];
    [self addSubview:self.loginTitle];
    
    self.login = [[UILabel alloc] initWithFrame:CGRectMake(0, 630, self.bounds.size.width, 60)];
    self.login.backgroundColor = [UIColor whiteColor];
    //    self.login.layer.borderWidth = 1;
    //    self.login.layer.borderColor = [UIColor grayColor].CGColor;
    self.login.userInteractionEnabled = YES;
    self.login.text = @"登 录";
    self.login.textColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    self.login.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer * tapLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressLogin)];
    [self.login addGestureRecognizer:tapLogin];
    [self addSubview:self.login];
    
    // regit
    self.regitTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120)];
    self.regitTitle.text = @"注册页面";
    self.regitTitle.textAlignment = NSTextAlignmentCenter;
    self.regitTitle.font = [UIFont systemFontOfSize:22];
    self.regitTitle.alpha = 0;
    [self addSubview:self.regitTitle];
    
    
    self.regit = [[UILabel alloc] initWithFrame:CGRectMake(0, 630, self.bounds.size.width, 60)];
    self.regit.backgroundColor = [UIColor whiteColor];
    //    self.regit.layer.borderWidth = 1;
    //    self.regit.layer.borderColor = [UIColor grayColor].CGColor;
    self.regit.userInteractionEnabled = YES;
    self.regit.text = @"注 册";
    self.regit.textColor = [UIColor colorWithRed:0.10 green:0.976 blue:0.16 alpha:1];
    self.regit.textAlignment = NSTextAlignmentCenter;
    self.regit.alpha = 0;
    UITapGestureRecognizer * tapRegit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressRegit)];
    [self.regit addGestureRecognizer:tapRegit];
    [self addSubview:self.regit];
    
    // go for login
    self.go2login = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-59, self.bounds.size.width, 60)];
    self.go2login.backgroundColor = [UIColor clearColor];
    self.go2login.userInteractionEnabled = YES;
    self.go2login.text = @"已经注册过了？去登录～";
    self.go2login.alpha = 0;
    self.go2login.textColor = [UIColor colorWithRed:0.10 green:0.976 blue:0.16 alpha:1];
    self.go2login.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer * tap2Login = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(press2Login)];
    [self.go2login addGestureRecognizer:tap2Login];
    [self addSubview:self.go2login];
    
    // go for register
    self.go2regit = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-59, self.bounds.size.width, 60)];
    self.go2regit.backgroundColor = [UIColor clearColor];
    self.go2regit.userInteractionEnabled = YES;
    self.go2regit.text = @"还没有账号？去注册～";
    self.go2regit.textColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    self.go2regit.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer * tap2Register = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(press2Regit)];
    [self.go2regit addGestureRecognizer:tap2Register];
    [self addSubview:self.go2regit];
    
    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipReturn)];
    [swipGes setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizer:swipGes];
    
    // 选择框
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 440, self.bounds.size.width, self.bounds.size.height-150) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.allowsSelection = YES;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.97];
    self.tableView.bounces = NO;
    
    self.dataList = [[NSMutableArray alloc] initWithArray: @[@"通知",@" ",@"修改信息",@"修改密码",@"关于软件",@" ",@"退出登录"]];
    
    self.planeTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120)];
    self.planeTitle.text = @"个人主页";
    self.planeTitle.font = [UIFont systemFontOfSize:22];
    self.planeTitle.textAlignment = NSTextAlignmentCenter;
    self.planeTitle.alpha = 0;
    [self addSubview:self.planeTitle];
    
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-90, 100, 180, 180)];
    self.avatar.layer.cornerRadius = 90;
    self.avatar.layer.masksToBounds = YES;
    // self.avatar.backgroundColor = [UIColor grayColor];
    self.avatar.image = myDelegate.userAvatar;
    self.avatar.layer.borderWidth = 1;
    self.avatar.layer.borderColor = [UIColor grayColor].CGColor;
    self.avatar.alpha = 0;
    [self addSubview: self.avatar];
    
    // username
    self.username = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, self.bounds.size.width, 60)];
    self.username.text = @"用户名： ";
    self.username.alpha = 0;
    [self addSubview:self.username];
    
    // score
    self.score = [[UILabel alloc] initWithFrame:CGRectMake(20, 360, self.bounds.size.width, 60)];
    self.score.text = @"信用分： ";
    self.score.alpha = 0;
    [self addSubview:self.score];
    
    [self addSubview:self.tableView];
    self.tableView.alpha = 0;
    
    return self;
}

// 供外界刷新内部数据
-(void)reloadData{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.avatar.image = myDelegate.userAvatar;
    if(myDelegate.editInfo != nil){
        [(UserInfoEditView *)myDelegate.editInfo reloadData];
    }
}

// 去注册
-(void)press2Regit{
    NSLog(@"2Register...");
    self.go2regit.alpha = 0;
    self.go2login.alpha = 1;
    self.login.alpha = 0;
    self.regit.alpha = 1;
    self.textFieldA.text = @"";
    self.textFieldB.text = @"";
    self.input3.alpha = 1;
    self.textFieldC.alpha = 1;
    self.loginTitle.alpha = 0;
    self.regitTitle.alpha = 1;
    self.textFieldA.layer.borderColor = [UIColor grayColor].CGColor;
    self.textFieldB.layer.borderColor = [UIColor grayColor].CGColor;
    self.textFieldC.layer.borderColor = [UIColor grayColor].CGColor;
    self.alert.text = @"";
    [self layoutSubviews];
}

// 去登陆
-(void)press2Login{
    NSLog(@"2Login...");
    self.go2regit.alpha = 1;
    self.go2login.alpha = 0;
    self.login.alpha = 1;
    self.regit.alpha = 0;
    self.textFieldA.text = @"";
    self.textFieldB.text = @"";
    self.input3.alpha = 0;
    self.textFieldC.alpha = 0;
    self.loginTitle.alpha = 1;
    self.regitTitle.alpha = 0;
    self.textFieldA.layer.borderColor = [UIColor grayColor].CGColor;
    self.textFieldB.layer.borderColor = [UIColor grayColor].CGColor;
    self.alert.text = @"";
    [self layoutSubviews];
}

// 登录
-(void)pressLogin{
    NSLog(@"Login...");
    if(!self.textFieldA.text.length){
        NSLog(@"username is empty");
        self.textFieldA.layer.borderWidth = 1;
        [self.textFieldA.layer setBorderColor:[UIColor redColor].CGColor];
        self.alert.text = @"用户名不能为空";
        return ;
    }
    NSLog(@"%@",self.textFieldA.text);
    self.textFieldA.layer.borderWidth = 0;
    if(!self.textFieldB.text.length){
        self.textFieldB.layer.borderWidth = 1;
        self.textFieldB.layer.borderColor = [UIColor redColor].CGColor;
        self.alert.text = @"密码不能为空";
        return ;
    }
    NSLog(@"%@",self.textFieldB.text);
    self.textFieldB.layer.borderWidth = 0;
    
    self.alert.text = @"";
    
    //创建请求路径
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *api = [myDelegate.URL stringByAppendingString:@"user/login"];
    NSURL *url=[NSURL URLWithString:api];
    //create Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *dic = @{@"username" : self.textFieldA.text,
                          @"password" : self.textFieldB.text};
    NSLog(@"%@", dic);
    
    NSData *data_login = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody : data_login];
    
    //创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    //根据会话对象创建请求任务
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(data == nil){
            self.alert.text = @"服务器出现故障，请稍后重试！";
            return ;
        }
        
        id returnda=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // UI更新代码
            if(returnda == nil){
                self.alert.text = @"服务器出现故障，请稍后重试！";
                return ;
            }
            
            NSDictionary *dict=(NSDictionary *)returnda;
            
            NSLog(@"%@", dict);
            
            NSString *mess = dict[@"msg"];
            if(!mess.length){
                self.alert.text = @"服务器出现故障，请稍后重试！";
                return ;
            }
            
            if (![dict[@"msg"] isEqualToString:@"success"]){
                self.alert.text = dict[@"msg"];
            }else {
                myDelegate.password = self.textFieldB.text;
                myDelegate.isLogin = YES;
                
                self.alert.text = @"";
                
                self.input1.alpha = 0;
                self.input2.alpha = 0;
                self.textFieldA.alpha = 0;
                self.textFieldB.alpha = 0;
                self.go2regit.alpha = 0;
                self.login.alpha = 0;
                self.textFieldA.text = @"";
                self.textFieldB.text = @"";
                
                // 获取用户信息
                myDelegate.userId = (uint)dict[@"ID"];
                myDelegate.userName = dict[@"Name"];
                myDelegate.score = (uint)dict[@"Score"];
                NSString *name = [NSString stringWithFormat:@"用户名： %@",dict[@"Name"]];
                self.username.text = name;
                NSString *score = [NSString stringWithFormat:@"信用分： %@",dict[@"Score"]];  // 传回的是int啊
                self.score.text = score;
                
                self.avatarName = dict[@"Avatar"];
                
                // test
//                self.avatarName = @"touxiang.jpg";
                if(!self.avatarName.length){
                    // use default avatar
                    NSLog(@"用户还没有设置 头像");
                } else{
                    // 获取图片
                    [self getAvatar];
                }
                
                [self enterUserPlane];
                
                [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
            }
        }];
    }];
    [dataTask resume];
    
    [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
}

-(void)getAvatar{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *api = [myDelegate.URL stringByAppendingFormat:@"picture/%@",self.avatarName];
    NSURL *url=[NSURL URLWithString:api];
    //create Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *BOUNDARY = @"0xKhTmLbOuNdArY";
    [request setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"GET"];
    
    //创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    //根据会话对象创建请求任务
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil){
            self.alert.text = @"服务器出现故障，请稍后重试！";
            return ;
        }
        
//        id returnda=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            NSLog(@"%@", data);
            
            UIImage *img = [UIImage imageWithData:data];
            
            if (img == nil){
                NSLog(@"获取头像失败！！！");
            }else {
                NSLog(@"获取头像成功");
                myDelegate.userAvatar = img;
                self.avatar.image = img;
            }
        }];
    }];
    [dataTask resume];
}


// 注册
-(void)pressRegit{
    NSLog(@"Register...");
    if(!self.textFieldA.text.length){
        NSLog(@"username is empty");
        self.textFieldA.layer.borderWidth = 1;
        [self.textFieldA.layer setBorderColor:[UIColor redColor].CGColor];
        self.alert.text = @"用户名不能为空";
        return ;
    }
    NSLog(@"%@",self.textFieldA.text);
    self.textFieldA.layer.borderWidth = 0;
    if(!self.textFieldB.text.length){
        self.textFieldB.layer.borderWidth = 1;
        self.textFieldB.layer.borderColor = [UIColor redColor].CGColor;
        self.alert.text = @"密码不能为空";
        return ;
    }
    NSLog(@"%@",self.textFieldB.text);
    self.textFieldB.layer.borderWidth = 0;
    if(!self.textFieldC.text.length){
        self.textFieldC.layer.borderWidth = 1;
        self.textFieldC.layer.borderColor = [UIColor redColor].CGColor;
        self.alert.text = @"请再次输入密码";
        return ;
    }
    NSLog(@"%@",self.textFieldC.text);
    self.textFieldC.layer.borderWidth = 0;
    if(![self.textFieldB.text isEqualToString:self.textFieldC.text]){
        self.alert.text = @"两次密码输入不一致，请检查输入";
        return ;
    }
    self.alert.text = @"";
    
    //创建请求路径
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *api = [myDelegate.URL stringByAppendingString:@"user/register"];
    NSURL *url=[NSURL URLWithString:api];
    //create Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    
    NSDictionary *dic = @{@"username" : self.textFieldA.text,
                          @"password" : self.textFieldB.text};
    // NSLog(@"%@", dic);
    
    NSData *data_regit = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = data_regit;
    
    NSLog(@"%@",data_regit);
    //创建会话对象
    NSURLSession *session=[NSURLSession sharedSession];
    //根据会话对象创建请求任务
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data == nil){
            self.alert.text = @"服务器出现故障，请稍后重试！";
            return ;
        }
        
        id returnda=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // UI更新代码
            if(returnda == nil){
                self.alert.text = @"服务器出现故障，请稍后重试！";
                return ;
            }
            
            NSDictionary *dict=(NSDictionary *)returnda;
            
            NSLog(@"%@", dict[@"msg"]);
            
            if (![dict[@"msg"] isEqualToString:@"success"]){
                self.alert.text = dict[@"msg"];
            }else {
                self.alert.text = @"";
                
                [self press2Login];
                
                [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
            }
        }];
    }];
    [dataTask resume];
}

// enter user plane
-(void)enterUserPlane{
    NSLog(@"enter plane");
    self.loginTitle.alpha = 0;
    self.regitTitle.alpha = 0;
    
    self.planeTitle.alpha = 1;
    self.avatar.alpha = 1;
    self.username.alpha = 1;
    self.score.alpha = 1;
    self.tableView.alpha = 1;
}

-(void)leaveUserPlane{
    NSLog(@"leave plane");
    
    self.planeTitle.alpha = 0;
    self.avatar.alpha = 0;
    self.username.alpha = 0;
    self.score.alpha = 0;
    self.tableView.alpha = 0;
    
    self.input1.alpha = 1;
    self.input2.alpha = 1;
    self.textFieldA.alpha = 1;
    self.textFieldB.alpha = 1;
    
    [self press2Login];
}

-(void)swipReturn{
    [UIView animateWithDuration:0.1 animations:^{
        [self setFrame:CGRectMake(-(self.bounds.size.width), 0, self.bounds.size.width, self.bounds.size.height)];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // NSLog(@"%ld",self.dataList.count);
    return self.dataList.count; // 增加的1为加载更多
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 1 || indexPath.row == 5){
        return 10;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hhh"];
        // 添加 icon 与 文字
        NSTextAttachment *textAttach = [[NSTextAttachment alloc]init];
        if(indexPath.row == 0){
            cell.imageView.image = [UIImage imageNamed:@"tongzhi.png"];
        } else if(indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"xiugaixinxi.png"];
        } else if(indexPath.row == 3){
            cell.imageView.image = [UIImage imageNamed:@"xiugaimima.png"];
        } else if(indexPath.row == 4){
            cell.imageView.image = [UIImage imageNamed:@"icon29.png"];
        } else if(indexPath.row == 6){
            cell.imageView.image = [UIImage imageNamed:@"tuichudenglu.png"];
        }
        textAttach.bounds = CGRectMake(5, -2, 30, 16);
        // 将图片转为富文本
        NSAttributedString *stringImg = [NSAttributedString attributedStringWithAttachment:textAttach];
        // 与文本添加到一起
        NSMutableAttributedString *stringText = [[NSMutableAttributedString alloc] initWithString:self.dataList[indexPath.row]];
        [stringText insertAttributedString:stringImg atIndex:1];
        // NSLog(@"%@",stringText);
        cell.textLabel.attributedText = stringText;
        cell.textLabel.numberOfLines = 1;               //这个值设置为0可以让UILabel动态的显示需要的行数。
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor whiteColor];
        if(indexPath.row == 1 || indexPath.row == 5){
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.97];
        }
    }
    
    cell.textLabel.text = self.dataList[indexPath.row];
    //    cell.textLabel.alpha = 0;
    //    [UIView animateWithDuration:0.5 animations:^{
    //        cell.textLabel.alpha = 1;
    //    }];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        NSLog(@"查看通知");
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:notificationViewController];
        UIWindow *window =  [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        UINavigationController *nav = (UINavigationController *)window.rootViewController;
        MatchViewController * matchViewController = nav.viewControllers[0];
        NotificationViewController * notificationViewController = [[NotificationViewController alloc] init];
        self.nav1 = [[UINavigationController alloc] initWithRootViewController:notificationViewController];
        self.nav1.modalPresentationStyle = UIModalPresentationCustom;
//        nav1.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [matchViewController presentViewController:_nav1 animated:NO completion:^{
            NSLog(@"前往通知页面");
            self.nav1.view.backgroundColor = [UIColor clearColor];
            self.nav1.view.superview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//            nav1.view.superview.center = CGPointMake(200,374);
            notificationViewController.userPlaneView = self;
            self.alpha = 0;
            AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            myDelegate.navigationController = self.nav1;
            myDelegate.notificationIsOpen = YES;
        }];
    } else if(indexPath.row == 2){
        // 修改信息
        NSLog(@"修改信息");
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        myDelegate.editInfo = [[UserInfoEditView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:myDelegate.editInfo];
    } else if(indexPath.row == 3){
        // 修改密码
        NSLog(@"修改密码");
        UIView *editPass = [[PasswordEditView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:editPass];
    } else if(indexPath.row == 4){
        // 关于软件
        NSLog(@"关于软件");
        UIView *aboutSoft = [[AboutView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:aboutSoft];
    } else if(indexPath.row == 6){
        // 退出登录
        NSLog(@"退出登录");
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        myDelegate.isLogin = false;
        myDelegate.userAvatar = nil;
        [self leaveUserPlane];
    }
}

//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textFieldA resignFirstResponder];
    [_textFieldB resignFirstResponder];
    [_textFieldC resignFirstResponder];
    [_usernameInput resignFirstResponder];
}

@end
