//
//  GXCycleScrollView.h
//  GXCycleScrollView
//
//  Created by gaocaixin on 15-4-2.
//  Copyright (c) 2015年 GCX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYKCycleScrollView;

@protocol GYKCycleScrollViewDelegate <NSObject>

// 代理方法 通知代理方点击的下标
- (void)cycleScrollView:(GYKCycleScrollView *)cycleScrollView DidTapImageView:(NSInteger)index;

@end

@interface GYKCycleScrollView : UIView

/**
    只需要调用 初始化(initWithFrame) 和 设置一个scrollView的image的URL的字符串数组(setImageUrlNames) 便可使用

    用于大部分项目scrollView的自动滚动功能 
    采用预加载
    只用三张imageView 占用能存小
    代码易懂
 */

//本地图片


// 初始化
- (id)initWithFrame:(CGRect)frame;


// 数据源方法

// 设置数据源 没有自动滚动功能 不创建定时器
- (void)setImageUrlNames:(NSArray *)ImageUrlNames;


// 设置数据源 和 自动滚动时间 能够自动滚动
- (void)setImageUrlNames:(NSArray *)ImageUrlNames animationDuration:(NSTimeInterval)animationDuration;


// 内部使用的是系统默认的pageControll属性 如有需要 自行设置
@property (nonatomic ,weak) UIPageControl *scrollPage;

// 代理
@property (nonatomic ,weak) id <GYKCycleScrollViewDelegate> delegate;

@end
