//
//  BaseViewController.m
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

#import "BaseViewController.h"

@import FTIndicator;

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - VehicleListDelegate methods
- (void)showLoader {
    [FTIndicator showProgressWithMessage:NSLocalizedString(@"vehicleList.loading", @"loading")];
}

- (void)dismissLoader {
    [FTIndicator dismissProgress];
}

- (void)showToast:(NSString *)message {
    [FTIndicator showToastMessage:message];
}

- (void)updateVehicleContent {
}

@end
