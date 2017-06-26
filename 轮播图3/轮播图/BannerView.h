//
//  BannerView.h
//  轮播图
//
//  Created by 冰泪 on 2017/4/13.
//  Copyright © 2017年 冰泪. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AdJumpBlock)(NSString *typeId);
@interface BannerView : UIView<UIScrollViewDelegate>
-(instancetype)initWithCount:(NSInteger)count withImageArry:(NSArray *)imagArr jumpBlock:(AdJumpBlock)myBlock;

@property (nonatomic, copy) AdJumpBlock myBlock;
@end
