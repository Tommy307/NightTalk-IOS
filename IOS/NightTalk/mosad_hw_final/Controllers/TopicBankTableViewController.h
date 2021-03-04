//
//  TopicBankTableViewController.h
//  NightTalk
//
//  Created by JASON on 2021/2/6.
//  Copyright © 2021 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopicBankTableViewController : UITableViewController<UITextFieldDelegate>
{
    UIView * _view;
}
//多选选中的行
@property (strong, nonatomic) NSMutableArray * selectIndexs;
@property (nonatomic, retain) UITextField * textField;
@property (nonatomic, retain) NSMutableArray * topics;
//已选好的话题
@property (nonatomic, retain) NSMutableArray * selectedTopics;

@end

NS_ASSUME_NONNULL_END
