//
//  WYBeautyViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "WYBeautyViewController.h"
//#define url @"http://iphone.myzaker.com/zaker/news.php?_appid=AndroidPhone&_bsize=1080_1920&_version=6.41&app_id=12040"
#define url @"http://iphone.myzaker.com/zaker/blog.php?_appid=AndroidPhone&_bsize=1080_1920&_version=6.41&app_id=723"
#define url1 @"http://iphone.myzaker.com/zaker/blog2news.php?_appid=androidphone&_bsize=1080_1920&_version=6.45&app_id=1289&nt=1&since_date=1450272269"
@interface WYBeautyViewController ()

@end

@implementation WYBeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData:url];
    self.navigationController.navigationBarHidden = NO;

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
