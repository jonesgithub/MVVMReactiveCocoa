//
//  MRCUserDetailViewController.m
//  MVVMReactiveCocoa
//
//  Created by leichunfeng on 15/6/16.
//  Copyright (c) 2015年 leichunfeng. All rights reserved.
//

#import "MRCUserDetailViewController.h"
#import "MRCUserDetailViewModel.h"

@interface MRCUserDetailViewController ()

@property (strong, nonatomic, readonly) MRCUserDetailViewModel *viewModel;

@end

@implementation MRCUserDetailViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = YES;
    self.tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    @weakify(self)
    [[self.viewModel.requestRemoteDataCommand.executionSignals.flatten
        deliverOnMainThread]
        subscribeNext:^(id x) {
            @strongify(self)
            [self.tableView reloadData];
        }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y - 44);
    self.viewModel.avatarHeaderViewModel.contentOffset = contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 4;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"MRCTableViewCellStyleValue1" forIndexPath:indexPath];
    
	if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Person"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Follow";
            cell.accessoryType = self.viewModel.followingStatus ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Person"
                                                  backgroundColor:[UIColor clearColor]
                                                        iconColor:[UIColor lightGrayColor]
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Unfollow";
            cell.accessoryType = !self.viewModel.followingStatus ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
        }
    } else if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Person"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.viewModel.user.name;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Star"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(colorI3)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Starred Repos";
            cell.detailTextLabel.text = @(self.viewModel.user.publicGistCount).stringValue;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Organization"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x24AFFC)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Company";
            cell.detailTextLabel.text = self.viewModel.company;
        } else if (indexPath.row == 1) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Location"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x30C931)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Location";
            cell.detailTextLabel.text = self.viewModel.location;
        } else if (indexPath.row == 2) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Mail"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x5586ED)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Email";
            cell.detailTextLabel.text = self.viewModel.email;
        } else if (indexPath.row == 3) {
            cell.imageView.image = [UIImage octicon_imageWithIcon:@"Link"
                                                  backgroundColor:UIColor.clearColor
                                                        iconColor:HexRGB(0x90DD2F)
                                                        iconScale:1
                                                          andSize:MRC_LEFT_IMAGE_SIZE];
            cell.textLabel.text = @"Blog";
            cell.detailTextLabel.text = self.viewModel.blog;
        }
    }
    
    return cell;
}

@end