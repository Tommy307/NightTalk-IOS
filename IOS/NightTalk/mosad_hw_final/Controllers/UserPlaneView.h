//
//  UserPlaneView.h
//  NightTalk
//
//  Created by zl on 2020/12/25.
//  Copyright © 2020 Jason. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MatchViewController.h"
#import "UserInfoEditView.h"
#import "PasswordEditView.h"
#import "AboutView.h"
#import "NotificationViewController.h"

#ifndef UserPlane_h
#define UserPlane_h

@interface UserPlaneView : UIView<UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate,UITableViewDelegate, UITableViewDataSource>{
    
}

@property id_t *userInfo;

@property UIImageView *avatar;
@property NSString *avatarName;

@property UITableView *tableView;
@property NSMutableArray<NSString*> *dataList;

@property UIImageView *back1;
@property UIImageView *back2;

@property Boolean *isLogin;
// yes 为登录界面 no 为注册界面
@property Boolean *isLoginPage;

@property UILabel *loginTitle;
@property UILabel *regitTitle;
@property UILabel *planeTitle;

@property UILabel *input1;
@property UILabel *input2;
@property UILabel *input3;
@property UITextField *textFieldA;
@property UITextField *textFieldB;
@property UITextField *textFieldC;

@property UILabel *login;
@property UILabel *regit;

@property UILabel *go2login;
@property UILabel *go2regit;

@property UILabel *username;
@property UITextField *usernameInput;
@property UILabel *score;

@property UILabel *alert;

@property UINavigationController * nav1;

-(void)press2Login;
-(void)press2Regit;

-(void)reloadData;

@end

#endif /* UserPlane_h */
