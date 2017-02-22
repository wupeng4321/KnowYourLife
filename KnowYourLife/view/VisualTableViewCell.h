//
//  VisualTableViewCell.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/14.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisualModel.h"
@interface VisualTableViewCell : UITableViewCell
@property (nonatomic, strong) VisualModel *visualModel;

@property (nonatomic, strong) UIView *playerView;
@end
