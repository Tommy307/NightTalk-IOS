//
//  ViewController.m
//  Test
//
//  Created by JASON on 2021/2/7.
//

#import "NotificationViewController.h"
#import "AppDelegate.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"通知";
    
    [self addTableView];
    [self addEditingView];
    [self initData];
    [self createBtn];
    
    UISwipeGestureRecognizer *swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipReturn)];
    [swipGes setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.navigationController.view addGestureRecognizer:swipGes];
}

-(void)swipReturn{
    [UIView animateWithDuration:0.1 animations:^{
        [self.navigationController.view setFrame:CGRectMake(-(self.view.frame.size.width), 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            //self.userPlaneView.alpha = 1;
        }];
    }];
}

#pragma mark -- add tableview
-(void) addTableView {
    if (@available(iOS 13.0, *)) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleInsetGrouped];
    } else {
        // Fallback on earlier versions
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    
    //隐藏滚动条
    _tableView.showsVerticalScrollIndicator = NO;
    
    //自动调整子视图大小
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (@available(iOS 13.0, *)) {
        _tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    }
    
    //数据视图的头部视图设定--UIView类型
    _tableView.tableHeaderView = nil;
    //数据视图的尾部视图
    _tableView.tableFooterView = nil;
    
    [self.view addSubview:_tableView];
}

#pragma mark -- add editingView
-(void) addEditingView {
//    _tableView.frame = CGRectMake(0, 0, _tableView.frame.size.width, _tableView.frame.size.height-50);
    _editingView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    _editingView.backgroundColor = [UIColor clearColor];
    
    _choseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _choseButton.frame = CGRectMake(0, 0, _editingView.frame.size.width/2-10, _editingView.frame.size.height);
    [_choseButton setTitle:@"全选" forState:UIControlStateNormal];
    _choseButton.backgroundColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    _choseButton.tintColor = [UIColor whiteColor];
    _choseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    _choseButton.tag = 0;
    [_choseButton addTarget:self action:@selector(pressChoseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    _cleanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _cleanButton.frame = CGRectMake(_editingView.frame.size.width/2-10, 0, _editingView.frame.size.width/2, _editingView.frame.size.height);
    [_cleanButton setTitle:@"删除" forState:UIControlStateNormal];
    _cleanButton.backgroundColor = [UIColor redColor];
    _cleanButton.tintColor = [UIColor whiteColor];
    _cleanButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [_cleanButton addTarget:self action:@selector(pressCleanButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_editingView addSubview:_choseButton];
    [_editingView addSubview:_cleanButton];
    
    [self.view addSubview:_editingView];
}

#pragma mark -- Data
//初始化数据源
-(void) initData {

    _chosedMessageArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    _messageArray = [[NSMutableArray alloc] initWithCapacity:0];
    for(int i = 0; i < 20; i++) {
        NSString * str = [NSString stringWithFormat:@"A %d", i];
        NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:2];
        NSNumber * number = [NSNumber numberWithBool:NO];
        [array addObject:str];
        [array addObject:number];
        [_messageArray addObject:array];
    }
}

#pragma mark -- Btn
-(void) createBtn {
    _isEdit = NO;
    
    _btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pressEdit)];
    if(!_messageArray.count) {
        _btnEdit.enabled = NO;
    }
    
    _btnFinish = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressFinish)];
    
    _btnClean = [[UIBarButtonItem alloc] initWithTitle:@"清除未读" style:UIBarButtonItemStylePlain target:self action:@selector(pressClean)];
    _btnClean.enabled = NO;
    for(NSMutableArray * array in _messageArray) {
        NSNumber * number = array[1];
        if(![number boolValue]) {
            _btnClean.enabled = YES;
            break;
        }
    }

    NSArray * array = @[_btnEdit,_btnClean];
    
    [self.navigationItem setRightBarButtonItems:array];
    
