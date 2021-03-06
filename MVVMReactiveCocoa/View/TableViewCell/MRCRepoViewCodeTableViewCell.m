//
//  MRCRepoViewCodeTableViewCell.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/1/22.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCRepoViewCodeTableViewCell.h"

@interface MRCRepoViewCodeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *wapperView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (strong, nonatomic) UIView *separatorViewTopBorder;

@end

@implementation MRCRepoViewCodeTableViewCell

- (void)awakeFromNib {
    self.viewCodeButton.tintColor = HexRGB(colorI3);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.wapperView.layer.borderColor  = HexRGB(colorB2).CGColor;
    self.wapperView.layer.borderWidth  = MRC_1PX_WIDTH;
    self.wapperView.layer.cornerRadius = 3;
    
    [self.separatorViewTopBorder removeFromSuperview];
    self.separatorViewTopBorder = [self.separatorView createViewBackedTopBorderWithHeight:MRC_1PX_WIDTH andColor:HexRGB(colorB2)];
    [self.separatorView addSubview:self.separatorViewTopBorder];
}

@end
