//
//  ViewController.m
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import "ViewController.h"
#import "ShufflingVC.h"
#import "LinkageVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
}
- (void)aaa{
    LinkageVC *vc = [[LinkageVC alloc]init];
    
    [self.navigationController  pushViewController:vc animated:YES];

}
- (IBAction)btn1:(UIButton *)sender {
    ShufflingVC *vc = [[ShufflingVC alloc]init];
    [self.navigationController  pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
