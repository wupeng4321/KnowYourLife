//
//  Video.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/13.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject


@property (nonatomic, copy)NSString*title;
@property (nonatomic, copy)NSString*ptime;
@property (nonatomic, copy)NSString*replyCount;
@property (nonatomic, copy)NSString*imgsrc;
@property (nonatomic, copy)NSString*source;
@property (nonatomic, copy)NSString*docid;

@property (nonatomic,assign) BOOL isPlaying;

@end
