//
//  ProductsCollectionViewCell.m
//  hehenianMobile
//
//  Created by 余海华 on 16/3/31.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import "ProductsCollectionViewCell.h"

@implementation ProductsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.itemLabel.textColor = IWColor(68, 68, 67);
    self.itemLabel.font = [UIFont systemFontOfSize:14];
    self.lineView.backgroundColor =  UIColorFromRGB(0xdcdcdc);//IWColor(220, 220, 220);
    self.bottomView.backgroundColor = UIColorFromRGB(0xdcdcdc);//IWColor(220, 220, 220);
    self.bottomView.hidden = YES;
    
}


@end
