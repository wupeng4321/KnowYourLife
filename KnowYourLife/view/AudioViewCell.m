//
//  AudioViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/13.
//  Copyright © 2015年 wupeng. All rights reserved.//

#import "AudioViewCell.h"
#define API_AUDIOICON @"http://s.cimg.163.com/pi/img3.cache.netease.com/m/newsapp/topic_icons/%@.png.64x2147483647.75.auto.webp"
#import "UIImageView+WebCache.h"
#ifdef SD_WEBP
#import "UIImage+WebP.h"
#endif

@implementation AudioViewCell  {
    
    UIImageView *_iconImageView;
    UILabel *_nameLabel;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self generateUI];
    }
    return self;
}

- (void)generateUI {
    
//    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (self.contentView.height - 30) - 5, 30, 30)];
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    [_iconImageView setBackgroundColor:[UIColor greenColor]];
    
    [self.contentView addSubview:_iconImageView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 5, CGRectGetMinY(_iconImageView.frame), 50, CGRectGetHeight(_iconImageView.frame))];
    [_nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:_nameLabel];
    
}

- (void)setAudioModel:(AudioModel *)audioModel {
    
    _audioModel = audioModel;
    
    NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:API_AUDIOICON,audioModel.cid]];
    NSLog(@"%@",urlStr);
    [_iconImageView sd_setImageWithURL:urlStr placeholderImage:[UIImage imageNamed:@"contentview_image_default"] options:SDWebImageProgressiveDownload];
    _nameLabel.text = audioModel.cname;
    
}

@end
