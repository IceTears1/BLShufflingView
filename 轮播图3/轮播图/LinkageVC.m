//
//  LinkageVC.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/21.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "LinkageVC.h"
#import "BL_LinkageView.h"
#define DeviceMaxHeight ([UIScreen mainScreen].bounds.size.height)
#define DeviceMaxWidth ([UIScreen mainScreen].bounds.size.width)
@interface LinkageVC ()
{
    NSArray *bannerAry;
}
@end

@implementation LinkageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *ary1 = @[@"a",@"a",@"a",@"a",@"a",@"a"];
    NSArray *ary2 = @[@"b",@"b",@"b",@"b",@"b",@"b"];
    NSArray *ary3 = @[@"c",@"c",@"c",@"c",@"c",@"c"];
    NSArray *ary4 = @[@"d",@"d",@"d",@"d",@"d",@"d"];
    NSArray *ary5 = @[@"e",@"e",@"e",@"e",@"e",@"e"];
    NSArray *ary6 = @[@"f",@"f",@"f",@"f",@"f",@"f"];
    
//    bannerAry = @[ary1,ary2,ary3,ary4,ary5,ary6];
    bannerAry = @[];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    BL_LinkageView *view = [[BL_LinkageView alloc]initWithFrame:CGRectMake(0, 64,DeviceMaxWidth , DeviceMaxHeight-64)];
    [self.view addSubview:view];
    [view initDataSource:bannerAry];
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
