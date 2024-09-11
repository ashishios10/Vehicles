//
//  VehicleListViewController.m
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

#import "VehicleListViewController.h"
#import "VehicleListTableViewCell.h"
#import "Vehicles-Swift.h"

@interface VehicleListViewController () <VehicleTableViewAdapterDelegate>
@property (nonatomic, strong) VehicleListViewModel *viewModel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) VehicleTableViewAdapter *vehicleTableAdapter;

@end

@implementation VehicleListViewController

NSString *cellIdentifier = @"VehicleListCell";

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel];
    [self setupViewLayout];
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchNearbyTaxies];
}

#pragma mark - Layout setup

- (void)setupViewLayout {
    [self setupNavigationBar];
    [self setupTableView];
    [self setupRefreshController];
    [self fetchAddress];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubViewWithConstraintWithSubView:self.tableView left:0 top:0 right:0 bottom:0];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.vehicleTableAdapter = [[VehicleTableViewAdapter alloc]initWithTableView:self.tableView delegate:self];
}

- (void)setupViewModel {
    self.viewModel = [[VehicleListViewModel alloc]initWithDelegate:self vehiclesBoundary:[VehiclesInteractor new] reverseGeoBoundary:[ReverseGeocodingInteractor new]];
}

- (void)setupRefreshController {
    self.tableView.refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)setupNavigationBar {
    [[self navigationItem] setTitle:NSLocalizedString(@"vehicleList.searching", @"searcing")];
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:NSLocalizedString(@"vehicleList.map", @"map")
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(displayMapView)];
    self.navigationItem.rightBarButtonItem = flipButton;
}

#pragma mark - Custom actions

- (void)fetchNearbyTaxies {
    [self.viewModel getAllNearbyTaxies];
}

- (void)fetchAddress {
    [self.viewModel getUserAddress];
}

- (void)refreshTable {
    [self fetchNearbyTaxies];
    [self.tableView.refreshControl endRefreshing];
}

-(void)displayMapView {
    [self navigateToVehicleMap];
}

- (void)navigateToVehicleMap {
    [self.appCoordinator showMapViewController];
}


#pragma mark - VehicleListDelegate methods

- (void)updateVehicleContent {
    [self.vehicleTableAdapter setDataWithData:self.viewModel.vehicles];
}

- (void)updateViewTitle:(NSString *)title {
    self.navigationItem.title = title;
}

#pragma mark - VehicleTableViewAdapterDelegate methods

- (void)vehicleTableAdapter:(VehicleTableViewAdapter *)adapter didSelect:(id)item {
    
}

@end
