//
//  TalkingViewController.h
//  mosad_hw_final
//
//  Created by Jason on 2020/12/18.
//  Copyright © 2020 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MyUIImageView.h"
#import "AFNetworking.h"

NS_ASSUME_NONNULL_BEGIN

@interface TalkingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate,UIImagePickerControllerDelegate, AVAudioRecorderDelegate>
{
    UIImageView * backgroundView;
    UITableView * tableView;
    UIView * microphoneBar;
    UIButton * microphone;
    //之前在播放的动画
    UIImageView * lastSound;
    
    //音频播放器对象
    AVAudioPlayer * _player;
    //录音对象
    AVAudioRecorder * _recorder;
    //定义声明一个定时器对象
    NSTimer * _timer;
    
    //用于判断语音是否录音与发送
    UIImageView * recordOrCancel;
    
    NSMutableArray * recordAnimationArray;
    //最新录音文件路径
    NSString * path;
    //最新的录音文件名
    NSString * name;
    //用于计时
    int count;
    //判断录音时手指是否移出录音区域
    BOOL isOutside;
    
    //用于不断获取数据库的音频信息
    NSTimer * getAudioTimer;
    //用于获取音频名称
    NSArray * audioNameArray;
    //用于判断是否有拿到音频文件名
    BOOL haveAudio;
    //新拿的音频路径
    NSURL * filePath;
    //头像名称
    NSString * imageName;
    //投诉名单
    NSMutableArray * complaintArray;
    //被点击投诉的用户名
    NSString * complaintUserName;
    //用于投诉
    NSMutableDictionary * _cellSelectDic;
    
    NSTimer * tagTimer;
} 

@property (nonatomic, retain) NSMutableArray * userArray;
@property (nonatomic, retain) NSMutableArray * voiceArray;

@property (nonatomic, retain) NSMutableArray * voiceOfcomplaintArray;
//话题显示框
@property (nonatomic, nonnull) UIScrollView * scrollView;
//话题数组
@property (nonatomic, nonnull) NSMutableArray * topicArray;

@end

NS_ASSUME_NONNULL_END
