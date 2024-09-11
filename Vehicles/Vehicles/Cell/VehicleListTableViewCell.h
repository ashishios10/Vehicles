//
//  VehicleListTableViewCell.h
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//


/**
 ## VehicleListTableViewCell
 
 This class provides feature of custom cell to display date on UITableView.
 
 */

#import <UIKit/UIKit.h>
@class VehicleModel;

NS_ASSUME_NONNULL_BEGIN

@interface VehicleListTableViewCell: UITableViewCell
- (void)populateData:(VehicleModel *)vehicle;
@end

NS_ASSUME_NONNULL_END
