//
//  ItemAddTableViewCell.m
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "ItemAddTableViewCell.h"
#import "ProductsCollectionViewCell.h"
#import "DefaultCollectionViewCell.h"

@implementation ItemAddTableViewCell
+(ItemAddTableViewCell *) itemAddTableViewCell{
    
    ItemAddTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:KItemAddTableViewCell owner:self options:nil] objectAtIndex:0];
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) setIndexCollectioViewDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>) delegate {
    
    
    UINib *nib = [UINib nibWithNibName:KProductsCollectionViewCell bundle:nil];;
    UINib *defaultNib = [UINib  nibWithNibName:KDefaultCollectionViewCell bundle:nil];
    [self.idnexCollectionView registerNib:nib forCellWithReuseIdentifier:KProductsCollectionViewCell];
    [self.idnexCollectionView registerNib:defaultNib forCellWithReuseIdentifier:KDefaultCollectionViewCell];
    
    self.idnexCollectionView.dataSource = delegate;
    self.idnexCollectionView.delegate = delegate;
    self.idnexCollectionView.backgroundColor = IWColor(255, 255, 255);
    self.idnexCollectionView.scrollEnabled = false;
    
    [self.idnexCollectionView reloadData];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
