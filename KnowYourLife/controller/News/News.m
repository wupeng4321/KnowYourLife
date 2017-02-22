//
//  News.m
//  KnowYourLife

//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "News.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#define SIZE self.view.bounds.size
#define COUNT 5

#import "TopNewsViewController.h"
#import "InternetNewsViewController.h"
#import "ChineseBusinessManViewController.h"
#import "FirestHomeViewController.h"
#import "luxuriesViewController.h"
#import "EverydayMealViewController.h"
#import "WeiPhoneViewController.h"
#import "WYBeautyViewController.h"
#import "MovieNewsViewController.h"
#import "SDCycleScrollView.h"


@implementation News{
    UIScrollView *WPScrollView;
    UIPageControl *WPPageControl;
    NSTimer * Timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    
//    [self createAD1];
    [self createAD2];
    
    [self createImage];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)createAD2 {
    NSMutableArray * mArray = [NSMutableArray array];
    
    for (int i = 1; i < 6; i++) {
        
        NSString *name = [NSString stringWithFormat:@"%d.jpg", i];
        [mArray addObject:name];
    }
    SDCycleScrollView *YKCSView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 190) imageURLStringsGroup:mArray];
    YKCSView.autoScrollTimeInterval = 3;
    YKCSView.backgroundColor = [UIColor redColor];
    [self.view addSubview:YKCSView];
    

}
-(void)createAD1{
    //1.创建
    GYKCycleScrollView *YKCSView = [[GYKCycleScrollView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 150+40)];
    
    //YKCSView.backgroundColor = [UIColor redColor];
    
    //2.设置代理
    YKCSView.delegate = self;
    
    [self.view addSubview:YKCSView];
    
    
    /**
     *  3.传入图片
     */
    
    NSMutableArray * mArray = [NSMutableArray array];
    
    for (int i = 1; i < 6; i++) {
        
        NSString *name = [NSString stringWithFormat:@"%d.jpg", i];
        [mArray addObject:name];
    }
    
    
    //1.没有定时器
    //[YKCSView setImageUrlNames:mArray];
    
    //2.定时器的
    [YKCSView setImageUrlNames:mArray animationDuration:2];
    
}
- (void)cycleScrollView:(GYKCycleScrollView *)cycleScrollView DidTapImageView:(NSInteger)index
{
    
    NSLog(@"%lu", index);
}

-(void)createAD{
    //1.创建
    WPScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SIZE.width, 150)];
    [self.view addSubview:WPScrollView];
    
    //2.添加内容
    for (int i = 0; i < COUNT + 2; i++) {
        //0 1 2 3 4 5 6 7
        NSString * imageName = [NSString stringWithFormat:@"%d.jpg", i];
        
        if (i == 0) {
            imageName = @"5.jpg";
        }
        if (i == COUNT + 1) {
            imageName = @"1.jpg";
        }
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SIZE.width * i, 0, SIZE.width, 150)];
        imageView.image = [UIImage imageNamed:imageName];
        
        [WPScrollView addSubview:imageView];
    }

    //3.设置contentSize
    WPScrollView.contentSize = CGSizeMake((COUNT + 2) * SIZE.width, 0);
    
    WPScrollView.pagingEnabled = YES;
    
    WPScrollView.contentOffset = CGPointMake(SIZE.width, 0);
    
    WPScrollView.showsHorizontalScrollIndicator = NO;
    WPScrollView.showsVerticalScrollIndicator = NO;
    
    WPScrollView.delegate = self;
    
    //创建pageControl
    WPPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(40, 185, 300, 20)];
    
    //设置个数
    WPPageControl.numberOfPages = COUNT;
    
    //添加颜色
    WPPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    WPPageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    WPPageControl.userInteractionEnabled = NO;
    
    [self.view addSubview:WPPageControl];
    
    //创建定时器
    Timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(refresh) userInfo:nil repeats:YES];

}


-(void)refresh{
    CGPoint point = WPScrollView.contentOffset;
    point.x+=SIZE.width;
    [WPScrollView setContentOffset:point animated:YES];
    
}

-(void)createImage{
    NSArray *normalImage = @[@"头条新闻",@"互联网新闻",@"中国企业家",@"一号家居网",@"奢侈品频道",@"每日菜谱",@"威锋网",@"网易美女",@"电影资讯"];
    NSArray *selectedImage = @[@"头条新闻_press",@"互联网新闻_press",@"中国企业家_press",@"一号家居网_press",@"奢侈品频道_press",@"每日菜谱_press",@"威锋_press",@"网易美女_press",@"电影资讯_press"];\
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64+130, WIDTH, HEIGHT-64-130-49)];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];
    
    for (int i = 0; i < 9; i++){
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(i%3*WIDTH/3, i/3*(HEIGHT-64-150-49)/3, WIDTH/3-1, (HEIGHT-64-150-49)/3)];
        [button setBackgroundImage:[UIImage imageNamed:normalImage[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:selectedImage[i]] forState:UIControlStateHighlighted];
        [imageView addSubview:button];
        button.tag = i+10;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    }
}
//跳转页面
-(void)buttonClick:(UIButton*)sender{
    NSArray *classArr = @[@"TopNewsViewController",@"InternetNewsViewController",@"ChineseBusinessManViewController",@"FirestHomeViewController",@"luxuriesViewController",@"EverydayMealViewController",@"WeiPhoneViewController",@"WYBeautyViewController",@"MovieNewsViewController"];
    NSInteger i = sender.tag-10;
    Class cla=NSClassFromString(classArr[i]);
    UIViewController * vc =[[cla alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    WPPageControl.currentPage = scrollView.contentOffset.x/SIZE.width-0.5;
//    
//    if (scrollView.contentOffset.x == (COUNT + 1) * SIZE.width) {
//        scrollView.contentOffset = CGPointMake(SIZE.width, 0);
//    }
//    
//    if (scrollView.contentOffset.x == 0) {
//        scrollView.contentOffset = CGPointMake(COUNT * SIZE.width, 0);
//    }
//
//}
//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    [Timer setFireDate:[NSDate distantFuture]];
//}
//
//-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    [Timer setFireDate:[NSDate distantPast]];
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
