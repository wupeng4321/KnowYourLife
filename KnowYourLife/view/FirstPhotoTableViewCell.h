//
//  FirstPhotoTableViewCell.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/11.
//  Copyright © 2015年 wupeng. All rights reserved.//

#import <UIKit/UIKit.h>
#import "ImgModel.h"

@interface FirstPhotoTableViewCell : UITableViewCell

@property (nonatomic, strong)   UIImageView *firstImage;
@property (nonatomic, strong)   UIImageView *secondImage;
@property (nonatomic, strong)   UIImageView *thirdImage;
@property (nonatomic, strong)   UIImageView *fourthImage;
@property (nonatomic, strong)   UIImageView *fifthImage;
@property (nonatomic, strong)   UIImageView *sixthImage;
@property (nonatomic, strong)   UIImageView *seventhImage;
@property (nonatomic, strong)   UIImageView *eighthImage;
@property (nonatomic, strong)   UIImageView *ninthImage;



@property (nonatomic, strong)ImgModel *imgModel;
@property (nonatomic, strong)NSMutableArray * imageViewArr;
@property (nonatomic, strong)NSMutableArray * imgGroupArr;

@end
