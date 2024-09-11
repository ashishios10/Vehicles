//
//  VehicleListTableViewCell.m
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

#import "VehicleListTableViewCell.h"
#import "Vehicles-Swift.h"

@interface VehicleListTableViewCell ()

@property (strong, nonatomic) UIImageView *vehicleImageView;
@property (strong, nonatomic) UILabel *vehicleId;
@property (strong, nonatomic) UILabel *waitTime;

@end

@implementation VehicleListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupImageView];
        [self setupTitleLabel];
        [self setupDescriptionLabel];
    }
    return self;
}

- (void)setupImageView {
    self.vehicleImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.vehicleImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.contentView addSubViewWithConstraintWithSubView:self.vehicleImageView left:20 top:16 width:60 height:60];
}

- (void)setupTitleLabel {
    self.vehicleId = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.vehicleId setFont:[UIFont boldSystemFontOfSize:17]];
    [self.vehicleId setContentMode:UIViewContentModeScaleAspectFit];
    self.vehicleId.translatesAutoresizingMaskIntoConstraints = false;
    [self.vehicleId setNumberOfLines:0];
    [self.vehicleId setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.vehicleId];
    
    [self.vehicleId.leadingAnchor constraintEqualToAnchor:self.vehicleImageView.trailingAnchor constant:20].active = YES;
    [self.vehicleId.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20].active = YES;
    [self.vehicleId.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16].active = YES;
    [self.vehicleId.heightAnchor constraintEqualToConstant:22].active = YES;
}

- (void)setupDescriptionLabel {
    self.waitTime = [[UILabel alloc]initWithFrame:CGRectZero];
    [self.waitTime setContentMode:UIViewContentModeScaleAspectFit];
    self.waitTime.translatesAutoresizingMaskIntoConstraints = false;
    [self.waitTime setNumberOfLines:0];
    [self.waitTime setLineBreakMode:NSLineBreakByWordWrapping];
    [self.contentView addSubview:self.waitTime];
    
    [self.waitTime.leadingAnchor constraintEqualToAnchor:self.vehicleImageView.trailingAnchor constant:20].active = YES;
    [self.waitTime.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-20].active = YES;
    [self.waitTime.topAnchor constraintEqualToAnchor:self.vehicleId.bottomAnchor constant:5].active = YES;
    [self.waitTime.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5].active = YES;
}

- (void)populateData:(VehicleModel *)vehicle {
    self.vehicleImageView.image = vehicle.vehicleImage;
    self.vehicleId.text = [NSString stringWithFormat:@"%@", vehicle.vehicleId];
    __weak typeof(self) weakSelf = self;
    [AsynchronousProvider runOnConcurrent:^{
        [VehicleDirection getTravelDistanceWithDestLat:vehicle.coordinate.latitude destLong:vehicle.coordinate.longitude completion:^(NSString * _Nonnull waitTime, NSError * _Nullable error) {
            if (!error) {
                [AsynchronousProvider runOnMain:^{
                    weakSelf.waitTime.text = [NSString stringWithFormat:@"%@ - %@", vehicle.type, waitTime];
                }];
            }
        }];
    }];
}

@end
