//
//  UserInfoEditView.m
//  
//
//  Created by itlab on 2021/1/3.
//

#import <Foundation/Foundation.h>
#import "UserInfoEditView.h"

@implementation UserInfoEditView

- (instancetype)initWithFrame:(CGRect)frame{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.97];
    
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-80, 130, 160, 160)];
    self.avatar.layer.cornerRadius = 80;
    self.avatar.layer.masksToBounds = YES;
    // self.avatar.backgroundColor = [UIColor grayColor];
    self.avatar.image = myDelegate.userAvatar;
    self.avatar.layer.borderWidth = 1;
    self.avatar.layer.borderColor = [UIColor grayColor].CGColor;
    [self addSubview: self.avatar];
    
    // 用户名输入 未登录时显示
    self.input1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 350, 70, 45)];
    self.input1.numberOfLines = 1;
    self.input1.textColor = [UIColor blackColor];
    self.input1.text = @"用户名";
    [self addSubview:self.input1];
    self.textFieldA = [[UITextField alloc]initWithFrame:CGRectMake(95, 350, 250, 45)];
    self.textFieldA.delegate = self;
    self.textFieldA.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldA.placeholder = @"请输入新的用户名";
    self.textFieldA.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.textFieldA];
    
    // 提示
    self.alert = [[UILabel alloc] initWithFrame:CGRectMake(20, 500, self.bounds.size.width, 45)];
    self.alert.numberOfLines = 1;
    self.alert.textColor = [UIColor redColor];
    self.alert.text = @"";
    [self addSubview:self.alert];
    
    // regit
    self.regitTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 120)];
    self.regitTitle.text = @"修改信息";
    self.regitTitle.textAlignment = NSTextAlignmentCenter;
    self.regitTitle.font = [UIFont systemFontOfSize:22];
    [self addSubview:self.regitTitle];
    
    UIImageView *returnIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, 45, 30, 30)];
    returnIcon.image = [UIImage imageNamed:@"fanhui.png"];
    returnIcon.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapreturn = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(return2Plane)];
    [returnIcon addGestureRecognizer:tapreturn];
    [self addSubview:returnIcon];
    
    // 上传图片
    self.upload = [[UILabel alloc] initWithFrame:CGRectMake(0, 550, self.bounds.size.width, 60)];
    self.upload.backgroundColor = [UIColor whiteColor];
    self.upload.userInteractionEnabled = YES;
    self.upload.text = @"上传图片";
    self.upload.textColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    self.upload.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer * tapupload = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadImg)];
    [self.upload addGestureRecognizer:tapupload];
    [self addSubview:self.upload];
    
    // 修改保存
    self.regit = [[UILabel alloc] initWithFrame:CGRectMake(0, 630, self.bounds.size.width, 60)];
    self.regit.backgroundColor = [UIColor whiteColor];
    self.regit.userInteractionEnabled = YES;
    self.regit.text = @"保 存";
    self.regit.textColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    self.regit.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer * tapRegit = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressConfirm)];
    [self.regit addGestureRecognizer:tapRegit];
    [self addSubview:self.regit];
    
    self.textFieldA.text = myDelegate.userName;
    
    return self;
}

-(void)return2Plane{
    NSLog(@"return to user plane");
//    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [myDelegate.editInfo removeFromSuperview]
    self.alpha = 0;
}

-(void)pressConfirm{
    NSLog(@"保存信息");
    if(!self.textFieldA.text.length){
        NSLog(@"username is empty");
        self.textFieldA.layer.borderWidth = 1;
        [self.textFieldA.layer setBorderColor:[UIColor redColor].CGColor];
        self.alert.text = @"请输入用户名";
        return ;
    }
    NSLog(@"%@",self.textFieldA.text);
    self.textFieldA.layer.borderWidth = 0;
    
    self.alert.text = @"";
    
    //创建请求路径
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *api = [myDelegate.URL stringByAppendingFormat:@"user/%@",myDelegate.userName];
    NSURL *url=[NSURL URLWithString:api];
    //create Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *BOUNDARY = @"0xKhTmLbOuNdArY";
    [request setValue:[@"multipart/form-data; boundary=" stringByAppendingString:BOUNDARY] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"PATCH"];
    
    NSMutableData *body = [NSMutableData data];
    
    // param1
    NSString *param1 = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n",BOUNDARY,@"username",self.textFieldA.text,nil];
    [body appendData:[param1 dataUsingEncoding:NSUTF8StringEncoding]];
    
    // file1 avatar   image-username.png
    NSData *data1 = UIImageJPEGRepresentation(self.avatar.image, 1.0);
    NSString *file1 = [NSString stringWithFormat:@"--%@\r\nContent-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\nContent-Type: application/octet-stream\r\n\r\n",BOUNDARY,@"avatar",[@"image-" stringByAppendingFormat:@"%@.png",self.textFieldA.text],nil];
    [body appendData:[file1 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data1];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //body结束分割线
    NSString *endString = [NSString stringWithFormat:@"--%@--",BOUNDARY];
    [body appendData:[endString dataUsingEncoding:NSUTF8StringEncoding]];
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
            } else {
//                myDelegate.password = self.textFieldB.text;
                NSLog(@"修改成功");
                self.alert.text = @"";
                
                // 获取用户信息
                myDelegate.userName = dict[@"Name"];
                NSString *name = [NSString stringWithFormat:@"用户名： %@",dict[@"Name"]];
                self.username.text = name;
                
                [self return2Plane];
                
                [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
            }
        }];
    }];
    [dataTask resume];
    
    [self layoutSubviews];         // 刷新一下页面，不然要半天z才自然刷新
}

-(void)reloadData{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.avatar.image = myDelegate.userAvatar;
}

- (void)uploadImg{
    NSLog(@"上传图片");
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
    pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickVC.delegate = myDelegate.matchViewController;
    pickVC.allowsEditing = YES;
    
    // 上传图片。显示控制器
    [myDelegate.matchViewController presentViewController:pickVC animated:YES completion:^{}];
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
