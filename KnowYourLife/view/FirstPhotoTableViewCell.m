//
//  FirstPhotoTableViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/11.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "FirstPhotoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ImgModel.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHTOFSCREEN [UIScreen mainScreen].bounds.size.height
@implementation FirstPhotoTableViewCell

- (void)awakeFromNib {
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
     
        [self makeUI];
    }
    return self;
}




-(void)makeUI{
    CGFloat HEIGHT = HEIGHTOFSCREEN-64;
    
     _firstImage   = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, WIDTH/3, HEIGHT/5-1)];
    _secondImage   = [[UIImageView alloc] initWithFrame:CGRectMake(1+WIDTH/3, 1, WIDTH*2/3-1, HEIGHT*2/5-1)];
    _thirdImage    = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1+HEIGHT/5, WIDTH/3, HEIGHT/5-1)];
    _fourthImage   = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1+HEIGHT*2/5, WIDTH/3-1, HEIGHT/5-1)];
    _fifthImage    = [[UIImageView alloc] initWithFrame:CGRectMake(1+WIDTH/3, 1+HEIGHT*2/5, WIDTH/3-1, HEIGHT/5-1)];
    _sixthImage    = [[UIImageView alloc] initWithFrame:CGRectMake(1+WIDTH*2/3, 1+HEIGHT*2/5, WIDTH/3-1, HEIGHT/5-1)];
    _seventhImage  = [[UIImageView alloc] initWithFrame:CGRectMake(1, HEIGHT*3/5+1, WIDTH*2/3-1, HEIGHT*2/5-1)];
    _eighthImage   = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*2/3+1, HEIGHT*3/5+1, WIDTH/3-1, HEIGHT/5-1)];
    _ninthImage    = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH*2/3+1, HEIGHT*4/5-1, WIDTH/3-1, HEIGHT/5-1)];
    
    _firstImage.userInteractionEnabled = YES;
    
    
    _firstImage.tag = 1;
    _secondImage.tag = 2;
    _thirdImage.tag = 3;
    _fourthImage.tag = 4;
    _fifthImage.tag = 5;
    _sixthImage.tag = 6;
    _seventhImage.tag = 7;
    _eighthImage.tag = 8;
    _ninthImage.tag = 9;
    

    [self.contentView addSubview:_firstImage];
    [self.contentView addSubview:_secondImage];
    [self.contentView addSubview:_thirdImage];
    [self.contentView addSubview:_fourthImage];
    [self.contentView addSubview:_fifthImage];
    [self.contentView addSubview:_sixthImage];
    [self.contentView addSubview:_seventhImage];
    [self.contentView addSubview:_eighthImage];
    [self.contentView addSubview:_ninthImage];
    
       
    _imageViewArr = [[NSMutableArray alloc] init];
    
    [_imageViewArr addObject:_firstImage];
    [_imageViewArr addObject:_secondImage];
    [_imageViewArr addObject:_thirdImage];
    [_imageViewArr addObject:_fourthImage];
    [_imageViewArr addObject:_fifthImage];
    [_imageViewArr addObject:_sixthImage];
    [_imageViewArr addObject:_seventhImage];
    [_imageViewArr addObject:_eighthImage];
    [_imageViewArr addObject:_ninthImage];
    
    _firstImage.backgroundColor = [UIColor redColor];
    
}

-(void)setImgGroupArr:(NSMutableArray *)imgGroupArr{
    
    _imgGroupArr = imgGroupArr;
    
    NSInteger j =_imgGroupArr.count;
    //NSLog(@"imgGroupArrCount=%lu",imgGroupArr.count);
    
    for (NSInteger i = 0; i<9; i++) {
        //获取最后九个model
        ImgModel * mm = _imgGroupArr[j-9+i];
        UIImageView * imageView = _imageViewArr[i];
        imageView.userInteractionEnabled = YES;
        imageView.tag = j-9+i;
        [imageView sd_setImageWithURL:[NSURL URLWithString:mm.imgsrc]];;
        //添加手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapToDetail:)];
        [imageView addGestureRecognizer:tap];
        
    }
    
}
-(void)TapToDetail:(UITapGestureRecognizer*)tap{
    
    UIImageView * imageView = (id)tap.view;
    //获取detail所在的model的value
    
    ImgModel * mm = _imgGroupArr[imageView.tag];
    //发送通知
    NSNotification * noti = [[NSNotification alloc] initWithName:@"ImageDetail" object:self userInfo:@{@"str":mm.imgUrl}];
    
    [[NSNotificationCenter defaultCenter] postNotification:noti];
    
}
















@end
