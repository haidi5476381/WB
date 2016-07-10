//
//  DevicesViewController.m
//  WB
//
//  Created by 余海华 on 16/6/28.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "DevicesViewController.h"
#import "DeviceItemTableViewCell.h"

@interface DevicesViewController ()<UITableViewDelegate,UITableViewDataSource> {
    
    UITableView *smallTableView;
}

@end

@implementation DevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.automaticallyAdjustsScrollViewInsets=NO;
    _settingItemTitleArray = [NSArray arrayWithObjects:@"智能遥控器", @"智能插座",nil];
    _settingItemImageArray = [NSArray arrayWithObjects:@"device_btn_airconditioner_n",@"device_btn_airconditioner_n", nil];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add)];
    [self setSmallTableView];
}

-(void) setSmallTableView{
    
    smallTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60) style:UITableViewStylePlain];
    smallTableView.dataSource = self;
    smallTableView.delegate = self;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (tableView == smallTableView) {
        
        return 2.0f;
    }
    return 0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 30.0f;
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    if ([tableView isEqual:smallTableView]) {
    
        DeviceItemTableViewCell *deviceCell = [tableView dequeueReusableCellWithIdentifier:KDeviceItemTableViewCell];
        if (deviceCell == nil) {
            deviceCell = [DeviceItemTableViewCell deviceItemTableViewCell];
        }
        cell = deviceCell;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(void) add {
    
    [self.view addSubview:smallTableView];
    [smallTableView reloadData];
    
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
