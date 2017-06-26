//
//  ShufflingVC.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "ShufflingVC.h"
#import "BannerView.h"
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@interface ShufflingVC ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *bannerAry;
    UIScrollView *_scrollView;
    NSInteger curPage;
    NSInteger lastIndex;
    NSInteger nextIndex;
    NSMutableArray *dataSource0;
    NSMutableArray *dataSource1;
    NSMutableArray *dataSource2;
    
    UITableView *tableView0;
    UITableView *tableView1;
    UITableView *tableView2;
    
    NSInteger curTableViewTag;
}
@end

@implementation ShufflingVC
-(void)refreshDataSource{
    lastIndex = curPage-1;
    nextIndex = curPage+1;
    if (nextIndex >= bannerAry.count) {
        nextIndex = 0;
    }
    if (lastIndex < 0) {
        lastIndex = bannerAry.count - 1;
    }
    dataSource0 = bannerAry[lastIndex];
    dataSource1 = bannerAry[curPage];
    dataSource2 = bannerAry[nextIndex];
    [tableView0 reloadData];
    [tableView1 reloadData];
    [tableView2 reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ary1 = @[@"a",@"a",@"a",@"a",@"a",@"a"];
    NSArray *ary2 = @[@"b",@"b",@"b",@"b",@"b",@"b"];
    NSArray *ary3 = @[@"c",@"c",@"c",@"c",@"c",@"c"];
    NSArray *ary4 = @[@"d",@"d",@"d",@"d",@"d",@"d"];
    NSArray *ary5 = @[@"e",@"e",@"e",@"e",@"e",@"e"];
    NSArray *ary6 = @[@"f",@"f",@"f",@"f",@"f",@"f"];
    
    bannerAry = @[ary1,ary2,ary3,ary4,ary5,ary6];
    curPage = 0;
    dataSource0 = [[NSMutableArray alloc]init];
    dataSource1 = [[NSMutableArray alloc]init];
    dataSource2 = [[NSMutableArray alloc]init];
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, DeviceMaxWidth, 44)];
    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    
    
    UIView *bannerView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame), DeviceMaxWidth, 100)];
    bannerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bannerView];

    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bannerView.frame), DeviceMaxWidth, DeviceMaxHeight-CGRectGetMaxY(bannerView.frame))];
    bottomView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:bottomView];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth,bottomView.frame.size.height)];
    _scrollView.backgroundColor=[UIColor blueColor];
    //hight =0  （height<_scrollView.hight）就可以实现 只能左右翻页  不能上下翻页   水平方向也一样
    _scrollView.contentSize=CGSizeMake(_scrollView.bounds.size.width*3, 0);
    
    //设置图片偏移位置
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width,0) animated:NO];
    ////控制翻页  他滑动的是 滚动视图的宽度和高度  整页的翻动
    _scrollView.pagingEnabled=YES;
    _scrollView.delegate=self;
    //设置超出边界 反弹效果 默认为yes
    _scrollView.bounces=NO;
    _scrollView.showsHorizontalScrollIndicator=NO;
    [bottomView addSubview:_scrollView];
    
    
    tableView0 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DeviceMaxWidth, _scrollView.frame.size.height)];
    tableView0.delegate = self;
    tableView0.dataSource = self;
    [_scrollView addSubview:tableView0];
    tableView0.tag = 0;
    
    tableView1 = [[UITableView alloc]initWithFrame:CGRectMake(DeviceMaxWidth, 0, DeviceMaxWidth, _scrollView.frame.size.height)];
    tableView1.delegate = self;
    tableView1.dataSource = self;
    [_scrollView addSubview:tableView1];
    tableView1.tag = 1;
    
    tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(2*DeviceMaxWidth, 0, DeviceMaxWidth, _scrollView.frame.size.height)];
    tableView2.delegate = self;
    tableView2.dataSource = self;
    [_scrollView addSubview:tableView2];
    tableView2.tag = 2;
    [self refreshDataSource];

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"翻页");
    if(_scrollView.contentOffset.x>=_scrollView.bounds.size.width*2){
        //翻到最后一页时  跳转第一页
        if (curPage>=bannerAry.count-1) {
            curPage = 0;
        }else{
            curPage ++;
        }

    }else if(_scrollView.contentOffset.x<=0){
        //翻到第0页时  跳转最后一页
        if (curPage<=0) {
            curPage = bannerAry.count-1;
        }else{
            curPage--;
        }
    }
NSLog(@"11111----%ld",curPage);
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     [self refreshDataSource];
    //获取当前的页码
    [_scrollView setContentOffset:CGPointMake(_scrollView.bounds.size.width, 0) animated:NO];
    NSLog(@"%ld",curPage);
   
}
#pragma mark tableView代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag) {
        case 0:
        {//记录
            return dataSource0.count;
        }
            break;
        case 1:
        {//记录
            return dataSource1.count;
        }
            break;
        default:{
            return dataSource2.count;
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
    bgCell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255)/255.0 green:(arc4random() % 255)/255.0  blue:(arc4random() % 255)/255.0  alpha:1];
    bgCell.selectionStyle = UITableViewCellSelectionStyleNone;
    //标题cell

    switch (tableView.tag) {
        case 0:
        {//记录
            
            bgCell.textLabel.text = dataSource0[indexPath.row];
            return bgCell;
        }
            break;
        case 1:
        {//记录
            bgCell.textLabel.text = dataSource1[indexPath.row];
//            bgCell.backgroundColor = [UIColor redColor];
            return bgCell;
        }
            break;
        default:{
            bgCell.textLabel.text = dataSource2[indexPath.row];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
