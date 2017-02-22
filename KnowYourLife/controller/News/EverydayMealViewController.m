//
//  EverydayMealViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "EverydayMealViewController.h"
#define  url @"http://iphone.myzaker.com/zaker/news.php?_appid=AndroidPhone&_bsize=1080_1920&_version=6.41&app_id=11012"

@interface EverydayMealViewController ()

@end

@implementation EverydayMealViewController

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
