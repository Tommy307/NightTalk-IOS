//
//  PasswordEditView.m
//  NightTalk
//
//  Created by itlab on 2021/1/4.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PasswordEditView.h"

@implementation PasswordEditView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.97];
    
    //    CIFilter * blurFilter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:self, nil];
    
    
    //    self.back1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    //    self.back1.image = [UIImage imageNamed:@"background-login.JPG"];
    //    [self addSubview:self.back1];
    
    // 用户名输入 未登录时显示
    self.input1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 310, 70, 45)];
    self.input1.numberOfLines = 1;
    self.input1.textColor = [UIColor blackColor];
    self.input1.text = @"旧密码";
    [self addSubview:self.input1];
    self.textFieldA = [[UITextField alloc]initWithFrame:CGRectMake(95, 310, 250, 45)];
    self.textFieldA.delegate = self;
    self.textFieldA.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldA.placeholder = @"请输入当前账户密码";
    self.textFieldA.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.textFieldA];
    
    // 密码输入
        self.input2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 390, 70, 45)];
        self.input2.numberOfLines = 1;
        self.input2.textColor = [UIColor blackColor];
        self.input2.text = @"新密码";
        [self addSubview:self.input2];
        UITextField *textField2 = [[UITextField alloc]initWithFrame:CGRectMake(95, 390, 250, 45)];
        textField2.delegate = self;
        textField2.borderStyle = UITextBorderStyleRoundedRect;
        //textField2.keyboardType = UIKeyboardTypeASCIICapable;
        textField2.placeholder = @"请输入新的密码";
        textField2.clearButtonMode = UITextFieldViewModeAlways;
        textField2.secureTextEntry = YES;
        [self addSubview:textField2];
        self.textFieldB = textField2;
    
    // 密码输入2
    self.input3 = [[UILabel alloc] initWithFrame:CGRectMake(20, 470, 70, 45)];
    self.input3.numberOfLines = 1;
    self.input3.textColor = [UIColor blackColor];
    self.input3.text = @"确认密码";
    [self addSubview:self.input3];
    UITextField *textField3 = [[UITextField alloc]initWithFrame:CGRectMake(95, 470, 250, 45)];
    textField3.delegate = self;
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    //textField2.keyboardType = UIKeyboardTypeASCIICapable;
    textField3.placeholder = @"请再次输入新的密码";
    textField3.clearButtonMode = UITextFieldViewModeAlways;
    textField3.secureTextEntry = YES;
    [self addSubview:textField3];
    self.textFieldC = textField3;
    
    // 提示
    self.alert = [[UILabel alloc] initWithFrame:CGRectMake(20, 580, self.bounds.size.width, 45)];
    self.alert.numberOfLines = 1;
    self.alert.textColor = [UIColor redColor];
    self.alert.text = @"";
    [self addSubview:self.alert];
    
    // regit
    self.regitTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120)];
    self.regitTitle.text = @"修改密码";
    self.regitTitle.textAlignment = NSTextAlignmentCenter;
    self.regitTitle.font = [UIFont systemFontOfSize:22];
    [self addSubview:self.regitTitle];
    
    // return icon
    UIImageView *returnIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 45, 30, 30)];
    returnIcon.image = [UIImage imageNamed:@"fanhui.png"];
    returnIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapreturn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(return2Plane)];
    [returnIcon addGestureRecognizer:tapreturn];
    [self addSubview:returnIcon];
    
    
    self.regit = [[UILabel alloc] initWithFrame:CGRectMake(0, 630, self.bounds.size.width, 60)];
    self.regit.backgroundColor = [UIColor whiteColor];
    //    self.regit.layer.borderWidth = 1;
    //    self.regit.layer.borderColor = [UIColor grayColor].CGColor;
    self.regit.userInteractionEnabled = YES;
    self.regit.text = @"确 认";
    self.regit.textColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    self.regit.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer * tapRegit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressConfirm)];
    [self.regit addGestureRecognizer:tapRegit];
    [self addSubview:self.regit];
    
//    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    return self;
}

-(void)return2Plane{
    NSLog(@"return to user plane");
    [self removeFromSuperview];
}

-(void)pressConfirm{
    NSLog(@"修改密码");
    if(!self.textFieldA.text.length){
        NSLog(@"old password is empty");
        self.textFieldA.layer.borderWidth = 1;
        [self.textFieldA.layer setBorderColor:[UIColor redColor].CGColor];
        self.alert.text = @"旧密码不能为空";
        return ;
    }
    NSLog(@"%@",self.textFieldA.text);
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(![self.textFieldA.text isEqualToString:myDelegate.password]){
        NSLog(@"old password is wrong");
        self.textFieldA.layer.borderWidth = 1;
        [self.textFieldA.layer setBorderColor:[UIColor redColor].CGColor];
        self.alert.text = @"旧密码错误";
        return ;
    }
    self.textFieldA.layer.borderWidth = 0;
    if(!self.textFieldB.text.length){
        self.textFieldB.layer.borderWidth = 1;
        self.textFieldB.layer.borderColor = [UIColor redColor].CGColor;
        self.alert.text = @"新密码不能为空";
        return ;
    }
    NSLog(@"%@",self.textFieldB.text);
    self.textFieldB.layer.borderWidth = 0;
    if(!self.textFieldC.text.length){
        self.textFieldC.layer.borderWidth = 1;
        self.textFieldC.layer.borderColor = [UIColor redColor].CGColor;
        self.alert.text = @"请再次输入新密码";
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
    NSString *api = [myDelegate.URL stringByAppendingFormat:@"user/%@",myDelegate.userName];
    NSURL *url=[NSURL URLWithString:api];
    //create Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *BOUNDARY = @"0xKhTmLbOuNdArY";
    [request setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PATCH"];
    
    NSMutableData *body = [NSMutableData data];
    //    NSDictionary *dic = @{@"username" : self.textFieldA.text};
    // NSLog(@"%@", dic);
    NSString *param1 = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",BOUNDARY,@"password",self.textFieldB.text,nil];
    [body appendData:[param1 dataUsingEncoding:NSUTF8StringEncoding]];
    //body结束分割线
    NSString *endString = [NSString stringWithFormat:@"--%@--",BOUNDARY];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSData *data_login = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody : body];
    
    NSLog(@"%@",request);
    
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
            
            if (![dict[@"msg"] isEqualToString:@"success"]){
                self.alert.text = dict[@"msg"];
            }else {
                //                myDelegate.password = self.textFieldB.text;
                NSLog(@"密码修改成功");
                self.alert.text = @"";
                
                // 获取用户信息
                myDelegate.password = dict[@"Password"];
                
                [self return2Plane];
                
                [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
            }
        }];
    }];
    [dataTask resume];
    
    [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
}

- (void)uploadImg{
    NSLog(@"here");
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickVC.delegate = self;
    pickVC.allowsEditing = YES;
    
    // 上传图片。显示控制器
    // [self presentViewController:pickVC animated:YES completion:^{}];
    self.maskView = pickVC.view;
}

//点击空白处收回键盘
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textFieldA resignFirstResponder];
    [_textFieldB resignFirstResponder];
    [_textFieldC resignFirstResponder];
    [_usernameInput resignFirstResponder];
}

@end
