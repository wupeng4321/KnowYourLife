//
//  Photo.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/11.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "Photo.h"
#import "FirstPhotoTableViewCell.h"
#import "AFNetworking.h"
#import "ImgModel.h"
#import "ImgGroupModel.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"
#import "MJRefresh.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface Photo ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>{
    int page;
    NSMutableArray * _dataArr;
    NSMutableArray * _groupArr;
    BOOL _isLoaded;
}

@end

@implementation Photo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden =YES;
    page = 602;
    _dataArr = [[NSMutableArray alloc] init];
    _groupArr = [[NSMutableArray alloc] init];

    //[self loadData];
    [self createTableView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_dataArr removeAllObjects];
        [self loadData];
        [_tableView.header endRefreshing];
        NSLog(@"uprefresh");
        
    }];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page+=3;
        [self loadData];
        NSLog(@"%d",page);
        NSLog(@"loaddata");
        [_tableView.footer endRefreshing];
    }];
    footer.automaticallyRefresh = NO;
    _tableView.footer = footer;
    //_tableView.footer.hidden = YES;
    _tableView.header = header;
    
    [self refreshData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toDetail:) name:@"ImageDetail" object:nil];
    
}

- (void)refreshData {
    if (_isLoaded) {
        [_tableView.footer beginRefreshing];
    }else {
        [_tableView.header beginRefreshing];
        _isLoaded = YES;
    }
}

-(void)toDetail:(NSNotification*)noti{
    DetailViewController * vc = [[DetailViewController alloc] init];
    vc.urlstr = noti.userInfo[@"str"];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, HEIGHT-20-44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
}
-(void)loadData{
    
    NSString * urlStr = [NSString stringWithFormat:@"http://iphone.myzaker.com/zaker/blog2news.php?_appid=androidphone&_bsize=1080_1920&_version=6.41&app_id=12040&nt=1&since_date=1445825%d",page];
//    NSString *url = @"http://iphone.myzaker.com/zaker/blog2news.php?_appid=androidphone&_bsize=1080_1920&_version=6.45&app_id=1289&nt=1&since_date=1450272269";
    NSString *url = @"http://iphone.myzaker.com/zaker/news.php?_appid=AndroidPhone&_bsize=1080_1920&_version=6.56&app_id=12040";
   // NSURL *url = [NSURL URLWithString:urlStr];
   // NSString * urlStr = @"http://iphone.myzaker.com/zaker/blog2news.php?_appid=androidphone&_bsize=1080_1920&_version=6.41&app_id=12040&nt=1&since_date=1445825602";
   // NSLog(@"loadpage=%d",page);
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * articlesArr = rootDic[@"data"][@"articles"];
        for (NSDictionary * dic in articlesArr) {
            ImgModel * mm = [[ImgModel alloc] init];
            
            mm.imgsrc = dic[@"thumbnail_mpic"];
            
            mm.imgUrl = dic[@"weburl"];
            [_dataArr addObject:mm];
        }
       // NSLog(@"%lu",(unsigned long)_dataArr.count);

//        [_tableView footerEndRefreshing];
//        [_tableView headerEndRefreshing];
        
        [_tableView.header endRefreshing];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        NSLog(@"loaderror");
    }];
}
//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"_dataArr.count/9=%lu",_dataArr.count/9);
    return _dataArr.count/9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FirstPhotoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (cell==nil) {
        cell = [[FirstPhotoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        }
    for (NSInteger i = 0; i < 9; i++) {
        ImgModel * mm = _dataArr[indexPath.row*9+i];
        [_groupArr addObject:mm];
   }
    //深拷贝获取对象所有权
    cell.imgGroupArr = [_groupArr copy];
   // NSLog(@"cell.imgGroupArr.count=%lu", cell.imgGroupArr.count);
    return cell;
}

//-(void)imageToDetail:(UITapGestureRecognizer*)tap{
//    DetailViewController * vc = [[DetailViewController alloc] init];
//    UIImageView * imageView = (id)tap.view;
//   // NSLog(@"imageView.tag=%lu",imageView.tag);
//    ImgModel * mm = _dataArr[imageView.tag];
//    vc.urlstr = mm.imgUrl;
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}
-(void)buttonToDetail:(UIButton*)button{
    
    NSLog(@"%lu", button.tag);
    DetailViewController * vc = [[DetailViewController alloc] init];
    
    ImgModel * mm = _dataArr[button.tag];
    
    vc.urlstr = mm.imgUrl;
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT-20-44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 0;
}











@end
