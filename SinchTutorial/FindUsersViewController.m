//
//  FindUsersViewController.m
//  SinchTutorial
//
//  Created by Jordan Morgan on 3/9/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import "FindUsersViewController.h"
#import "SinchTutTableViewCell.h"
#import "User.h"
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>

@interface FindUsersViewController ()  <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MBProgressHUD *indicatorView;
@end

NSString * const CELL_ID = @"CELLID";

@implementation FindUsersViewController

#pragma mark - Lazy Loaded Properties
- (NSMutableArray *)users
{
    if(!_users)
    {
        _users = [NSMutableArray new];
    }
    
    return _users;
}

- (CLLocationManager *)locationManager
{
    if(!_locationManager)
    {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        _locationManager.distanceFilter = 1609; //One mile
        _locationManager.delegate = self;
    }
    
    return _locationManager;
}

- (MBProgressHUD *)indicatorView
{
    if(!_indicatorView)
    {
        _indicatorView = [[MBProgressHUD alloc] initWithView:self.view.window];
        _indicatorView.dimBackground = YES;
        _indicatorView.removeFromSuperViewOnHide = YES;
    }
    
    return _indicatorView;
}

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 44.0f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Request location
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - Tableview delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SinchTutTableViewCell *cell = (SinchTutTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CELL_ID];
    
    if (self.users.count > indexPath.row)
    {
        cell.lblUserName.text = [(User *)self.users[indexPath.row] userName];
        cell.lblDistanceFromMe.text = [(User *)self.users[indexPath.row] locationText];
    }
    
    return cell;
}

#pragma mark Data Retrieval
- (IBAction)refreshNearbyUsers:(id)sender
{
    //show activity view
    [self.view addSubview:self.indicatorView];
    [self.indicatorView showAnimated:YES whileExecutingBlock:^{
        //TODO:Refresh lgogic
        sleep(3);
    }completionBlock:^{
        self.indicatorView.hidden = YES;
    }];
    
}


#pragma mark - CLLocation Delegate
//Check to see if they denied location services
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Failure copter:\n\n%@", error.localizedDescription);
}

//Actual update of the location
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //Add a new user
    [self.tableView reloadData];
}
@end
