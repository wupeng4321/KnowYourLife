//
//  GYKCycleScrollView.m
//  GYKCycleScrollView
//
//  Created by gouyuankai on 15-4-2.
//  Copyright (c) 2015年 GYK. All rights reserved.
//

#import "GYKCycleScrollView.h"


@interface GYKCycleScrollView () <UIScrollViewDelegate>

// 主scrollView
@property (nonatomic ,weak) UIScrollView *cycleScrollView;

// 当前页码数
@property (nonatomic, assign) NSInteger currentPageIndex;

// 数据源imageURL
@property (nonatomic ,strong) NSMutableArray *imageUrls;

// 内容数据源imageURL
@property (nonatomic ,strong) NSMutableArray *contentImageUrls;

// 定时器
@property (nonatomic ,weak) NSTimer *time;

@end

@implementation GYKCycleScrollView

- (void)dealloc
{
    NSLog(@"时间销毁");
        [self.time invalidate];

}
- (NSMutableArray *)imageUrls
{
    if (_imageUrls == nil) {
        _imageUrls = [[NSMutableArray alloc] init];
    }
    return _imageUrls;
}
- (NSMutableArray *)contentImageUrls
{
    if (_contentImageUrls == nil) {
        _contentImageUrls = [[NSMutableArray alloc] init];
    }
    return _contentImageUrls;
}

// 初始化函数
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.cycleScrollView = scrollView;
        
   
        self.cycleScrollView.autoresizingMask = 0xFF;
        
        self.cycleScrollView.contentMode = UIViewContentModeCenter;
        
        //self.cycleScrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.cycleScrollView.frame), CGRectGetHeight(self.cycleScrollView.frame));
        self.cycleScrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.cycleScrollView.frame), 0);
        self.cycleScrollView.delegate = self;
        self.cycleScrollView.bounces = NO;
        self.cycleScrollView.showsHorizontalScrollIndicator = NO;
        self.cycleScrollView.pagingEnabled = YES;
        self.cycleScrollView.userInteractionEnabled = NO;
        //self.cycleScrollView.contentOffset = CGPointMake( CGRectGetWidth(self.cycleScrollView.frame), 0);
        [self addSubview:self.cycleScrollView];
        self.currentPageIndex = 0;
        
        // 初始化位置
        [self refreshLocation];
        
        // 添加三张imageview 用于复用
        [self addThreeImageView];
        
        // 创建page
        UIPageControl *page = [[UIPageControl alloc] init];
        [self addSubview:page];
        page.currentPageIndicatorTintColor = [UIColor colorWithRed:250/255.f green:78/255.f blue:70/255.f alpha:1];
        page.pageIndicatorTintColor = [UIColor whiteColor];
        page.alpha = 0.8;
        self.scrollPage = page;
    }
    return self;
}

// 创建三张imageView 用于滚动复用 占用内存小 当前和旁边的两张图片采用预加载
- (void)addThreeImageView
{
    for (UIView *view in self.cycleScrollView.subviews) {
        [view removeFromSuperview];
    }
    // 创建三张imageView 设置位置
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        CGFloat W = CGRectGetWidth(self.cycleScrollView.frame);
        CGFloat H = CGRectGetHeight(self.cycleScrollView.frame);
        imageView.frame = CGRectMake(i * W , 0, W, H);
        // 添加手势
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapAction:)];
        [imageView addGestureRecognizer:tapGesture];
        
        [self.cycleScrollView addSubview:imageView];

    }
}

// 设置数据源(默认是网上解析后的imageurl字符串数组)
- (void)setImageUrlNames:(NSArray *)ImageUrlNames
{
    for (NSString *name in ImageUrlNames) {
        [self.imageUrls addObject:name];
    }
    [self refreshContentImageUrls];
    [self refreshImageView];
    
    // 数据源设置page
    [self setupPage];
    
    // 加载数据完成 开始定时器
    [self startTimeWithDelay:4];
    
    self.cycleScrollView.userInteractionEnabled = YES;
}
// 初始化page
- (void)setupPage
{
    self.scrollPage.numberOfPages = self.imageUrls.count;
    CGFloat pageW = CGRectGetWidth(self.cycleScrollView.frame)/20*self.imageUrls.count;
    CGFloat pageH = 10;
    CGFloat pageX = CGRectGetWidth(self.cycleScrollView.frame)/2 - pageW/2;
    CGFloat pageY = CGRectGetMaxY(self.cycleScrollView.frame) - pageH - 5;
    self.scrollPage.frame = CGRectMake(pageX, pageY, pageW, pageH);
}