//    _btnBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
//    self.navigationItem.leftBarButtonItem = _btnBack;
//    [self.navigationItem setLeftBarButtonItem:_btnBack];
//    self.navigationItem.leftBarButtonItem.customView.backgroundColor = [UIColor redColor];
    
    
//    UIImage* image= [UIImage imageNamed:@"fanhui.png"];
//    CGRect frame= CGRectMake(0, 0, 35, 35);
//    UIButton *someButton= [[UIButton alloc] initWithFrame:frame];
//    someButton.backgroundColor = [UIColor redColor];
//    //someButton.backgroundColor = [UIColor colorWithPatternImage:image];
//    [someButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
//    [someButton setBackgroundImage:image forState:UIControlStateNormal];
//    //[someButton setShowsTouchWhenHighlighted:YES];
//    _btnBack = [[UIBarButtonItem alloc] initWithCustomView:someButton];
    if (@available(iOS 13.0, *)) {
        UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
            [rightButton setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
            [rightButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
           _btnBack = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//        _btnBack  = [[UIBarButtonItem alloc] initWithTitle:@"🔙" style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    } else {
        UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
            [rightButton setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
            [rightButton addTarget:self action:@selector(pressBack) forControlEvents:UIControlEventTouchUpInside];
           _btnBack = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    }
    [self.navigationItem setLeftBarButtonItem:_btnBack];
}

#pragma mark -- Edit methods
-(void) pressEdit {
    _isEdit = YES;
    //self.navigationItem.rightBarButtonItem = _btnFinish;
    NSArray * array = @[_btnFinish];
    [self.navigationItem setRightBarButtonItems:array];
    
    [_tableView setEditing:YES animated:YES];
    self.tableView.allowsSelection = YES;
    self.tableView.allowsSelectionDuringEditing=YES;
    self.tableView.allowsMultipleSelection = YES;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height-50);
        self.editingView.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    }];
}

-(void) pressFinish {
    _isEdit = NO;
    NSArray * array = @[_btnEdit,_btnClean];
    [self.navigationItem setRightBarButtonItems:array];
//
    [self.navigationItem setLeftBarButtonItem:_btnBack];
    
    [_tableView setEditing:NO animated:YES];
    [_chosedMessageArray removeAllObjects];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.view.frame.size.height);
        self.editingView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
    }];
}

-(void)pressClean {
//    for(NSIndexPath * indexPath in _unreadMessageIndexs) {
//        UITableViewCell * cell = [_tableView cellForRowAtIndexPath:indexPath];
//        //cell.accessoryType = UITableViewCellAccessoryNone;
//        NSNumber * number = [NSNumber numberWithBool:YES];
//        NSMutableArray * array = [_messageArray objectAtIndex:indexPath.section];
//        [array replaceObjectAtIndex:1 withObject:number];
//        [_messageArray replaceObjectAtIndex:indexPath.section withObject:array];
//
//        UIView * view = [[UIView alloc] init];
//        view.frame = CGRectMake(0, 0, 10, 10);
//        view.backgroundColor = [UIColor clearColor];
//        cell.accessoryView = view;
//        view.layer.cornerRadius = 5;
//    }
    
    for(int i = 0; i < _messageArray.count; i++) {
        NSMutableArray * array = _messageArray[i];
        NSNumber * number = [NSNumber numberWithBool:YES];
        [array replaceObjectAtIndex:1 withObject:number];
        [_messageArray replaceObjectAtIndex:i withObject:array];
    }
    
    [_tableView reloadData];
}

-(void)pressBack {
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self dismissViewControllerAnimated:NO completion:^{
        NSLog(@"返回");
        self.userPlaneView.alpha = 1;
        myDelegate.notificationIsOpen = NO;
    }];
}

