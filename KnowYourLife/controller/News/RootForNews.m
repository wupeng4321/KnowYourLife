//
//  RootForNews.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "RootForNews.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"

#define SIZE self.view.bounds.size
@interface RootForNews ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSMutableArray * dataArr;
@property (nonatomic, strong)NSMutableArray * headArr;
@property (nonatomic, strong)NSMutableArray * cellArr;
@property NSInteger cellPage;
@end

@implementation RootForNews

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    [self createTableView];
    
}
-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}
-(void)loadData:(NSString*)str{
    _dataArr = [[NSMutableArray alloc] init];
    _headArr = [[NSMutableArray alloc] init];
    _cellArr = [[NSMutableArray alloc] init];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:str parameters:nil success:^(AFHTTPRequestOperation *  operation, id   responseObject) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * articlesArr = rootDic[@"data"][@"articles"];
        for (NSDictionary * dic in articlesArr) {
            NewsModel * mm = [[NewsModel alloc] init];
            
            mm.media_count = dic[@"media_count"];
            mm.iconUrl = dic[@"thumbnail_mpic"];
            mm.titleLabel = dic[@"title"];
            mm.detailUrl = dic[@"weburl"];
            
            if (mm.iconUrl != nil) {
                [_dataArr addObject:mm];
                
            }
            
        }
         NSLog(@"_dataArr.count=%lu", (unsigned long)_dataArr.count);
        for (int i = 0; i < _dataArr.count/5*5; i++) {
            NewsModel * model = _dataArr[i];
            if (i%5==0) {
                
                NSLog(@"i=%d",i);
                [_headArr addObject:model];
                //[_dataArr removeObject:model];
            }else{
                [_cellArr addObject:model];
            }
        }
        NSLog(@"1=%lu",_cellArr.count);
        NSLog(@"2=%lu",(unsigned long)_headArr.count);
        NSLog(@"3=%lu", (unsigned long)_dataArr.count);
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *  operation, NSError *  error) {
        NSLog(@"loaderror");
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //NSLog(@"%lu",(unsigned long)_dataArr.count);
    return _dataArr.count/5 ;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
    }
    NewsModel * mm = _cellArr[indexPath.section*4+indexPath.row];
    _cellPage = indexPath.section*4+indexPath.row;
    NSLog(@"_cellPage11111111=%lu", _cellPage);
    //NSLog(@"%@",mm.titleLabel);
    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:mm.iconUrl]];
    cell.titleLabel.text = mm.titleLabel;
    
    //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:mm.iconUrl]];
    

    cell.accessoryType = UITableViewAutomaticDimension;
    
    //cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (SIZE.height-64-49)/3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SIZE.height-64-49)*2/3/4;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView * headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 150)];
    NewsModel * mm = _headArr[section];
    [headerView sd_setImageWithURL:[NSURL URLWithString:mm.iconUrl]];
    headerView.tag = section+1;
    headerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
    
    
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    
    [headerView addGestureRecognizer:tap];
    
    return headerView;

}
-(void)headerClick:(UITapGestureRecognizer*)tap{
    //NSLog(@"1");
    UIImageView * imageView = (id)tap.view;
    NewsModel * mm = _headArr[imageView.tag-1];
    NSLog(@"imageView.tag=%lu",imageView.tag);
    DetailViewController * vc = [[DetailViewController alloc] init];
    
    vc.urlstr = mm.detailUrl;
    NSLog(@"vc.urlstr=%@",vc.urlstr);
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row=%lu",indexPath.row);
    NSLog(@"section=%lu",indexPath.section);
    NSLog(@"_dataArr.count=%lu",_dataArr.count);
    NewsModel * mm = _cellArr[indexPath.section*4+indexPath.row];
    //NewsModel * mm = _cellArr[_cellPage];
    NSLog(@"tag=%lu",indexPath.section*4+indexPath.row);
    
    DetailViewController * vc = [[DetailViewController alloc] init];
    vc.urlstr = mm.detailUrl;
    NSLog(@"%@",mm.detailUrl);
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];

}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"row=%lu",indexPath.row);
//    NSLog(@"section=%lu",indexPath.section);
//    NSLog(@"_dataArr.count=%lu",_dataArr.count);
//    NewsModel * mm = _cellArr[indexPath.section*4+indexPath.row+1];
//    //NewsModel * mm = _cellArr[_cellPage];
//    NSLog(@"tag=%lu",indexPath.section*4+indexPath.row);
//    
//    DetailViewController * vc = [[DetailViewController alloc] init];
//    vc.urlstr = mm.detailUrl;
//    NSLog(@"%@",mm.detailUrl);
//    
//    vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
