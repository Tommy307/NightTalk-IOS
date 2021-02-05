//
//  PasswordEditView.h
//  NightTalk
//
//  Created by itlab on 2021/1/4.
//  Copyright © 2021 Jason. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#ifndef PasswordEditView_h
#define PasswordEditView_h

@interface PasswordEditView : UIView<UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
}

@property id_t *userInfo;

@property UIImageView *avatar;
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

-(void)press2Login;
-(void)press2Regit;

-(void)return2Plane;

@end

#endif /* PasswordEditView_h */