#pragma mark -- tableview
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return _messageArray.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * strID = @"ID";
    
    UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    NSMutableArray * array = [_messageArray objectAtIndex:indexPath.section];
    cell.textLabel.text = array[0];
    cell.editingAccessoryView = nil;
    
    NSNumber * number = array[1];
    BOOL isRead = [number boolValue];
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, 10, 10);
    cell.accessoryView = view;
    view.layer.cornerRadius = 5;
    if(!isRead) {
        // cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
         view.backgroundColor = [UIColor redColor];
    } else {
        view.backgroundColor = [UIColor clearColor];
    }
    
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.multipleSelectionBackgroundView = [UIView new];
    //cell.tintColor = [UIColor redColor];
    cell.selectedBackgroundView = [UIView new];

    return cell;
}

// 设Cell编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 有以下两种编辑模式


// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     UITableViewCellEditingStyleDelete
     UITableViewCellEditingStyleInsert
     以上两者组合为多选状态
     UITableViewCellEditingStyleNone
     */
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

////当手指在单元格上移动时，可以显示编辑状态
//// 进入编辑模式，进行删除操作
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source.
////        //删除数据源对应的数据
////        [_messageArray removeObjectAtIndex:indexPath.section];
////        //数据源更新
////        [_tableView reloadData];
//        NSLog(@"删除");
//    }
//}
//
//// 修改编辑按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"删除";
//}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    //删除
    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        completionHandler (YES);
        [self.messageArray removeObjectAtIndex:indexPath.section];
        [self.tableView reloadData];
    }];
    //deleteRowAction.image = [UIImage imageNamed:@"删除"];
    deleteRowAction.backgroundColor = [UIColor redColor];

    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
    
    return config;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return @" ";
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.editing == NO) {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        NSNumber * number = [NSNumber numberWithBool:YES];
        NSMutableArray * array = [_messageArray objectAtIndex:indexPath.section];
        [array replaceObjectAtIndex:1 withObject:number];
        [_messageArray replaceObjectAtIndex:indexPath.section withObject:array];
        //cell.accessoryType = UITableViewCellAccessoryNone;
        UIView * view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, 10, 10);
        view.backgroundColor = [UIColor clearColor];
        cell.accessoryView = view;
        view.layer.cornerRadius = 5;
    } else {
        NSLog(@"选中");
        [_chosedMessageArray addObject:_messageArray[indexPath.section]];
        return;
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.isEditing) {
        NSLog(@"取消选中");
        [_chosedMessageArray removeObject:_messageArray[indexPath.section]];
    }
}

//-(void)tableview

#pragma mark -- press button
-(void)pressChoseButton:(UIButton *) btn {
    if(btn.tag == 0) {
        [btn setTitle:@"取消全选" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:197.0/255 green:197.0/255 blue:197.0/255 alpha:1.0];
        btn.tag = 1;
        for (int i = 0; i < _messageArray.count; i++) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:i] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    } else {
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
        btn.tag = 0;
        for (int i = 0; i < _messageArray.count; i++) {
            //[self.tableView reloadData];
            // 遍历反选
            [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.tableView deselectRowAtIndexPath:obj animated:NO];
            }];
             
        }
    }
}

-(void)pressCleanButton {
    NSLog(@"删除");
    if(_choseButton.tag == 1) {
        [_messageArray removeAllObjects];
        [UIView animateWithDuration:0.4 animations:^{
            self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.size.width, self.tableView.frame.size.height+100);
            self.editingView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50);
        }];
        [_tableView reloadData];
        [self pressFinish];
        [_choseButton setTitle:@"全选" forState:UIControlStateNormal];
        _choseButton.backgroundColor = [UIColor colorWithRed:0.07 green:0.585 blue:0.855 alpha:1];
    } else {
        for (int i = 0; i < _chosedMessageArray.count; i++) {
            [_messageArray removeObject:_chosedMessageArray[i]];
            [_tableView reloadData];
        }
    }
    [_chosedMessageArray removeAllObjects];
    
    if(!_messageArray.count) {
        _btnEdit.enabled = NO;
        _btnClean.enabled = NO;
    }
}

@end
