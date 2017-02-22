//
//  AudioDetailViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/13.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "AudioDetailViewCell.h"
#import "UIImageView+WebCache.h"
#import "MusicViewController.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define FONTMAXSIZE 15.f
#define FONTMINSIZE 14.f


#define cellMargin 5.f
@implementation AudioDetailViewCell {
    UIImageView *_bgImageView;
    UIImageView *_picImageView;
    UIButton *_Button;
    UIButton *_playBtn;
    UILabel *_titleLabel;
    UILabel *_descLabel;
    NSMutableArray *_playBtnArr;
    NSMutableArray *_picArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_btnArray;
    NSMutableArray *_descArray;
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)createUI {
    _picArray = [NSMutableArray array];
    _titleArray = [NSMutableArray array];
    _btnArray = [NSMutableArray array];
    _descArray = [NSMutableArray array];
    _playBtnArr = [NSMutableArray array];
    float offset = 0;
    for (int i = 0; i < 3; i ++) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellMargin + offset, 5, WIDTH/3 - 6.5, WIDTH/3 - 6.5)];
        [_picImageView setBackgroundColor:[UIColor clearColor]];
        [_picImageView.layer setCornerRadius:(WIDTH/3 - 6.5)/2.0];
        [_picImageView setClipsToBounds:YES];
        [_picImageView setUserInteractionEnabled:YES];
        [self.contentView addSubview:_picImageView];
        
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setFrame:CGRectMake(CGRectGetWidth(_picImageView.frame)/2.0 - 20, CGRectGetHeight(_picImageView.frame)/2.0 - 20, 40, 40)];
        [_playBtn setBackgroundColor:[UIColor clearColor]];
        //_playBtn.backgroundColor = [UIColor redColor];
        
        [_playBtn setBackgroundImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
        
        [_playBtn addTarget:self action:@selector(playBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_picImageView addSubview:_playBtn];
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(cellMargin + offset, CGRectGetMaxY(_picImageView.frame), CGRectGetWidth(_picImageView.frame),70)];
        [_bgImageView setUserInteractionEnabled:YES];
        [self.contentView addSubview:_bgImageView];
        
        _Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Button setFrame:CGRectMake(0, 0, CGRectGetWidth(_bgImageView.frame), CGRectGetHeight(_bgImageView.frame))];
        [_Button setBackgroundColor:[UIColor clearColor]];
        [_bgImageView addSubview:_Button];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_picImageView.frame),30)];
        [_bgImageView addSubview:_titleLabel];
        [_titleLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE - 1.f]];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_picImageView.frame),40)];
        [_descLabel setBackgroundColor:[UIColor clearColor]];
        [_descLabel setNumberOfLines:0];
        [_descLabel setTextColor:[UIColor darkGrayColor]];
        [_descLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE - 1.f]];
        [_bgImageView addSubview:_descLabel];
        
        offset = CGRectGetMaxX(_picImageView.frame);
        
        [_playBtnArr addObject:_playBtn];
        [_picArray addObject:_picImageView];
        [_titleArray addObject:_titleLabel];
        [_descArray addObject:_descLabel];
        [_btnArray addObject:_Button];
    }
}

- (void)setAudioModel:(AudioModel *)audioModel {
    
    _audioModel = audioModel;
    
    for (int i = 0; i < 3; i ++) {
        [_picArray[i] sd_setImageWithURL:[NSURL URLWithString:audioModel.tList[i][@"radio"][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"contentview_image_default@2x.png"]];
        [_titleArray[i] setText:audioModel.tList[i][@"radio"][@"tname"]];
        [_descArray[i] setText:audioModel.tList[i][@"radio"][@"title"]];
    }
}
#pragma mark ---按钮点击方法---
- (void)playBtn:(UIButton *)btn {
    
    NSInteger index = [_playBtnArr indexOfObject:btn];
    
    NSNotification *indexNote = [[NSNotification alloc] initWithName:@"index" object:_audioModel.tList[index][@"tid"] userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:indexNote];
}
//- (void)playBtn:(UIButton *)btn {
//
//    NSInteger index = [_playBtnArr indexOfObject:btn];
//    
//    NSNotification *indexNote = [[NSNotification alloc] initWithName:@"index" object:self userInfo:@{@"str":_audioModel.tList[index][@"tid"]}];
//    
//    [[NSNotificationCenter defaultCenter]postNotification:indexNote];
//    
//
//}






@end
