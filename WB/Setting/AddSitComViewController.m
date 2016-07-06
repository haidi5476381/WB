//
//  AddSitComViewController.m
//  WB
//
//  Created by 余海华 on 16/7/6.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "AddSitComViewController.h"
#import "PersonInfoTableViewCell.h"

@interface AddSitComViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *_addSitComTableView;
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
    [self.view addSubview:_addSitComTableView];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        
        return 2;
    }else if(section == 2){
        
        return 3;
    }
    return 0;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        PersonInfoTableViewCell *personInfoCell = [tableView dequeueReusableCellWithIdentifier:KPersonInfoTableViewCell];
        if (personInfoCell == nil) {
            personInfoCell = [PersonInfoTableViewCell personInfoTableViewCell];
            cell = personInfoCell;
        }
    }else {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ss"];
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        
        PersonInfoTableViewCell *personCell = (PersonInfoTableViewCell *)cell;
        personCell.titleLabel.text = [_oneTitleArray objectAtIndex:indexPath.row];
        
    }
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
