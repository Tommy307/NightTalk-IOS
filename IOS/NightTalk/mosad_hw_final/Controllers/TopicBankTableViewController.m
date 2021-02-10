//
//  TopicBankTableViewController.m
//  NightTalk
//
//  Created by JASON on 2021/2/6.
//  Copyright © 2021 Jason. All rights reserved.
//

#import "TopicBankTableViewController.h"
#import "AppDelegate.h"

@interface TopicBankTableViewController ()

@end

@implementation TopicBankTableViewController

-(instancetype) init {
    self = [super init];
    if (self) {
        _selectedTopics = [[NSMutableArray alloc] initWithCapacity:0];
        _topics = [[NSMutableArray alloc] initWithCapacity:0];
        [_topics addObject:@"你周末一般都喜欢干什么呀？"];
        [_topics addObject:@"你无聊的时候喜欢看书吗？"];
        [_topics addObject:@"如果有一天自己变成了超人你最想干什么呢？"];
        [_topics addObject:@"你喜欢养宠物吗？"];
        [_topics addObject:@"你去电玩城玩过跳舞机吗？"];
        [_topics addObject:@"你喜欢养花花草草吗？"];
        [_topics addObject:@"你都喜欢什么类型的电影和电视呢？这个电视或者电影为什么会给你这么深的印象呢？"];
        [_topics addObject:@"什么样子的人你最不想和他相处呢？"];
        [_topics addObject:@"有没有什么童年发生的事情是让你觉得很难忘的呢？"];
        [_topics addObject:@"容貌和生命你觉得哪个更重要，如果让你用容貌去换长生不老你愿意吗？"];
        [_topics addObject:@"你会不会做饭啊？在平时生活中你都是怎么做的呀？"];
        [_topics addObject:@"如果可以重来一次的话，你喜欢你是男人还是女人呢？"];
        [_topics addObject:@"如果你很丑或者有一天你毁容了你会选择去整容吗？"];
        [_topics addObject:@"如果有一天有了时光机你最想回到哪一天？"];
        [_topics addObject:@"你怎么看待宋仲基和宋慧乔的事件呢？（随便一个新闻热点都可以）"];
        [_topics addObject:@"如果容貌和智慧只能二选其一，那么你会坚定的选择哪一个呢？"];
        [_topics addObject:@"你觉得你们的老板人品怎么样呢？"];
        [_topics addObject:@"你受到打击或者遇到挫折的时候都是怎么鼓励自己的呢？"];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"话题";
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelect)];
    self.navigationItem.rightBarButtonItem = rightItem;
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //初始化多选数组
    _selectIndexs = [[NSMutableArray alloc] initWithCapacity:0];
    
//    //选择话题提示弹窗
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请至少选择一个话题，或在自定义话题区域写入您想要谈论的话题" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSLog(@"点击了确认按钮");
//    }];
//    [alertController addAction:conform];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
    //用于点击时回收键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        tapGr.cancelsTouchesInView = NO;
        [self.view addGestureRecognizer:tapGr];
    //滚动时回收键盘
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //去除滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    //去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source
//组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _topics.count*2;
}

//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row %2 == 0) {
        CGSize size = [self getSize:_topics[indexPath.row/2]];
        return size.height+25;
    } else {
        return 12;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = [NSString stringWithFormat:@"cellid%ld", indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if(indexPath.row % 2 == 0) {
        cell.textLabel.text = _topics[indexPath.row/2];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.numberOfLines = 0;
        cell.contentView.layer.borderColor = [UIColor blueColor].CGColor;
        cell.contentView.layer.borderWidth = 1.5;
        cell.contentView.layer.cornerRadius = 10;
        //设为NO时，边框外的画面依然会被显示出来--这里貌似没有用
        cell.contentView.layer.masksToBounds = YES;
        //被选中时的颜色--用此方法解决
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = 0;
        //cell.accessoryType = UIAccessibilityTraitNone;
        for (NSIndexPath *index in _selectIndexs) {
            if (indexPath == index) {
                //cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.tag = 1;
            }
        }
    } else {  //不允许cell响应点击事件的处理
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

//选中某一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {  //如果为选中状态
//        cell.accessoryType = UITableViewCellAccessoryNone; //切换为未选中
//        cell.contentView.backgroundColor = [UIColor whiteColor];
//        [_selectIndexs removeObject:indexPath]; //数据移除
//    }else { //未选中
//        cell.accessoryType = UITableViewCellAccessoryCheckmark; //切换为选中
//        cell.contentView.backgroundColor = [UIColor greenColor];
//        [_selectIndexs addObject:indexPath]; //添加索引数据到数组
//    }
    
    if (cell.tag == 1) {  //如果为选中状态
        cell.tag = 0; //切换为未选中
        cell.contentView.backgroundColor = [UIColor whiteColor];
        [_selectIndexs removeObject:indexPath]; //数据移除
        [_selectedTopics removeObject:_topics[indexPath.row/2]];
    }else { //未选中状态
        cell.tag = 1; //切换为选中
        cell.contentView.backgroundColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:0.5];
        [_selectIndexs addObject:indexPath]; //添加索引数据到数组
        [_selectedTopics addObject:_topics[indexPath.row/2]];
    }
}

//组头部高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 68;
}

