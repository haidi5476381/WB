//
//  TermTableViewCell.m
//  WB
//
//  Created by 余海华 on 16/7/7.
//  Copyright © 2016年 Haidi. All rights reserved.
//

#import "TermTableViewCell.h"

@implementation TermTableViewCell

+(TermTableViewCell *) termTableViewCell{
    
    TermTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:KTermTableViewCell owner:self options:nil] objectAtIndex:0];
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end