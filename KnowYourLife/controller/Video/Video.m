//
//  Video.m
//  KnowYourLife
//
//  Created by wupeng on 16/04/14.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "Video.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "VisualModel.h"
#import "VisualTypeModel.h"
#import "VisualTableViewCell.h"
#import "TypeViewCell.h"

@interface Video ()<UITableViewDelegate,UITableViewDataSource> {
    
    int _count;
    BOOL _isLoaded;
    
}

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)NSMutableArray *picsArray;
@end



@implementation Video


- (instancetype)init {
    
    self = [super init];
    if (self) {
        CGRect rect = self.view.bounds;
        rect.size.height -= 49;
        rect.origin.y=20;
        _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [self.view addSubview:_tableView];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            _count = 0;
            [self loadData];
            
        }];
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            _count += 10;
            [self loadData];
        }];
        footer.automaticallyRefresh = NO;
        _tableView.footer = footer;
        
        
        _tableView.footer.hidden = YES;
        _tableView.header = header;
    }
    
    return self;
}

- (NSMutableArray *)picsArray {
    
    if (_picsArray == nil) {
        _picsArray = [NSMutableArray array];
    }
    return _picsArray;
}
- (NSMutableArray *)dataArray {
    
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 20)];
    ima.backgroundColor = [ UIColor redColor];
    //[self.view addSubview:ima];
    
    [self refreshData];
}

- (void)refreshData {
    
    if (_isLoaded) {
        
    }else {
        [_tableView.header beginRefreshing];
        _isLoaded = YES;
    }
}

- (void)loadData {
    
    //NSString *urlStr = [NSString stringWithFormat:_urlString,_count];
    NSString * urlStr = [NSString stringWithFormat:@"http://c.3g.163.com/nc/video/home/%d-10.html",_count];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation * operation, id resultObject) {
        
        NSArray *videoArr = resultObject[@"videoList"];
        if (_count == 0) {
            self.dataArray = [VisualModel pasringDataFromArray:videoArr];
            [_tableView.header endRefreshing];
            _tableView.footer.hidden = NO;
        }else {
            NSArray *arr = [VisualModel pasringDataFromArray:videoArr];
            for (VisualModel *model in arr) {
                [self.dataArray addObject:model];
            }
            [_tableView.footer endRefreshing];
        }
        
        NSArray *picsArr = resultObject[@"videoSidList"];
        self.picsArray = [VisualTypeModel pasringDataFromArray:picsArr];
        NSLog(@"_picsArray.count=%lu",_picsArray.count);
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"error = %@",[error description]);
        [_tableView.header endRefreshing];
        [_tableView.footer endRefreshing];
    }];
    
    
}

#pragma mark ---UITableViewDelegate和UITableViewDataSource---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
//    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }
    return 300.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        NSString *iden = @"type";
        TypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (!cell) {
            cell = [[TypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        }
        
        cell.picsArr = _picsArray;
        
        return cell;
    }
    
    NSString *iden = [NSString stringWithFormat:@"cellID + %ld",indexPath.row];
    
    VisualTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (!cell) {
        cell = [[VisualTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    }
    //[MBProgressHUD hideHUDForView:cell.playerView animated:YES];
    VisualModel *model = _dataArray[indexPath.row + 10];
    
    cell.visualModel = model;
    
    return cell;
}
@end
