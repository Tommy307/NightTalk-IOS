//
//  UserInfoEditView.h
//  NightTalk
//
//  Created by itlab on 2021/1/3.
//  Copyright © 2021 Jason. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#ifndef UserInfoEditView_h
#define UserInfoEditView_h

@interface UserInfoEditView : UIView<UITextFieldDelegate, UITextViewDelegate,UINavigationControllerDelegate>{
    
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

@property UILabel *upload;
@property UILabel *regit;

@property UILabel *go2login;
@property UILabel *go2regit;

@property UILabel *username;
@property UITextField *usernameInput;
@property UILabel *score;

@property UILabel *alert;

-(void)return2Plane;

-(void)reloadData;

@end

#endif /* UserInfoEditView_h */
