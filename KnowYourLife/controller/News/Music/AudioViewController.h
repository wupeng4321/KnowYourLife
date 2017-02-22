//
//  AudioViewController.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/12.
//  Copyright © 2015年 wupeng. All rights reserved.
//
#import <UIKit/UIKit.h>

//@protocol AudioViewControllerDelegate <NSObject>

//- (void)showOOOWithVC:(UIViewController *)vc;

//@end

@interface AudioViewController : UIViewController

//@property (nonatomic, weak) id <AudioViewControllerDelegate> delegte;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSString *urlString;

- (void)refreshData;

@end
