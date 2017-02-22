//
//  NewsModel.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
@property(nonatomic, copy) NSString *iconUrl;
@property(nonatomic, copy) NSString *titleLabel;
@property(nonatomic, copy) NSString *detailUrl;
@property(nonatomic, copy) NSString *media_count;

@end
