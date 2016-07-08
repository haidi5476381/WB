//
//  AddSitComViewController.m
//  WB
//
//  Created by 余海华 on 16/7/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "AddSitComViewController.h"
#import "PersonInfoTableViewCell.h"
#import "AddSiteHeadView.h"
#import "TermTableViewCell.h"
#import "TableViewFootView.h"
#import "ItemAddViewController.h"
#import "DQAlertView.h"

@interface AddSitComViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_addSitComTableView;
    UITableView *alertTableView;
    NSArray *_oneTitleArray;
}

@end

@implementation AddSitComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _oneTitleArray = [NSArray arrayWithObjects:@"名称",@"请选择情景图标", nil];
    _addSitComTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _addSitComTableView.dataSource = self;
    _addSitComTableView.delegate = self;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    TableViewFootView *tableViewFootView = [TableViewFootView tableViewFootView];
    [tableViewFootView.titleButton addTarget:self action:@selector(addSit) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:tableViewFootView];
    [tableViewFootView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(footView.mas_top).offset(10);
        make.leading.equalTo(footView.mas_leading);
        make.trailing.equalTo(footView.mas_trailing);
        make.bottom.equalTo(footView.mas_bottom);
    }];
    _addSitComTableView.tableFooterView = footView;
    [self.view addSubview:_addSitComTableView];
    // Do any additional setup after loading the view from its nib.
}

-(void) addSit {
    
    ItemAddViewController *itemAddVc = [[ItemAddViewController alloc] initWithNibName:@"ItemAddViewController" bundle:nil];
    [self.navigationController pushViewController:itemAddVc animated:YES];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([tableView isEqual:_addSitComTableView]) {
        return 3;
    }else if ([tableView isEqual:alertTableView]) {
        
        return 1;
    }
    return 0;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([tableView isEqual:_addSitComTableView]) {
        
        if (section == 0) {
            return 2;
        }else if (section == 1) {
            
            return 1;
        }else if(section == 2){
            
            return 2;
        }
    }else if ([tableView isEqual:alertTableView]) {
        
        return 4;
    }

    return 0;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = nil;
    if (section == 1 || section == 2) {
        
        AddSiteHeadView *addSiteHeadView = [AddSiteHeadView addSiteHeadView];
        addSiteHeadView.headerTitleLabel.text = @"执行条件";
        view = addSiteHeadView;
    }
    return view;
    
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ([tableView isEqual:_addSitComTableView]) {
       
        if (section == 0) {
            return 0.0f;
        }else if (section == 1 || section == 2) {
            
            return 40.0f;
        }
    }

    return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if ([tableView isEqual:_addSitComTableView]) {
        if (indexPath.section == 0) {
            PersonInfoTableViewCell *personInfoCell = [tableView dequeueReusableCellWithIdentifier:KPersonInfoTableViewCell];
            if (personInfoCell == nil) {
                personInfoCell = [PersonInfoTableViewCell personInfoTableViewCell];
                cell = personInfoCell;
            }
        }else if(indexPath.section == 1){
            
            
            TermTableViewCell *termTableViewCell = [tableView dequeueReusableCellWithIdentifier:KTermTableViewCell];
            if (termTableViewCell == nil) {
                termTableViewCell = [TermTableViewCell termTableViewCell];
                cell = termTableViewCell;
            }
        }else if (indexPath.section == 2) {
            
            PersonInfoTableViewCell *personInfoCell = [tableView dequeueReusableCellWithIdentifier:KPersonInfoTableViewCell];
            if (personInfoCell == nil) {
                personInfoCell = [PersonInfoTableViewCell personInfoTableViewCell];
                cell = personInfoCell;
            }
        }else {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ss"];
        }
    }else if ([tableView isEqual:alertTableView]) {
        
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ss"];
        
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ss"];
            cell.textLabel.text = @"测试";
        }
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:_addSitComTableView]) {
        
        if (indexPath.section == 0) {
            
            PersonInfoTableViewCell *personCell = (PersonInfoTableViewCell *)cell;
            personCell.titleLabel.text = [_oneTitleArray objectAtIndex:indexPath.row];
            
        }
    }
    
 
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DQAlertView * alertView = [[DQAlertView alloc] initWithTitle:@"执行动作" message:@"" cancelButtonTitle:@"Cancel" otherButtonTitle:@"OK"];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    contentView.backgroundColor = [UIColor yellowColor];
    if(alertTableView == nil) {
    alertTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 200, 300) style:UITableViewStylePlain];
    alertTableView.delegate = self;
    alertTableView.dataSource = self;
    alertView.contentView = alertTableView;
    }
    [alertView show];
    
    alertView.cancelButtonAction = ^{
        NSLog(@"Cancel Clicked");
    };
    
    alertView.otherButtonAction = ^{
        NSLog(@"OK Clicked");
    };

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
