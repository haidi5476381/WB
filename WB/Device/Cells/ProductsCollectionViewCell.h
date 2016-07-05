//
//  ProductsCollectionViewCell.h
//  hehenianMobile
//
//  Created by 余海华 on 16/3/31.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString* KProductsCollectionViewCell = @"ProductsCollectionViewCell";

@interface ProductsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
;
@end
