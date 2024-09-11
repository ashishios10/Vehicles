//
//  VehicleListDelegate.h
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

/**
 ## VehicleListDelegate
 
 This protocol is useful to provide communication between ViewModel to ViewController.
 
 */

#import <Foundation/Foundation.h>

@protocol VehicleListDelegate <NSObject>

- (void)showToast:(NSString *)message;
- (void)showLoader;
- (void)dismissLoader;
- (void)updateVehicleContent;

@optional
- (void)updateViewTitle:(NSString *)title;
@end