// 设置数据源 和 自动滚动时间
- (void)setImageUrlNames:(NSArray *)ImageUrlNames animationDuration:(NSTimeInterval)animationDuration
{
    // 创建定时器
    [self createTime:animationDuration];
    // 设置数据源
    [self setImageUrlNames:ImageUrlNames];
}
// 创建定时器
- (void)createTime:(NSTimeInterval)animationDuration
{
    self.time = [NSTimer scheduledTimerWithTimeInterval:animationDuration target:self selector:@selector(timing) userInfo:nil repeats:YES];
    self.time.fireDate = [NSDate distantFuture];
    [[NSRunLoop mainRunLoop] addTimer:self.time forMode:NSRunLoopCommonModes];
}
// 定时方法
- (void)timing
{
    CGPoint newOffset = CGPointMake(self.cycleScrollView.contentOffset.x + CGRectGetWidth(self.cycleScrollView.frame), self.cycleScrollView.contentOffset.y);
    [self.cycleScrollView setContentOffset:newOffset animated:YES];
}
// 暂停定时器
- (void)pauseTime
{
    if (self.time) {
        if ([self.time isValid]) {
            self.time.fireDate = [NSDate distantFuture];
        }
    }
}
// 开始定时器
- (void)startTime
{
    if (self.time) {
        if ([self.time isValid]) {
            self.time.fireDate = [NSDate distantPast];
        }
    }
}
// 一段时间后开始定时器
- (void)startTimeWithDelay:(NSTimeInterval)delay
{
    if (self.time) {
        if ([self.time isValid]) {
            self.time.fireDate = [NSDate dateWithTimeIntervalSinceNow:delay];
        }
    }
}

// 刷新所有
- (void)refresh
{
    if (self.contentImageUrls.count > 0) {
        [self refreshContentImageUrls];
        [self refreshImageView];
        [self refreshLocation];
        [self refreshPage];
    }
}
// 刷新page的当前页
- (void)refreshPage
{
    self.scrollPage.currentPage = self.currentPageIndex;
}
// 刷新内容数据源
- (void)refreshContentImageUrls
{
    int prePage = self.currentPageIndex - 1 >= 0 ? self.currentPageIndex - 1 : self.imageUrls.count - 1;
    int nextPage = self.currentPageIndex + 1 < self.imageUrls.count ? self.currentPageIndex + 1 : 0;
    
    [self.contentImageUrls removeAllObjects];
    [self.contentImageUrls addObject:self.imageUrls[prePage]];
    [self.contentImageUrls addObject:self.imageUrls[self.currentPageIndex]];
    [self.contentImageUrls addObject:self.imageUrls[nextPage]];
    
}
// 刷新imageView的图片 使用sdwebimage第三方加载图片
- (void)refreshImageView
{
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = self.cycleScrollView.subviews[i];
        NSString * name = self.contentImageUrls[i];
        imageView.image = [UIImage imageNamed:name];
        
    }
}
// 刷新位置
- (void)refreshLocation
{
    self.cycleScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.cycleScrollView.frame), 0);
}


#pragma mark - 监听scroll
// 滚动动画结束时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    [self startTimeWithDelay:3];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    //这个数字会随着时间变化
    //    发送通知
    
    
    [self pauseTime];
}
// 正在滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == 0) {
        self.currentPageIndex = self.currentPageIndex - 1 >= 0 ? self.currentPageIndex - 1 : self.imageUrls.count - 1;
        [self refresh];
        
    } else if (scrollView.contentOffset.x == 2 * CGRectGetWidth(self.cycleScrollView.frame)) {
        self.currentPageIndex = self.currentPageIndex + 1 < self.imageUrls.count ? self.currentPageIndex + 1 : 0;
        [self refresh];
    }
}

#pragma mark - 响应事件

// imageView的点击事件
- (void)imageViewTapAction:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:DidTapImageView:)]) {
        [self.delegate cycleScrollView:self DidTapImageView:self.currentPageIndex];
    }
}



@end
