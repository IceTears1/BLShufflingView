//
//  BannerView.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "BannerView.h"
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@implementation BannerView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    UIImageView *_imageView;
    NSMutableArray *_ary;
    NSTimer *_timer;
    UILabel *_label;
}
-(instancetype)initWithCount:(NSInteger)count withImageArry:(NSArray *)imagArr jumpBlock:(AdJumpBlock)myBlock{
    self.myBlock = myBlock;
    self=[super init];
    if(self)
    {
        _ary=[[NSMutableArray alloc]initWithArray:imagArr];
        if(_ary.count!=0){
            [NSThread detachNewThreadSelector:@selector(newThread) toTarget:self withObject:@""];
            
        }
    }
    return  self;
}
-(void)newThread
{
    [self createscrollView];
    
    
    [self performSelectorOnMainThread:@selector(refrehUI) withObject:@(0.1) waitUntilDone:YES];
}
-(void)refrehUI
{
    [self createTimer];
    [self createPageControl];
}

- (void)createTimer

{      _timer =[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerun) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate distantPast]];
}
- (void)timerun
{
    static int a=0;
    //NSLog(@"%f",_scrollView.contentOffset.x);
    if(a==0){
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width,0) animated:NO];
        a++;
    }else{
        
        if(_scrollView.contentOffset.x==_scrollView.bounds.size.width*(_ary.count+1)){
            
            [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO];
            
        }
        _pageControl.currentPage=_scrollView.contentOffset.x/_scrollView.bounds.size.width-1;
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width+_scrollView.contentOffset.x,0) animated:YES];
    }
    
}
- (void)createscrollView
{
    
    int a=(int )_ary.count;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, self.frame.size.height)];
    _scrollView.backgroundColor=[UIColor blueColor];
    //hight =0  （height<_scrollView.hight）就可以实现 只能左右翻页  不能上下翻页   水平方向也一样
    _scrollView.contentSize=CGSizeMake(_scrollView.bounds.size.width*(a+2), 0);

    //设置图片偏移位置
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width,0) animated:NO];
    ////控制翻页  他滑动的是 滚动视图的宽度和高度  整页的翻动
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    //设置超出边界 反弹效果 默认为yes
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:_scrollView];
    for (int i=0; i<(a+2); i++) {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
        _imageView.userInteractionEnabled=YES;
        _imageView .backgroundColor = [UIColor blueColor];
        
        NSString *ss=nil;
        if(i==0){
            ss=_ary.lastObject;
        }else if(i==(a+1)){
            ss=_ary[0];
            
        }else
        {
            ss=_ary[i-1];
        }
        
//        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height)];
//        [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
//        btn.tag=100+i;
//        btn.backgroundColor=[UIColor redColor];
//        [view1 addSubview:btn];
//        [btn setTitle:ss forState:UIControlStateNormal];
        
        _scrollView.userInteractionEnabled=YES;
        [_scrollView addSubview:_imageView];
    }
}
-(void)Click:(UIButton *)btn
{
    if (self.myBlock) {

        //调用block
        self.myBlock([NSString stringWithFormat:@"%ld",btn.tag-100]);
    }
}
-(void)createPageControl
{
    //创建对象
    _pageControl =[[UIPageControl alloc]initWithFrame:CGRectMake(0, 200,DeviceMaxWidth, 10)];
    //_pageControl.backgroundColor=[UIColor grayColor];
    //设置 颜色
    _pageControl.pageIndicatorTintColor=[UIColor grayColor];
    //设置当前选中的颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    
    //设置页数
    _pageControl.numberOfPages=_ary.count;
    
    //设置居中
    CGSize pointSize = [_pageControl sizeForNumberOfPages:_ary.count];
    // NSLog(@"%f",pointSize.width);
    //NSLog(@"%f",pointSize.height);
    CGFloat page_x =(DeviceMaxWidth/2 - pointSize.width/2);
    //NSLog(@"%f",page_x);
    [_pageControl setFrame:CGRectMake(page_x-30,200, pointSize.width, 10)];
    
    
    [self addSubview:_pageControl];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"翻页");
    if(_scrollView.contentOffset.x==_scrollView.bounds.size.width*(_ary.count+1)){
        //翻到最后一页时  跳转第一页
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO];
    }else if(_scrollView.contentOffset.x==0){
        //翻到第0页时  跳转最后一页
        [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width*_ary.count, 0) animated:NO];
    }
    //获取当前的页码
    _pageControl.currentPage=_scrollView.contentOffset.x/_scrollView.bounds.size.width-1;
}

@end
