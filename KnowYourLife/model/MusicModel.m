//
//  Video.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/13.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    //如果通过KVC方式取对象没有的属性则返回nil（默认是报异常程序崩溃）
    return nil;
}

@end
