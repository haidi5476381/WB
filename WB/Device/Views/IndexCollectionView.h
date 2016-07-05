//
//  IndexCollectionView.h
//  hehenianMobile
//
//  Created by 余海华 on 16/3/31.
//  Copyright © 2016年 huihu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexCollectionView : UICollectionView
/**
 *  是tableview的某一个collectionView
 */
@property (nonatomic,strong) NSIndexPath *index;
@end
