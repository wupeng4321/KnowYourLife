//
//  Video.h
//  KnowYourLife
//
//  Created by wupeng on 16/04/14.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Video : UIViewController

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSString *urlString;

- (void)refreshData;

@end
