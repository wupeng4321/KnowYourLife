//
//  TypeViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/14.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "TypeViewCell.h"
#import "UIImageView+WebCache.h"
#define IconMargin 20.f
#define MaxIconMargin 60.f
#define MaxIconMargin_4S 51.f
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define FONTMAXSIZE 15.f
@implementation TypeViewCell {
    
    UIImageView *_bgImageView;
    UIButton *_iconButton;
    UILabel *_titleLabel;
    NSMutableArray *_btnArray;
    NSMutableArray *_titleArray;
    
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}
- (void)configUI {
    _btnArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, WIDTH - 10, 70)];
    [_bgImageView setUserInteractionEnabled:YES];
    [_bgImageView setImage:[UIImage imageNamed:@"imageset_list_itemback_white@2x.png"]];
    //_bgImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_bgImageView];
    float btnOffset = 0;
    float labelOffset = 0;
    for (int i = 0; i < 4; i ++) {
        
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconButton setFrame:CGRectMake(IconMargin + btnOffset, 10, CGRectGetWidth(_bgImageView.frame) / 8 - 10, CGRectGetWidth(_bgImageView.frame) / 8 - 10)];
        [_iconButton addTarget:self action:@selector(btnSender:) forControlEvents:UIControlEventTouchUpInside];
        [_iconButton setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:_iconButton];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(IconMargin + labelOffset, CGRectGetMaxY(_iconButton.frame), CGRectGetWidth(_bgImageView.frame) / 8 - 10, 20)];
        [_titleLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE - 1.f]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:_titleLabel];
        [_btnArray addObject:_iconButton];
        [_titleArray addObject:_titleLabel];
        if (i >= 1) {
            if (WIDTH == 320) {
                [_iconButton setFrame:CGRectMake(MaxIconMargin_4S + btnOffset, 10, CGRectGetWidth(_bgImageView.frame) / 8 - 10, CGRectGetWidth(_bgImageView.frame) / 8 - 10)];
            }else {
                [_iconButton setFrame:CGRectMake(MaxIconMargin + btnOffset, 10, CGRectGetWidth(_bgImageView.frame) / 8 - 10, CGRectGetWidth(_bgImageView.frame) / 8 - 10)];
            }
            
        }
        if (i >= 0) {
            if (WIDTH == 320) {
                _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MaxIconMargin_4S + labelOffset, CGRectGetMaxY(_iconButton.frame), CGRectGetWidth(_bgImageView.frame) / 8 - 10, 20)];
            }else {
                _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(MaxIconMargin + labelOffset, CGRectGetMaxY(_iconButton.frame), CGRectGetWidth(_bgImageView.frame) / 8 - 10, 20)];
            }
            
        }
        btnOffset = CGRectGetMaxX(_iconButton.frame);
        labelOffset = CGRectGetMaxX(_titleLabel.frame);
    }
}

- (void)setPicsArr:(NSArray *)picsArr {
    
    _picsArr = [picsArr mutableCopy];
    
    for (int i = 0; i < 4; i ++) {
        VisualModel *model = _picsArr[i];
        UIButton * button = _btnArray[i];
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        //[button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imgsrc] forState:UIControlStateNormal];
        
        //[_btnArray[i] sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] forState:UIControlStateNormal];
        [button setBackgroundImage:imageView.image forState:UIControlStateNormal];
        
        [_titleArray[i] setText:model.title];
    }
}

- (void)btnSender:(UIButton *)btn {
    
    NSInteger index = [_btnArray indexOfObject:btn];
    NSLog(@"%ld",index);
    
}

@end
