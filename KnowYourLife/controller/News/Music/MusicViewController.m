//
//  MusicViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/12.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicViewCell.h"
#import "MP3VideoModel.h"
#import "AFSoundManager.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"

#define API_MUSIC @"http://c.3g.163.com/nc/article/list/%@/0-%d.html"
#define API_MP3 @"http://c.3g.163.com/nc/article/%@/full.html"



#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define FONTMAXSIZE 15.f
#define FONTMINSIZE 14.f

static BOOL play = YES;
@interface MusicViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_tableView;
    BOOL _isLoaded;
    int _count;
    UIImageView *_picImageView;
    NSTimer *_timer;
    UIImageView *_picBgImageView;
    UIImageView *_bgImageView;
    UIButton *_playBtn;
    AFSoundPlayback *_playBack;
    AFSoundQueue *_queue;
    AFSoundItem *_item;
    UISlider *_timeSlider;
    UILabel *_leftLabel;
    UILabel *_rightLabel;
    
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *mp3Array;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIImageView *selectedplayStateIcon;

@end

@implementation MusicViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)mp3Array {
    if (_mp3Array == nil) {
        _mp3Array = [NSMutableArray array];
    }
    return _mp3Array;
}


- (id)initWithUrlType:(NSString *)urltype{
    self = [super init];
    if (self) {
        _urlType = urltype;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [NSMutableArray array];
    
    self.navigationController.navigationBar.hidden = YES;
    //    获取系统的view
    for (UIView *view in self.navigationController.view.subviews) {
        if ([NSStringFromClass([view class]) isEqualToString:@"UIScrollView"]) {
            view.hidden = YES;
        }
    }
    [self.navigationItem setHidesBackButton:YES animated:YES];
    CGRect rect = self.view.bounds;
    rect.origin.y += 300-20;
    rect.size.height -=300-20;
    _tableView = [[UITableView alloc] initWithFrame:rect];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
    [self createView];
    [self createBackButton];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _count = 20;
        [self loadData];
        
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _count += 20;
        [self loadData];
    }];
    footer.automaticallyRefresh = NO;
    _tableView.footer = footer;
    _tableView.footer.hidden = YES;
    _tableView.header = header;
    
    [self refreshData];
    
    
}
- (void)createBackButton {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    [backView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:backView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(10,15,65, 50)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backPressed) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"icon_back_highlighted"] forState:UIControlStateHighlighted];
    [backView addSubview:backBtn];
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBtn setFrame: CGRectMake(CGRectGetWidth(_bgImageView.frame)/2.0 - 25, CGRectGetHeight(_bgImageView.frame)/2.0 - 25, 50, 50)];
    [_playBtn setBackgroundColor:[UIColor clearColor]];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"audionews_pause_button"] forState:UIControlStateNormal];
    [_playBtn addTarget:self action:@selector(playSound:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:_playBtn];
    
    UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [lastBtn setFrame:CGRectMake(CGRectGetMinX(_picBgImageView.frame) - 60,CGRectGetHeight(_bgImageView.frame)/2.0 - 20, 40, 40)];
    [lastBtn setBackgroundImage:[UIImage imageNamed:@"上一曲.tiff"] forState:UIControlStateNormal];
    [lastBtn addTarget:self action:@selector(lastPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:lastBtn];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(CGRectGetMaxX(_picBgImageView.frame) + 20,CGRectGetMinY(lastBtn.frame), CGRectGetWidth(lastBtn.frame), CGRectGetHeight(lastBtn.frame))];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"下一曲.tiff"] forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(nextPressed) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:nextBtn];
    
}

