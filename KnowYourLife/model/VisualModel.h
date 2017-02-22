//
//  VisualModel.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/14.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisualModel : NSObject


@property (nonatomic, strong) NSString *cover;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *mp4_url;
@property (nonatomic, strong) NSString *playersize;
@property (nonatomic, strong) NSString *ptime;
@property (nonatomic, strong) NSString *replyBoard;
@property (nonatomic, strong) NSString *replyid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *vid;
@property (nonatomic, strong) NSString *videosource;
@property (nonatomic, strong) NSString *imgsrc;
@property (nonatomic, strong) NSString *sid;

@property (nonatomic, assign) int playCount;
@property (nonatomic, assign) int replyCount;
@property (nonatomic, assign) int length;
@property (nonatomic, strong)NSArray *videoList;
@property (nonatomic, strong)NSArray *videoSidList;

+ (NSMutableArray *)pasringDataFromArray:(NSArray *)array;


@end
