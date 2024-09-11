//
//  BaseViewController.h
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

/**
 ## BaseViewController
 
 This class is base view controller which provided common implementations.
 
 */

#import <UIKit/UIKit.h>
#import "VehicleListDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController: UIViewController <VehicleListDelegate>

@end

NS_ASSUME_NONNULL_END
