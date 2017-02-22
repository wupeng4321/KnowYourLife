//
//  ZCControl.h
//  ControlDemo
//
//  Created by 张诚 on 14/12/18.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ZCControl : NSObject
+(UIView*)createViewWithFrame:(CGRect)frame color:(UIColor*)color;
+(UILabel*)createLabelWithFrame:(CGRect)frame font:(float)font text:(NSString*)text;
+(UIButton*)createButtonWithFrame:(CGRect)frame title:(NSString*)title imageName:(NSString*)imageName bgImageName:(NSString*)bgImageName target:(id)target method:(SEL)select;
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord;

@end
