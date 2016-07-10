//
//  AddSiteHeadView.m
//  WB
//
//  Created by 余海华 on 16/7/7.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "AddSiteHeadView.h"

@implementation AddSiteHeadView
+(AddSiteHeadView *) addSiteHeadView {
    
    AddSiteHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"AddSiteHeadView" owner:self options:nil] objectAtIndex:0];
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
