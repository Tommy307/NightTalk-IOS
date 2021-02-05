//
//  AboutView.h
//  NightTalk
//
//  Created by itlab on 2021/1/4.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#ifndef AboutView_h
#define AboutView_h

@interface AboutView : UIView{
    
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

@property UILabel *appname;
@property UILabel *appver;

@property UILabel *copyright;
@property UILabel *copyright2;

@property UILabel *func;

-(void)return2Plane;

@end

#endif /* AboutView_h */
