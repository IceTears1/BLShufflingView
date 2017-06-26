//
//  BL_LinkageView.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/21.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "BL_LinkageView.h"

#define bannerHight 150
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@implementation BL_LinkageView
{
    NSInteger curPageIndex;
    NSInteger lasPagetIndex;
    NSInteger nextPageIndex;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initScrollView];
    }
    return self;
}

-(void)initDataSource:(NSArray *)dataAry{
    curPageIndex = 0;
    lasPagetIndex = 0;
    nextPageIndex = 0;
    self.dataSource = dataAry;
    if (self.dataSource.count == 1) {
        self.contentScrolView.scrollEnabled = NO;
        self.pageControl.hidesForSinglePage = YES;
    }else if(self.dataSource.count == 0){
        self.contentScrolView.scrollEnabled = NO;
        self.pageControl.hidesForSinglePage = YES;
        return;
    }else{
        self.contentScrolView.scrollEnabled = YES;
        self.pageControl.hidesForSinglePage = NO;
    }
    [self refreshUI:curPageIndex];
}
- (void)refreshUI:(NSInteger) curIndex{
    lasPagetIndex = curIndex-1;
    nextPageIndex = curIndex+1;
    
    if (nextPageIndex > self.dataSource.count-1) {
        nextPageIndex = 0;
    }
    if (lasPagetIndex < 0) {
        lasPagetIndex = self.dataSource.count - 1;
    }
    NSLog(@"%ld---%ld ---%ld",lasPagetIndex,curPageIndex,nextPageIndex);
    
    self.pageControl.currentPage = curPageIndex;
    
    self.dataSourceLeft = self.dataSource[lasPagetIndex];
    self.dataSourceMiddle = self.dataSource[curPageIndex];
    self.dataSourceRight = self.dataSource[nextPageIndex];
    
    self.label1.text = [NSString stringWithFormat:@"%c",lasPagetIndex+97];
    self.label2.text = [NSString stringWithFormat:@"%c",curPageIndex+97];
    self.label3.text = [NSString stringWithFormat:@"%c",nextPageIndex+97];
    
    [self.tableViewLeft reloadData];
    [self.tableViewMiddle reloadData];
    [self.tableViewRight reloadData];
}

