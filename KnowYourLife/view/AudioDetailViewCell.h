//
//  AudioDetailViewCell.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/13.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioModel.h"

//@protocol turnPageBtnDelegate<NSObject>
//
//- (void)choseXXX;
//
//@end

@interface AudioDetailViewCell : UITableViewCell


@property (nonatomic, strong) AudioModel *audioModel;

//@property (nonatomic, weak) id <turnPageBtnDelegate> delegate;

@end
