//
//  NotificationViewController.h
//  NightTalk
//
//  Created by JASON on 2021/2/9.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, nonnull) UITableView * tableView;
@property (nonatomic, nonnull) UIView * editingView;
@property (nonnull, nonatomic) NSMutableArray * messageArray;
@property (nonnull, nonatomic) NSMutableArray * chosedMessageArray;

@property (nonnull, nonatomic) UIBarButtonItem * btnEdit;
@property (nonnull, nonatomic) UIBarButtonItem * btnFinish;
@property (nonnull, nonatomic) UIBarButtonItem * btnClean;
@property (nonnull, nonatomic) UIBarButtonItem * btnBack;

//@property (nonnull, nonatomic) NSMutableArray * unreadMessageIndexs;

@property Boolean isEdit;

@property (nonnull, nonatomic) UIButton * choseButton;
@property (nonnull, nonatomic) UIButton * cleanButton;

@property (nonnull, nonatomic) UIView * userPlaneView;

@end

NS_ASSUME_NONNULL_END
