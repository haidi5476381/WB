//
//  DHBadgeButton.m
//  hehenianMobile
//
//  Created by huihu on 15/4/26.
//  Copyright (c) 2015年 huihu. All rights reserved.
//

#import "DHBadgeButton.h"
#import "UIImage+MJ.h"
#import "NSString+extension.h"

@implementation DHBadgeButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    //    _badgeValue = badgeValue;
    _badgeValue = [badgeValue copy];
    
    if (badgeValue && [badgeValue intValue] != 0) {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
        // 设置frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            // 文字的尺寸
            CGSize badgeSize = [badgeValue sizeWithfont:self.titleLabel.font maxSize:CGSizeMake(MAXFLOAT, 15)];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
