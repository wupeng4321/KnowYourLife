//
//  AudioViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/12.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "AudioViewController.h"
#import "AudioModel.h"
#import "TopModel.h"
#import "AudioViewCell.h"
#import "AudioDetailViewCell.h"
#import "MusicViewController.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#define API_AUDIO @"http://c.3g.163.com/nc/topicset/android/radio/index.html"
#define WIDTH [[UIScreen mainScreen] bounds].size.width

#define FONTMAXSIZE 15.f
@interface AudioViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    BOOL _isLoaded;

}

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *topArray;
@property (nonatomic, strong)NSMutableArray *iconArray;
@property (nonatomic, strong)NSMutableArray *playBtnArr;

@end

@implementation AudioViewController

- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)iconArray {
    
    if (_iconArray == nil) {
        _iconArray = [NSMutableArray array];
    }
    return _iconArray;
}
- (NSMutableArray *)topArray {
    
    if (_topArray == nil) {
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}
- (NSMutableArray *)playBtnArr {
    
    if (_playBtnArr == nil) {
        _playBtnArr = [NSMutableArray array];
    }
    return _playBtnArr;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //接受通知
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(indexValue:) name:@"index" object:nil];
        
      
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, self.view.bounds.size.height-20-49) style:UITableViewStyleGrouped];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 180.f)];
        topImageView.image = [UIImage imageNamed:@"1.jpg"];
        _tableView.tableHeaderView = topImageView;

        [self.view addSubview:_tableView];
        _tableView.separatorColor = [UIColor clearColor];
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
            
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self loadData];
        }];
        footer.automaticallyRefresh = NO;
        _tableView.footer = footer;
        
        
        _tableView.footer.hidden = YES;
        _tableView.header = header;
    }
    return self;
}
-(void)indexValue:(NSNotification*)noti{
    MusicViewController * music = [[MusicViewController alloc] init];
    music.urlType = noti.object;
    [self.navigationController pushViewController:music animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * top = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 20)];
    top.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:top];
    
    
//    [self createImageView];
    
    //self.navigationController.navigationBarHidden = YES;
   // self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
#pragma mark ---下载数据---
/**
 *  刷新数据
 */
- (void)refreshData {
    
    if (_isLoaded) {
        
    }else {
        [_tableView.header beginRefreshing];
        _isLoaded = YES;
    }
}

- (void)loadData {
    
    NSString *urlStr = API_AUDIO;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        self.topArray = [TopModel objectArrayWithKeyValuesArray:responseObject[@"top"]];
        self.dataArray = [AudioModel objectArrayWithKeyValuesArray:responseObject[@"cList"]];
       // NSLog(@"%lu",_dataArray.count);
        [_tableView.header endRefreshing];
        
        
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error = %@", [error localizedDescription]);
        [_tableView.header endRefreshing];
    }];
}
- (void)createImageView {
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 180.f)];
    topImageView.backgroundColor = [UIColor redColor];
    _tableView.tableHeaderView = topImageView;
//    if (self.topArray == nil) {
//
//        TopModel *topModel = _topArray[0];
//        [_topImageView sd_setImageWithURL:[NSURL URLWithString:topModel.radio.imgsrc] placeholderImage:nil];
//    }else {
//        
//        [_topImageView setImage:[UIImage imageNamed:@"1.jpg"]];
//        
//    }
    topImageView.image = [UIImage imageNamed:@"1.jpg"];

//    [self.view addSubview:topImageView];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 50.f;
    }
    return 200.f;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AudioModel *model = _dataArray[indexPath.section];
    if (indexPath.row == 0) {
        static NSString *iden = @"cellID";
        
        AudioViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        
        if (!cell) {
            cell = [[AudioViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }

            cell.audioModel = model;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else{
        
        static NSString *iden = @"cell";
        AudioDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        
        if (!cell) {
            cell = [[AudioDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        cell.audioModel = model;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40.f;
    }
    return 0.01f;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40.f)];
        [view setBackgroundColor:[UIColor lightGrayColor]];
        [view setAlpha:0.5];
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBtn setFrame:CGRectMake(0, 0, WIDTH/2.0, 40.f)];
        [leftBtn setBackgroundColor:[UIColor clearColor]];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"contentview_graylongbutton@2x.png"] forState:UIControlStateNormal];
        [leftBtn setImage:[UIImage imageNamed:@"audionews_icon_download@2x.png"] forState:UIControlStateNormal];
        [leftBtn setTitle:@" 我的下载" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [leftBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
        [view addSubview:leftBtn];
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBtn setFrame:CGRectMake(CGRectGetMaxX(leftBtn.frame), 0,CGRectGetWidth(leftBtn.frame), 40.f)];
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"contentview_graylongbutton@2x.png"] forState:UIControlStateNormal];
        [rightBtn setImage:[UIImage imageNamed:@"lm_store_opentime@2x.png"] forState:UIControlStateNormal];
        [rightBtn setTitle:@" 最近播放" forState:UIControlStateNormal];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
        [rightBtn setBackgroundColor:[UIColor clearColor]];
        [view addSubview:rightBtn];
        
        return view;
    }
    return nil;
}


@end
