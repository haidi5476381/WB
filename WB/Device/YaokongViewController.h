//
//  YaokongViewController.h
//  WB
//
//  Created by 余海华 on 16/7/4.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "BaseViewController.h"

@interface YaokongViewController : BaseViewController
@property (nonatomic,assign) NSInteger tag;
- (IBAction)nextButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;

@property (weak, nonatomic) IBOutlet UIImageView *tipBigImageView;
@end