////组头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"请至少选择一个话题，若没有您想选择的话题，请在自定义话题区域写入您想要谈论的，以供我们后续更新";
//}

//返回每组头部view
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

     UIView *headerView = [[UIView alloc] init];

     headerView.backgroundColor = [UIColor systemGroupedBackgroundColor];
     
     _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 9, self.view.frame.size.width-20, 50)];
     _textField.layer.borderWidth = 1;
     _textField.layer.borderColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1].CGColor;
     _textField.layer.cornerRadius = 7;
     _textField.placeholder = @"自定义话题";
     _textField.clearButtonMode = UITextFieldViewModeAlways;
     //文本字段的拼写检查行为。此属性决定了拼写检查在打字过程中是启用还是禁用
     _textField.spellCheckingType = UITextSpellCheckingTypeYes;
     //文本字段的自动纠正行为。此属性确定在输入过程中自动更正是启用还是禁用
     _textField.autocorrectionType = UITextAutocorrectionTypeYes;
     //设置TextField内文字距左边框的距离
     _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
     //设置显示模式为永远显示(默认不显示)
     _textField.leftViewMode = UITextFieldViewModeAlways;
     //设置textfield代理
     _textField.delegate = self;
     [_textField setBackgroundColor:[UIColor whiteColor]];
     
     [headerView addSubview:_textField];
     
//     UILabel *label = [[UILabel alloc]init];
//     label.textColor = [UIColor grayColor];
//     label.font = [UIFont systemFontOfSize:18];
//     label.frame = CGRectMake(10, 0, self.view.frame.size.width-20, 70);
//     label.numberOfLines = 0;
//     label.backgroundColor = [UIColor clearColor];
//     label.text = @"请至少选择一个话题，若没有您想选择的话题，请在自定义话题区域写入您想要谈论的，以供我们后续更新";
//
//     [headerView addSubview:label];

     return headerView;
}

//尾部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 70;
}

//尾部文字
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    UIView *headerView = [[UIView alloc] init];

    headerView.backgroundColor = [UIColor systemGroupedBackgroundColor];
    
     UILabel *label = [[UILabel alloc]init];
     label.textColor = [UIColor grayColor];
     label.font = [UIFont systemFontOfSize:18];
     label.frame = CGRectMake(10, 0, self.view.frame.size.width-20, 70);
     label.numberOfLines = 0;
     label.backgroundColor = [UIColor clearColor];
     label.text = @"请至少选择一个话题，若没有您想选择的话题，请在自定义话题区域写入您想要谈论的，以供我们后续更新。";

     [headerView addSubview:label];

    return headerView;
}

//点击return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //回收键盘,取消第一响应者
     [_textField resignFirstResponder];
    return YES;
}

//点击空白处收回键盘
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [_textField resignFirstResponder];
//    NSLog(@"dd");
//}
-(void) viewTapped:(UITapGestureRecognizer*)tapGr {
    [_textField resignFirstResponder];
}

//计算文本大小以确定UILabel高度
-(CGSize) getSize : (NSString *)text {
    CGSize size = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    
    return size;
}

-(void)finishSelect {
    [_textField resignFirstResponder];
    
    if(_selectedTopics.count == 0 && [_textField.text isEqualToString:@""]) {
        //选择话题提示弹窗
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请至少选择一个话题，或在自定义话题区域写入您想要谈论的话题" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了确认按钮");
        }];
        [alertController addAction:conform];
        
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        NSLog(@"选择的话题：");
        for(int i = 0; i < _selectedTopics.count; i++) {
            NSLog(@"%@", _selectedTopics[i]);
        }
        NSLog(@"自定义话题：");
        NSLog(@"%@",_textField.text);
        
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        myDelegate.topicIsChosed = YES;
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"回到匹配界面");
        }];
    }
}

-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"回到匹配界面");
    }];
    [_selectedTopics removeAllObjects];
    [_selectIndexs removeAllObjects];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
