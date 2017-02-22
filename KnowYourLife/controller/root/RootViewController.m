//
//  RootViewController.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "RootViewController.h"
#import "News.h"
#import "AudioViewController.h"
#import "Video.h"
#import "Photo.h"
#import "Setting.h"

@interface RootViewController ()

@end
@implementation UIImage (originalImage)

+ (UIImage *)originalImageWithImageName:(NSString *)ImageName
{
    UIImage * image = [UIImage imageNamed:ImageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbarControllers];
    [self createTabbarItems];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(void)createTabbarControllers{
    News *newsVC = [[News alloc] init];
    AudioViewController * musicVC = [[AudioViewController alloc] init];
    Video *videoVC = [[Video alloc] init];
    Photo *photoVC = [[Photo alloc] init];
    Setting *settingVC = [[Setting alloc] init];
    
    newsVC.title = @"资讯";
    musicVC.title = @"音乐";
    videoVC.title = @"视频";
    photoVC.title = @"图片";
    settingVC.title = @"设置";
    
    
    UINavigationController *newsNC = [[UINavigationController alloc] initWithRootViewController:newsVC];
    UINavigationController *musicNC = [[UINavigationController alloc] initWithRootViewController:musicVC];
    UINavigationController *videoNC = [[UINavigationController alloc] initWithRootViewController:videoVC];
    UINavigationController *photoNC = [[UINavigationController alloc] initWithRootViewController:photoVC];
    UINavigationController * settingNC = [[UINavigationController alloc] initWithRootViewController:settingVC];
    
    self.viewControllers = @[newsNC,musicNC,videoNC,photoNC,settingNC];
    
}

-(void)createTabbarItems{
    self.tabBar.backgroundColor = [UIColor grayColor];
    NSArray *TabbarItemImage = @[@"tab_news_normal",@"tab_music_normal",@"tab_video_normal",@"tab_photo_normal", @"tab_setting_normal"];
    NSArray *SelectedTabbarItemImage = @[@"tab_news_press",@"tab_music_press",@"tab_video_press",@"tab_photo_press", @"tab_setting_press"];
    //NSArray *TabbarItemImage =@[@"tab_News",@"tab_Music",@"tab_Video",@"tab_Photo",@"tab_Setting"];
    //NSArray *SelectedTabbarItemImage =@[@"tab_News_press",@"tab_Music_press",@"tab_Video_press",@"tab_Photo_press",@"tab_Setting_press"];
    for (int i = 0; i < TabbarItemImage.count; i++) {
        UITabBarItem *item =self.tabBar.items[i];
        item.image = [UIImage imageNamed:TabbarItemImage[i]];
        item.selectedImage = [UIImage imageNamed:SelectedTabbarItemImage[i]];
       // item.image = [UIImage originalImageWithImageName:TabbarItemImage[i]];
       // item.selectedImage = [UIImage originalImageWithImageName:SelectedTabbarItemImage[i]];
    }
    
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
