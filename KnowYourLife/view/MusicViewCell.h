//
//  MusicViewCell.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/12.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
@interface MusicViewCell : UITableViewCell

@property (nonatomic, strong) MusicModel *musicModel;

@property (nonatomic, strong) UIImageView *playStateIcon;

@end
