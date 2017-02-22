//
//  DetailViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "DetailViewController.h"
#import "ZCControl.h"
#import "UMSocial.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFooter];
    [self createWebView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
-(void)createFooter{
    //底栏
    footerImageView=[ZCControl createImageViewFrame:CGRectMake(0,HEIGHT-40, WIDTH,40) imageName:@"ad_title_bg.png"];
    footerImageView.userInteractionEnabled=YES;
    //收藏按钮
    UIButton *collectButton=[UIButton buttonWithType:UIButtonTypeCustom];
    collectButton.frame=CGRectMake(0,0,35,35);
    [collectButton addTarget:self action:@selector(collectButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIImageView *collectImage=[ZCControl createImageViewFrame:CGRectMake(50,0,35,35) imageName:@"收藏前.png"];
    collectImage.userInteractionEnabled=YES;
    //    UIImage *image = (UIImage *)collectImage;
    //    [collectButton setImage:image forState:UIControlStateNormal];
    //    [collectButton setImage:image forState:UIControlStateHighlighted];
    [collectImage addSubview:collectButton];
    [footerImageView addSubview:collectImage];
    [self.view addSubview:footerImageView];
    //分享按钮
    UIButton *shareButton=[UIButton buttonWithType:(UIButtonTypeCustom)];
    shareButton.frame=CGRectMake(0,0,25,25);
    [shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    UIImageView *shareImage=[ZCControl createImageViewFrame:CGRectMake(WIDTH-80,10,25,25) imageName:@"分享.png"];
    shareImage.userInteractionEnabled=YES;
    [shareImage addSubview:shareButton];
    [footerImageView addSubview:shareImage];
    [self.view addSubview:footerImageView];

    
}
-(void)collectButtonClick{
    
}
-(void)shareButtonClick{
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"507fcab25270157b37000010"
//                                      shareText:@"你要分享的文字"
//                                     shareImage:[UIImage imageNamed:@"icon.png"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQQ,nil]
//                                       delegate:self];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
}

-(void)createWebView{
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,44, WIDTH, HEIGHT-40)];
    //_urlstr=[NSString stringWithFormat:@"http://yl.cms.palmtrends.com/api_v2.php?action=article&id=%@&fontsize=m&uid=10288928&e=86587cf27fc31a81ad14c8663854ab94&platform=a&pid=10048",_appId];
   // NSLog(@"%@",_urlstr);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlstr]]];
    webView.scalesPageToFit=YES;
    [self.view addSubview:webView];
    
}
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
