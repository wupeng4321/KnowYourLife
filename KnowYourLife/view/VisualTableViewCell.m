//
//  VisualTableViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/14.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "VisualTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
//#import "ButtonSize.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#define FONTMAXSIZE 15.f
#define FONTMINSIZE 14.f
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height
@interface VisualTableViewCell ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end


@implementation VisualTableViewCell{
    
    UIImageView *_bgImageView;
    UIImageView *_intervalImageView;
    UIButton *_playerBtn;
    UIImageView *_framesImageView;
    UIImageView *_timeImageView;
    UIImageView *_playerImageView;
    UILabel *_titleLabel;
    UILabel *_desLabel;
    UILabel *_timeLabel;
    UILabel *_hitsLabel;
    UIButton *_commentsBtn;
    UIButton *_shareBtn;
    //YC_UIHud *_hud;
}

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self configueUI];
        [self createPlayer];
    }
    
    return self;
}

- (void)configueUI {
    
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, WIDTH - 10, 280.f)];
    [_bgImageView setImage:[UIImage imageNamed:@"imageset_list_itemback_white@2x.png"]];
    [self.contentView addSubview:_bgImageView];
    
    _intervalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_bgImageView.frame) - 50, CGRectGetWidth(_bgImageView.frame) - 20, 2)];
    [_intervalImageView setImage:[UIImage imageNamed:@"contentview_topline"]];
    [_bgImageView addSubview:_intervalImageView];
    
    _framesImageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, CGRectGetWidth(_bgImageView.frame) - 4, 180)];
    [_framesImageView setBackgroundColor:[UIColor clearColor]];
    [_framesImageView setUserInteractionEnabled:YES];
    [_bgImageView addSubview:_framesImageView];
    
    _playerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playerBtn setCenter:CGPointMake(CGRectGetWidth(_framesImageView.frame) / 2.0 - 25, CGRectGetHeight(_framesImageView.frame) / 2.0 - 25)];
    [_playerBtn setWidth:50];
    [_playerBtn setHeight:50];
    [_playerBtn setBackgroundImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
    //_playerBtn.backgroundColor = [UIColor redColor];
    [_playerBtn.layer setCornerRadius:25];
    [_playerBtn addTarget:self action:@selector(videoPlayBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_framesImageView addSubview:_playerBtn];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_intervalImageView.frame), CGRectGetMaxY(_framesImageView.frame), CGRectGetWidth(_intervalImageView.frame),CGRectGetHeight(_framesImageView.frame)/6)];
    [_titleLabel setFont:[UIFont systemFontOfSize:FONTMAXSIZE]];
    [_bgImageView addSubview:_titleLabel];
    
    _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), CGRectGetHeight(_titleLabel.frame) - 2)];
    [_desLabel setTextColor:[UIColor darkGrayColor]];
    [_desLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE]];
    [_bgImageView addSubview:_desLabel];
    
    _timeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_intervalImageView.frame), CGRectGetMaxY(_intervalImageView.frame) + 7.5, 18, 18)];
    [_timeImageView setBackgroundColor:[UIColor clearColor]];
    [_timeImageView setImage:[UIImage imageNamed:@"video_list_cell_time"]];
    [_bgImageView addSubview:_timeImageView];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_timeImageView.frame) + 5, CGRectGetMinY(_timeImageView.frame), CGRectGetWidth(_intervalImageView.frame)/4 - 20, CGRectGetHeight(_timeImageView.frame))];
    _timeLabel.textColor = [UIColor darkGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:FONTMAXSIZE];
    [_timeLabel setBackgroundColor:[UIColor clearColor]];
    [_bgImageView setUserInteractionEnabled:YES];
    [_bgImageView addSubview:_timeLabel];
    
    _playerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_timeLabel.frame) + 10, CGRectGetMinY(_timeLabel.frame), CGRectGetWidth(_timeImageView.frame), CGRectGetHeight(_timeImageView.frame))];
    [_playerImageView setBackgroundColor:[UIColor clearColor]];
    [_playerImageView setImage:[UIImage imageNamed:@"video_list_cell_icon"]];
    [_bgImageView addSubview:_playerImageView];
    
    _hitsLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_playerImageView.frame) + 5, CGRectGetMinY(_playerImageView.frame), CGRectGetWidth(_timeLabel.frame), CGRectGetHeight(_timeImageView.frame))];
    [_hitsLabel setBackgroundColor:[UIColor clearColor]];
    [_hitsLabel setTextColor:[UIColor darkGrayColor]];
    [_hitsLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE]];
    [_bgImageView addSubview:_hitsLabel];
    
    _commentsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_commentsBtn setFrame:CGRectMake(CGRectGetMaxX(_hitsLabel.frame) + 40, CGRectGetMinY(_hitsLabel.frame), CGRectGetWidth(_hitsLabel.frame), CGRectGetHeight(_hitsLabel.frame))];
    [_commentsBtn.titleLabel setFont:[UIFont systemFontOfSize:FONTMINSIZE]];
    [_commentsBtn setBackgroundColor:[UIColor clearColor]];
    [_commentsBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_bgImageView addSubview:_commentsBtn];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setFrame:CGRectMake(CGRectGetMaxX(_commentsBtn.frame) + 10, CGRectGetMinY(_commentsBtn.frame), 20, 20)];
    [_shareBtn setBackgroundColor:[UIColor clearColor]];
    [_bgImageView addSubview:_shareBtn];
    
    _playerView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, CGRectGetWidth(_framesImageView.frame), CGRectGetHeight(_framesImageView.frame))];
    [_bgImageView addSubview:_playerView];
    [_playerView setBackgroundColor:[UIColor clearColor]];
    
}


