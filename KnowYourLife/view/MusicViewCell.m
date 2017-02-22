//
//  MusicViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/12.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "MusicViewCell.h"
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
#define FONTMAXSIZE 15.f
#define FONTMINSIZE 14.f

@implementation MusicViewCell {
    
    UILabel *_titleLbel;
    UILabel *_timeLabel;
    UIButton *_downloadBtn;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI {

    _playStateIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 25, 25)];
    [_playStateIcon setBackgroundColor:[UIColor clearColor]];
    [_playStateIcon setHidden:YES];
    [self.contentView addSubview:_playStateIcon];
    
    _titleLbel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_playStateIcon.frame) + 5, CGRectGetMinY(_playStateIcon.frame), WIDTH -60, CGRectGetHeight(_playStateIcon.frame))];
    [_titleLbel setBackgroundColor:[UIColor clearColor]];
    [_timeLabel setNumberOfLines:0];
    [_titleLbel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
    [self.contentView addSubview:_titleLbel];
    
    _downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_downloadBtn setFrame:CGRectMake(CGRectGetMaxX(_titleLbel.frame), CGRectGetMinY(_titleLbel.frame) + 5,CGRectGetWidth(_playStateIcon.frame) - 10,CGRectGetHeight(_titleLbel.frame) - 10)];
    [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"night_audionews_indexheader_download@2x.png"] forState:UIControlStateNormal];
    [_downloadBtn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_downloadBtn];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH - 150, CGRectGetMaxY(_downloadBtn.frame)+10, CGRectGetWidth(_playStateIcon.frame)*6, CGRectGetHeight(_downloadBtn.frame))];
    [_timeLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE]];
    [_timeLabel setTextColor:[UIColor darkGrayColor]];
    [_timeLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_timeLabel];
}

- (void)setMusicModel:(MusicModel *)musicModel {
    
    _musicModel = musicModel;
    
    _titleLbel.text = musicModel.title;
    _timeLabel.text = musicModel.ptime;
    if (_musicModel.isPlaying) {
        _playStateIcon.hidden = NO;
        [_playStateIcon setImage:[UIImage imageNamed:@"audionews_playlist_playing01@2x.png"]];
    }else{
        _playStateIcon.hidden = YES;
        
    }
    
}

- (void)sender:(UIButton *)btn {
    NSLog(@"1");
    
}

@end
