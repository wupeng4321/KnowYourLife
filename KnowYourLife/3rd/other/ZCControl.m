//
//  ZCControl.m
//  ControlDemo
//
//  Created by 张诚 on 14/12/18.
//  Copyright (c) 2014年 zhangcheng. All rights reserved.
//

#import "ZCControl.h"

@implementation ZCControl
+(UIView*)createViewWithFrame:(CGRect)frame color:(UIColor*)color
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    if (color!=nil) {
        view.backgroundColor=color;
    }
    return view;
}
+(UILabel*)createLabelWithFrame:(CGRect)frame font:(float)font text:(NSString *)text
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    label.font=[UIFont systemFontOfSize:font];
    //设置折行方式
    label.lineBreakMode=NSLineBreakByCharWrapping;
    //设置折行行数
    label.numberOfLines=0;
    //设置文字
    label.text=text;
    //设置对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    return label;
}
+(UIButton*)createButtonWithFrame:(CGRect)frame title:(NSString*)title imageName:(NSString*)imageName bgImageName:(NSString*)bgImageName target:(id)target method:(SEL)select
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (imageName) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    if (bgImageName) {
        [button setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateNormal];
    }
    [button addTarget:target action:select forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    if (imageName) {
        imageView.image=[UIImage imageNamed:imageName];
    }
    imageView.userInteractionEnabled=YES;
    return imageView;
}
+(UITextField*)createTextFieldFrame:(CGRect)frame placeholder:(NSString*)placeholder bgImageName:(NSString*)imageName leftView:(UIView*)leftView rightView:(UIView*)rightView isPassWord:(BOOL)isPassWord
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    if (placeholder) {
        textField.placeholder=placeholder;
    }
    if (imageName) {
        textField.background=[UIImage imageNamed:imageName];
    }
    if (leftView) {
        textField.leftView=leftView;
        textField.leftViewMode=UITextFieldViewModeAlways;
    }
    if (rightView) {
        textField.rightView=rightView;
        textField.rightViewMode=UITextFieldViewModeAlways;
    }
    if (isPassWord) {
        textField.secureTextEntry=YES;
    }
    return textField;
}
@end