- (void)setVisualModel:(VisualModel *)visualModel {
    
    
    _framesImageView.hidden = NO;
    _playerView.hidden = YES;
    
    _visualModel = visualModel;
    
    _titleLabel.text = visualModel.title;
    _desLabel.text = visualModel.description;
    [_framesImageView sd_setImageWithURL:[NSURL URLWithString:visualModel.cover] placeholderImage:[UIImage imageNamed:@"video_content_bg@2x.png"]];
    [_moviePlayer setContentURL:[NSURL URLWithString:visualModel.mp4_url]];
    [_commentsBtn setImage:[UIImage imageNamed:@"video_comment_pen@2x.png"] forState:UIControlStateNormal];
    NSString *str = [[NSNumber numberWithInteger:visualModel.replyCount] stringValue];
    [_commentsBtn setTitle:str forState:UIControlStateNormal];
    [_shareBtn setBackgroundImage:[UIImage imageNamed:@"video_category_share@2x.png"] forState:UIControlStateNormal];
    int minute = visualModel.length / 60;
    int second = visualModel.length % 60;
    _timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",minute,second];
    _hitsLabel.text = [[NSNumber numberWithInt:visualModel.playCount] stringValue];
    
}

- (void)createPlayer {
    
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    self.moviePlayer.view.frame = CGRectMake(0, 0,CGRectGetWidth(_playerView.frame), CGRectGetHeight(_playerView.frame));
    self.moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFit];
    [self.moviePlayer setFullscreen:YES animated:YES];
    [self.moviePlayer setShouldAutoplay:NO];
    [_playerView addSubview:self.moviePlayer.view];
    
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(movieStateChanged:) name :MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(movieFinishedCallback:) name :MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

- (void)movieStateChanged:(NSNotification *)notify {
    
    MPMoviePlayerController *theMovie = [notify  object];
    if (theMovie.playbackState == MPMoviePlaybackStateInterrupted) {
        [theMovie stop];
        _playerView.hidden = YES;
        _framesImageView.hidden = NO;
        //        [_hud hide:YES];
        //        _hud = nil;
       // [MBProgressHUD hideHUDForView:_playerView animated:YES];
    }
    if (theMovie.playbackState == MPMoviePlaybackStatePlaying) {
        //        [_hud hide:YES];
        //        _hud = nil;
       // [MBProgressHUD hideHUDForView:_playerView animated:YES];
    }
    
}

- (void)movieFinishedCallback:(NSNotification *)notify {
    
    MPMoviePlayerController * theMovie = [notify  object];
    [theMovie stop];
    _playerView.hidden = YES;
    _framesImageView.hidden = NO;
    
}
- (void)videoPlayBtn:(UIButton *)btnPressed {
    
    _playerView.hidden = NO;
    _framesImageView.hidden = YES;
    
    //    _hud = [_playerView showLoadingHud:@"正在加载..."];
   // [MBProgressHUD showHUDAddedTo:_playerView animated:YES];
    [_moviePlayer play];
    
}

- (void)dealloc{
    //从通知中心中移除通知的观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self];//移除观察者
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