- (void)createView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300.f)];
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    [view setUserInteractionEnabled:YES];
    int value = arc4random() % 6;
    if (value == 0) {
        [_bgImageView setImage:[UIImage imageNamed:@"usercenter_hd_cover_0"]];
    }else if (value == 1) {
        [_bgImageView setImage:[UIImage imageNamed:@"usercenter_hd_cover_1"]];
    }else if (value == 2) {
        [_bgImageView setImage:[UIImage imageNamed:@"usercenter_hd_cover_2"]];
    }else if (value == 3) {
        [_bgImageView setImage:[UIImage imageNamed:@"usercenter_hd_cover_3"]];
    }else if (value == 4) {
        [_bgImageView setImage:[UIImage imageNamed:@"audionews_play_bg"]];
    }else if (value == 5) {
        [_bgImageView setImage:[UIImage imageNamed:@"localnewsheader_background"]];
    }
    [view addSubview:_bgImageView];
    [self.view addSubview:view];
    
    _picBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_bgImageView.frame)/2.0 - 75, CGRectGetHeight(_bgImageView.frame)/2.0 - 75, 150, 150)];
    [_picBgImageView setImage:[UIImage imageNamed:@"night_audio_button_bg"]];
    [_picBgImageView setUserInteractionEnabled:YES];
    [_bgImageView addSubview:_picBgImageView];
    _bgImageView.userInteractionEnabled = YES;
    
    _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 130, 130)];
    _picImageView.layer.cornerRadius = 65.f;
    [_picImageView setClipsToBounds:YES];
    [_picImageView setUserInteractionEnabled:YES];
    [_picBgImageView addSubview:_picImageView];
    [self createSlider];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changeTimeAtTimeDisplay) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)createSlider {
    
    _timeSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_picBgImageView.frame) + 25, WIDTH - 40, 2)];
    [_bgImageView addSubview:_timeSlider];
    [_timeSlider setMaximumValue:1.0];
    [_timeSlider setMinimumValue:0.0];
    [_timeSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    
    _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_timeSlider.frame), CGRectGetMaxY(_timeSlider.frame) +15,45,25)];
    [_leftLabel setBackgroundColor:[UIColor clearColor]];
    [_leftLabel setTextColor:[UIColor whiteColor]];
    [_bgImageView addSubview:_leftLabel];
    [_leftLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
    
    _rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_timeSlider.frame)- 40, CGRectGetMaxY(_timeSlider.frame) +15,45, 25)];
    [_rightLabel setBackgroundColor:[UIColor clearColor]];
    [_bgImageView addSubview:_rightLabel];
    [_rightLabel setTextColor:[UIColor whiteColor]];
    [_rightLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
}

#pragma mark ---图片旋转---
- (void)changeTimeAtTimeDisplay
{
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        _picImageView.transform = CGAffineTransformRotate(_picImageView.transform, M_PI_4 * 0.1 );
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)sliderChanged:(UISlider *)slider {
    
    
}

#pragma mark ---button点击事件---
- (void)backPressed {
    
    [_queue clearQueue];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)playSound:(UIButton *)btn {
    
    
    if (play) {
        if ([_timer isValid]) {
            [_timer setFireDate:[NSDate distantFuture]];
        }
        [_queue pause];
        [btn setBackgroundImage:[UIImage imageNamed:@"audionews_play_button"] forState:UIControlStateNormal];
        play = NO;
    }else{
        [_timer setFireDate:[NSDate date]];
        [_queue playCurrentItem];
        [btn setBackgroundImage:[UIImage imageNamed:@"audionews_pause_button"] forState:UIControlStateNormal];
        play = YES;
    }
    
}

- (void)nextPressed {
    
    NSInteger indexNow = _queue.indexOfCurrentItem;

    [self tableView:_tableView didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexNow inSection:0]];
    
    [_queue playNextItem];
    NSInteger index = _queue.indexOfCurrentItem;
    MusicModel *model = self.dataArray[index];
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"night_audio_block_bg"]];
    
    MusicViewCell *cell = (MusicViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:0];
    
    model.isPlaying = YES;
    cell.playStateIcon.hidden = NO;
    [cell.playStateIcon setImage:[UIImage imageNamed:@"audionews_playlist_playing01"]];
    cell.musicModel = model;
    
    play = YES;
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"audionews_pause_button"] forState:UIControlStateNormal];
    
    [_timer setFireDate:[NSDate date]];
    int min = (int)_queue.getCurrentItem.duration / 60;
    int sec = (int)_queue.getCurrentItem.duration % 60;
    [_rightLabel setText:[NSString stringWithFormat:@"%02d:%02d",min,sec]];
    
    [self Timetimer];
    
}

- (void)lastPressed {
    
    NSInteger indexNow = _queue.indexOfCurrentItem;
    
    [self tableView:_tableView didDeselectRowAtIndexPath:[NSIndexPath indexPathForRow:indexNow inSection:0]];
    [_queue playPreviousItem];
    NSInteger index = _queue.indexOfCurrentItem;
    MusicModel *model = self.dataArray[index];
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"night_audio_block_bg"]];
    MusicViewCell *cell = (MusicViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:0];
    
    model.isPlaying = YES;
    cell.playStateIcon.hidden = NO;
    [cell.playStateIcon setImage:[UIImage imageNamed:@"audionews_playlist_playing01"]];
    cell.musicModel = model;
    
    play = YES;
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"audionews_pause_button"] forState:UIControlStateNormal];

    [_timer setFireDate:[NSDate date]];
    int min = (int)_queue.getCurrentItem.duration / 60;
    int sec = (int)_queue.getCurrentItem.duration % 60;
    [_rightLabel setText:[NSString stringWithFormat:@"%02d:%02d",min,sec]];
    
    [self Timetimer];
    
}