- (void)initScrollView{
    if (!_contentScrolView) {
        _contentScrolView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentScrolView.contentSize=CGSizeMake(_contentScrolView.bounds.size.width*3, 0);
        //设置图片偏移位置
        [_contentScrolView setContentOffset:CGPointMake(_contentScrolView.bounds.size.width,0) animated:NO];
        ////控制翻页  他滑动的是 滚动视图的宽度和高度  整页的翻动
        _contentScrolView.pagingEnabled=YES;
        _contentScrolView.delegate=self;
        //设置超出边界 反弹效果 默认为yes
        _contentScrolView.bounces=NO;
        _contentScrolView.showsHorizontalScrollIndicator=NO;
        [self addSubview:_contentScrolView];
    }
    self.contentLeftView.backgroundColor = [UIColor redColor];
    self.contentMiddleView.backgroundColor = [UIColor yellowColor];
    self.contentRightView.backgroundColor = [UIColor blueColor];
    
}
-(UILabel *)label1{
    if(!_label1){
        _label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bannerLeftView.frame.size.width, self.bannerLeftView.frame.size.height)];
        _label1.textColor = [UIColor blackColor];
        _label1.textAlignment = NSTextAlignmentCenter;
        [self.bannerLeftView addSubview:_label1];
    }
    
    return _label1;
}
-(UILabel *)label2{
    if(!_label2){
        _label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bannerLeftView.frame.size.width, self.bannerLeftView.frame.size.height)];

        _label2.textColor = [UIColor blackColor];
        _label2.textAlignment = NSTextAlignmentCenter;
        [self.bannerMiddleView addSubview:_label2];
    }
    
    return _label2;
    
}
-(UILabel *)label3{
    if(!_label3){
        _label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bannerLeftView.frame.size.width, self.bannerLeftView.frame.size.height)];
        _label3.textColor = [UIColor blackColor];
        _label3.textAlignment = NSTextAlignmentCenter;
        [self.bannerRightView addSubview:_label3];
    }
    
    return _label3;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.contentScrolView.contentOffset.x == scrollView.bounds.size.width*2){
        //翻到最后一页时  跳转第一页
        if (curPageIndex>=self.dataSource.count-1) {
            curPageIndex = 0;
        }else{
            curPageIndex ++;
        }
    }else if(self.contentScrolView.contentOffset.x==0){
        //翻到第0页时  跳转最后一页
        if (curPageIndex<=0) {
            curPageIndex = self.dataSource.count-1;
        }else{
            curPageIndex--;
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    [self refreshUI:curPageIndex];
    [self.contentScrolView setContentOffset:CGPointMake(scrollView.bounds.size.width, 0) animated:NO];
}
#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 0:
        {//记录
            return self.dataSourceLeft.count;
        }
            break;
        case 1:
        {//记录
            return self.dataSourceMiddle.count;
        }
            break;
        default:{
            return self.dataSourceRight.count;
        }
            break;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"BgCell";
    UITableViewCell *bgCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (bgCell == nil) {
        bgCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
//    bgCell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0  blue:(arc4random() % 255)/255.0  alpha:1];
    bgCell.selectionStyle = UITableViewCellSelectionStyleNone;
    bgCell.textLabel.textAlignment = NSTextAlignmentCenter;
    //标题cell
    
    switch (tableView.tag) {
        case 0:
        {//记录
            
            bgCell.textLabel.text = self.dataSourceLeft[indexPath.row];
            return bgCell;
        }
            break;
        case 1:
        {//记录
            bgCell.textLabel.text = self.dataSourceMiddle[indexPath.row];
            //            bgCell.backgroundColor = [UIColor redColor];
            return bgCell;
        }
            break;
        default:{
            bgCell.textLabel.text = self.dataSourceRight[indexPath.row];
            return bgCell;
        }
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {//记录
            return 50;
        }
            break;
        case 1:
        {//记录
            return 50;
        }
            break;
        default:{
            return 50;
        }
            break;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (tableView.tag) {
        case 0:
        {//记录
            
        }
            break;
        case 1:
        {//记录
            
        }
            break;
        default:{
            
        }
            break;
    }
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        //创建对象
        _pageControl =[[UIPageControl alloc]init];
        _pageControl.backgroundColor=[UIColor clearColor];
        //设置 颜色
        _pageControl.pageIndicatorTintColor=[UIColor grayColor];
        //设置当前选中的颜色
        _pageControl.currentPageIndicatorTintColor=[UIColor redColor];
        //设置页数
        _pageControl.numberOfPages=self.dataSource.count;
        _pageControl.userInteractionEnabled = YES;
        //设置居中
        CGSize pointSize = [_pageControl sizeForNumberOfPages:self.dataSource.count];
        CGFloat page_x =(DeviceMaxWidth/2 - pointSize.width/2);
        [_pageControl setFrame:CGRectMake(page_x,bannerHight-20, pointSize.width, 15)];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}


-(UIView *)contentLeftView{
    if (!_contentLeftView) {
        _contentLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentScrolView.frame), CGRectGetHeight(self.contentScrolView.frame))];
        [_contentScrolView addSubview:_contentLeftView];
    }
    
    return _contentLeftView;
}
-(UIView *)contentMiddleView{
    if (!_contentMiddleView) {
        _contentMiddleView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentLeftView.frame), 0, CGRectGetWidth(self.contentScrolView.frame), CGRectGetHeight(self.contentScrolView.frame))];
        [_contentScrolView addSubview:_contentMiddleView];
    }
    return _contentMiddleView;
}
-(UIView *)contentRightView{
    if (!_contentRightView) {
        _contentRightView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentMiddleView.frame), 0, CGRectGetWidth(self.contentScrolView.frame), CGRectGetHeight(self.contentScrolView.frame))];
        [_contentScrolView addSubview:_contentRightView];
    }
    return _contentRightView;
}
-(UIView *)bannerLeftView{
    if (!_bannerLeftView) {
        _bannerLeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentScrolView.frame), bannerHight)];
        [_contentLeftView addSubview:_bannerLeftView];
    }
    return _bannerLeftView;
}
-(UIView *)bannerMiddleView{
    if (!_bannerMiddleView) {
        _bannerMiddleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.contentScrolView.frame), bannerHight)];
        [_contentMiddleView addSubview:_bannerMiddleView];
        
    }
    return _bannerMiddleView;
}
-(UIView *)bannerRightView{
    if (!_bannerRightView) {
        _bannerRightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentScrolView.frame), bannerHight)];
        [_contentRightView addSubview:_bannerRightView];
        
    }
    return _bannerRightView;
}
-(NSMutableArray *)dataSourceLeft{
    if (!_dataSourceLeft) {
        _dataSourceLeft = [[NSMutableArray alloc]init];
    }
    return _dataSourceLeft;
}
-(NSMutableArray *)dataSourceMiddle
{
    if (!_dataSourceMiddle) {
        _dataSourceMiddle = [[NSMutableArray alloc]init];
    }
    return _dataSourceMiddle;
}
-(NSMutableArray *)dataSourceRight{
    if (!_dataSourceRight) {
        _dataSourceRight = [[NSMutableArray alloc]init];
    }
    return _dataSourceRight;
}
-(UITableView *)tableViewLeft{
    if (!_tableViewLeft) {
        _tableViewLeft = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerLeftView.frame), CGRectGetWidth(self.contentLeftView.frame), CGRectGetHeight(self.contentLeftView.frame)-CGRectGetMaxY(self.bannerLeftView.frame)) style:UITableViewStylePlain];
        _tableViewLeft.delegate = self;
        _tableViewLeft.dataSource = self;
        _tableViewLeft.tag = 0;
        [_contentLeftView addSubview:_tableViewLeft];
       
    }
    return _tableViewLeft;
}
-(UITableView *)tableViewMiddle{
    if (!_tableViewMiddle) {
        _tableViewMiddle = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerMiddleView.frame), CGRectGetWidth(self.contentMiddleView.frame), CGRectGetHeight(self.contentMiddleView.frame)-CGRectGetMaxY(self.bannerMiddleView.frame)) style:UITableViewStylePlain];
        _tableViewMiddle.delegate = self;
        _tableViewMiddle.dataSource = self;
        _tableViewMiddle.tag = 1;
        [_contentMiddleView addSubview:_tableViewMiddle];
    }
    return _tableViewMiddle;
}
-(UITableView *)tableViewRight{
    if (!_tableViewRight) {
        _tableViewRight = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bannerRightView.frame), CGRectGetWidth(self.contentRightView.frame), CGRectGetHeight(self.contentRightView.frame)-CGRectGetMaxY(self.bannerRightView.frame)) style:UITableViewStylePlain];
        _tableViewRight.delegate = self;
        _tableViewRight.dataSource = self;
        _tableViewRight.tag = 2;
        [_contentRightView addSubview:_tableViewRight];
    }
    return _tableViewRight;
}


@end
