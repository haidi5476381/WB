//
//  ItemAddViewController.m
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "ItemAddViewController.h"
#import "ItemAddTableViewCell.h"
#import "ProductsCollectionViewCell.h"

@interface ItemAddViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    
    UITableView *_iteemAddTableView;
    NSArray *_titleArray;
    NSArray *_imageArray;
    
}

@end

@implementation ItemAddViewController

-(void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = [NSArray arrayWithObjects:@"电视",@"空调",@"机顶盒", nil];
    _imageArray = [NSArray arrayWithObjects:@"device_btn_tv_n",@"devicelist_icon_airconditioner",@"device_btn_box_n", nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    
    self.title = @"添加";
    _iteemAddTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _iteemAddTableView.dataSource = self;
    _iteemAddTableView.delegate = self;
    [self.view addSubview:_iteemAddTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void) add {
    
    
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 110.0f*1;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
  
    ItemAddTableViewCell *itemTableViewCell = [tableView dequeueReusableCellWithIdentifier:KItemAddTableViewCell];
    if (itemTableViewCell == nil) {
        itemTableViewCell = [ItemAddTableViewCell itemAddTableViewCell];
        cell = itemTableViewCell;
    }
    return cell;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return  0.0;
}




-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}

-(CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(ScreenWidth / 3, 110.0f);
}


-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
     ProductsCollectionViewCell *productsCollectionViewCell = (ProductsCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:KProductsCollectionViewCell forIndexPath:indexPath];
    productsCollectionViewCell.itemImageView.image = [UIImage imageNamed:[_imageArray objectAtIndex:indexPath.row]];
    productsCollectionViewCell.itemLabel.text = [_titleArray objectAtIndex:indexPath.row];
    return productsCollectionViewCell;
}


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ItemAddTableViewCell *itemCell = (ItemAddTableViewCell *) cell;
    [itemCell setIndexCollectioViewDelegate:self];
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
