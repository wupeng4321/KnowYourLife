//
//  VisualTypeModel.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/14.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VisualTypeModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString * imgsrc;
@property (nonatomic, strong) NSString * sid;
+ (NSMutableArray *)pasringDataFromArray:(NSArray *)array;

@end
