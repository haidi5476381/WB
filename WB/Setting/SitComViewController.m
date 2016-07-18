//
//  SitComViewController.m
//  WB
//
//  Created by 余海华 on 16/7/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "SitComViewController.h"
#import "PersonInfoTableViewCell.h"
#import "AddSitComViewController.h"
@interface SitComViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_sitComTableView;
    NSArray *_titleArray;
    NSArray *_imagesArray;
}

@end

@implementation SitComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"情景模式";
    self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithImageName:@"navibar_btn_plus" highImageName:@"navibar_btn_plus" target:self action:@selector(add)];
    _titleArray = [NSArray arrayWithObjects:@"休闲模式",@"回家模式", nil];
    _imagesArray = [NSArray arrayWithObjects:@"devicelist_icon_arder",@"devicelist_icon_homemode", nil];
    _sitComTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _sitComTableView.dataSource = self;
    _sitComTableView.delegate = self;
    [self.view addSubview:_sitComTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void) add {
    
    AddSitComViewController *addSitVc = [[AddSitComViewController alloc] initWithNibName:@"AddSitComViewController" bundle:nil];
    [self.navigationController pushViewController:addSitVc animated:YES];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 50.0f;
}



-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PersonInfoTableViewCell * personInfoCell = [tableView dequeueReusableCellWithIdentifier:KPersonInfoTableViewCell];
    if (personInfoCell == nil) {
        personInfoCell = [PersonInfoTableViewCell personInfoTableViewCell];
    }
    return personInfoCell;
}



-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PersonInfoTableViewCell * personCell = (PersonInfoTableViewCell *)cell;
    personCell.titleLabel.text =  [_titleArray objectAtIndex:indexPath.row];
    personCell.headImageView.image =[UIImage imageNamed:[_imagesArray objectAtIndex:indexPath.row]] ;
    personCell.subTitleLabel.hidden = YES;
    personCell.detailTextLabel.hidden = YES;
    personCell.touchIdSwitch.hidden = NO;
    
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