#pragma mark ---loadData---

- (void)refreshData {
    if (_isLoaded) {
        
    }else {
        [_tableView.header beginRefreshing];
        _isLoaded = YES;
    }
}
-(void)changeurl:(NSNotification*)indexNote{
    _urlType = indexNote.userInfo[@"str"];
}
- (void)loadData {
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeurl:) name:@"indexNote" object:nil];
    
    NSString *urlStr = [NSString stringWithFormat:API_MUSIC,_urlType,_count];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.dataArray = [MusicModel objectArrayWithKeyValuesArray:responseObject[_urlType]];
        [_tableView.header endRefreshing];
        MusicModel *model = self.dataArray[0];
        [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"night_audio_block_bg"]];
        
        if (_count == 20) {
            [_tableView.header endRefreshing];
            [_tableView.footer setHidden:NO];
        }else if (_count > 20) {
            
            [_tableView.footer endRefreshing];
        }

        for (MusicModel *mp3Model in self.dataArray) {
            
            [self reLoadDataWithId:mp3Model.docid];
         
        }
        
        [_tableView reloadData];
        
        MusicViewCell *cell = (MusicViewCell *)[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
        MusicModel *firstModel =  cell.musicModel;
        firstModel.isPlaying = YES;
        cell.musicModel = firstModel;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error = %@",[error localizedDescription]);
        [_tableView.header endRefreshing];
    }];
    
}

- (void)reLoadDataWithId:(NSString *)docid {
    
    NSString *MP3Url = [NSString stringWithFormat:API_MP3,docid];
    
    AFHTTPRequestOperationManager *MP3Manager = [AFHTTPRequestOperationManager manager];
    
    MP3Manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    
    [MP3Manager GET:MP3Url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSMutableArray *arr = [NSMutableArray array];
        arr = [MP3VideoModel objectArrayWithKeyValuesArray:responseObject[docid][@"video"]];
        MP3VideoModel *model = arr[0];
        _item = [[AFSoundItem alloc] initWithStreamingURL:[NSURL URLWithString:model.url_m3u8]];
        [_items addObject:_item];
        [_tableView.header endRefreshing];
        if (_items.count == _dataArray.count) {
            [self createMp3Player];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error localizedDescription]);
        [_tableView.header endRefreshing];
    }];
    
}

- (void)createMp3Player {
    
    _leftLabel.text = nil;
    _rightLabel.text = nil;
    
    _queue = [[AFSoundQueue alloc] initWithItems:_items];
    
    [_queue playCurrentItem];
    
    int min = (int)_queue.getCurrentItem.duration / 60;
    int sec = (int)_queue.getCurrentItem.duration % 60;
    [_rightLabel setText:[NSString stringWithFormat:@"%02d:%02d",min,sec]];
    
    if (_rightLabel == nil) {
        [_leftLabel setText:@""];
    }else {
        [_leftLabel setText:@"00:00"];
    }
    [self Timetimer];
    
}

- (void)Timetimer {
    
    [_queue listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
        
        NSInteger time =(long)item.timePlayed;
        _leftLabel.text = [NSString stringWithFormat:@"%02ld:%02ld",time/60,time%60];
        _timeSlider.value = 1.0 / (long)item.duration * time;
        
    } andFinishedBlock:^(AFSoundItem *nextItem) {
        
        [_queue playNextItem];
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *iden = [NSString stringWithFormat:@"identifier + %ld",indexPath.row];
    
    MusicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil) {
        cell = [[MusicViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    
    MusicModel *model = _dataArray[indexPath.row];
    cell.musicModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MusicModel *model = self.dataArray[indexPath.row];
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:[UIImage imageNamed:@"night_audio_block_bg"]];
    [_queue playItem:(AFSoundItem *)_items[indexPath.row]];
    [_timer setFireDate:[NSDate date]];
    play = YES;
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"audionews_pause_button"] forState:UIControlStateNormal];
    MusicViewCell * cell =  (MusicViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    int min = (int)_queue.getCurrentItem.duration / 60;
    int sec = (int)_queue.getCurrentItem.duration % 60;
    [_rightLabel setText:[NSString stringWithFormat:@"%02d:%02d",min,sec]];
    

//    NSIndexPath * index2 = [_tableView indexPathForSelectedRow];


    model.isPlaying = YES;
    cell.playStateIcon.hidden = NO;
    [cell.playStateIcon setImage:[UIImage imageNamed:@"audionews_playlist_playing01"]];
    cell.musicModel = model;



}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicModel *model = self.dataArray[indexPath.row];
    MusicViewCell *cell = (MusicViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    model.isPlaying = NO;
    cell.playStateIcon.hidden = YES;
    cell.musicModel = model;


}

@end
