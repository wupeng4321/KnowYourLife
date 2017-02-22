//
//  RootForNews.h
//  KnowYourLife
//
//  Created by wupeng on 15/04/10.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootForNews : UIViewController{
    UITableView *_tableView;
}
-(void)loadData:(NSString*)str;
@end
