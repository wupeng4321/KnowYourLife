//
//  TopNewsViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "TopNewsViewController.h"
#define url @"http://iphone.myzaker.com/zaker/blog.php?_appid=AndroidPhone&_bsize=1080_1920&_version=6.41&app_id=660"
@interface TopNewsViewController ()

@end

@implementation TopNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"top");
    self.navigationController.navigationBarHidden = NO;
    [self loadData:url];
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
