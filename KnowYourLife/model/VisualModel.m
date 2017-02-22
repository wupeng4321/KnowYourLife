//
//  VisualModel.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/14.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "VisualModel.h"

@implementation VisualModel

@synthesize description;

+ (NSMutableArray *)pasringDataFromArray:(NSArray *)array {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        VisualModel *model = [[VisualModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dict];
        [dataArray addObject:model];
    }
    
    return dataArray;
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


@end
