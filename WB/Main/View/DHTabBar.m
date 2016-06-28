//
//  DHTabBar.m
//  hehenianMobile
//
//  Created by huihu on 15/4/26.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import "DHTabBar.h"
#import "DHTabBarButton.h"
#import "CoreManager.h"
#import "HHNUtility.h"

@interface DHTabBar()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;

@property (nonatomic, weak) DHTabBarButton *selectedButton;

@end

@implementation DHTabBar

- (NSMutableArray *)tabBarButtons
{
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}
-(instancetype)init{
    if(self=[super init]){
         self.backgroundColor=[UIColor clearColor];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(itemSelected:) name:@"itemSelected" object:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        if (!iOS7) { // 非iOS7下,设置tabbar的背景
//            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
//        }        
    }
    return self;
}

-(void)itemSelected:(NSNotification *)notice{
    int index=(int)[notice.userInfo[@"index"] integerValue];
    //DHLog(@"index=%i",index);
    DHTabBarButton *btn=[self.tabBarButtons objectAtIndex:index];
    [btn sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    DHTabBarButton *button = [[DHTabBarButton alloc] init];
    [self addSubview:button];
    // 添加按钮到数组中
    [self.tabBarButtons addObject:button];
    
    // 2.设置数据
    button.item = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 4.默认选中第0个按钮
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(DHTabBarButton *)button
{
    // 去掉动画效果
//    button.transform =CGAffineTransformMakeScale(2, 2);
//    [UIView animateWithDuration:1.0
//                          delay:0.0
//         usingSpringWithDamping:0.4
//          initialSpringVelocity:0.5
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         button.transform =CGAffineTransformIdentity;
//                     }
//                     completion:nil];
    
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:(int)self.selectedButton.tag to:(int)button.tag];
    }
    
//    
//    if ([GetCoreI(IAuthQuery) getUserId].length<=0 &&((int)button.tag==1||(int)button.tag==2)) {
//        //选中“我的账户”、“更多”之前需要登录
//    }else{
        // 2.设置按钮的状态
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
//    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整加号按钮的位置
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.tabBarButtons.count; index++) {
        // 1.取出按钮
        DHTabBarButton *button = self.tabBarButtons[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;

        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);

        // 3.绑定tag
        button.tag = index;
        
        //DHLog(@"%.2f",buttonX);
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"itemSelected" object:nil];
}
@end
