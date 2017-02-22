//
//  NewsTableViewCell.m
//  KnowYourLife
//
//  Created by wupeng on 16/04/10.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI{
   
    _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 90, 80)];
    [self.contentView addSubview:_iconView];
    
   
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 70)];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview: _titleLabel];
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
