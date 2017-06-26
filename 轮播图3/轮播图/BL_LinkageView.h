//
//  BL_LinkageView.h
//  轮播图
//
//  Created by 冰泪 on 2017/4/21.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BL_LinkageView : UIView<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIScrollView *contentScrolView;
@property (nonatomic, strong)UIPageControl *pageControl;

@property (nonatomic, strong)UIView *contentLeftView,*contentMiddleView,*contentRightView;//三个文本view

@property (nonatomic, strong)UIView *bannerLeftView,*bannerMiddleView,*bannerRightView; //文本view 上的banner图片

@property (nonatomic, strong)UITableView *tableViewLeft,*tableViewMiddle,*tableViewRight;//文本view 上的  tableView

@property (nonatomic, strong)NSArray *dataSource;//用来存放全部的数据
@property (nonatomic, strong)NSMutableArray *dataSourceLeft,*dataSourceMiddle,*dataSourceRight;//三个tableVIew对应的  数据源

- (void)initDataSource:(NSArray *)dataAry;
@property (nonatomic, strong) UILabel *label1,*label2,*label3;

@end
