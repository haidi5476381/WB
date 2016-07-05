//
//  ItemAddTableViewCell.h
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexCollectionView.h"

static NSString *KItemAddTableViewCell = @"ItemAddTableViewCell";
@interface ItemAddTableViewCell : UITableViewCell

+(ItemAddTableViewCell *) itemAddTableViewCell;
@property (weak, nonatomic) IBOutlet IndexCollectionView *idnexCollectionView;
-(void) setIndexCollectioViewDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>) delegate;
@end
