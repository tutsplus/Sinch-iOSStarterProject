//
//  CallingViewController.m
//  SinchTutorial
//
//  Created by Jordan Morgan on 4/11/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import "CallingViewController.h"
#import "User.h"
#import "UIButton+Bootstrap.h"

@interface CallingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblCallWith;
@property (weak, nonatomic) IBOutlet UILabel *lblCallStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnAcceptOrCall;
@property (weak, nonatomic) IBOutlet UIButton *btnDeny;
@property (strong, nonatomic) AppDelegate *delegate;
@end

@implementation CallingViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //Set our button styles
    [self.btnAcceptOrCall successStyle];
    [self.btnDeny dangerStyle];
    
    //Set the Calling With label
    self.lblCallWith.text = [NSString stringWithFormat:@"%@ %@.", self.lblCallWith.text, self.selectedUser.userName];
}

#pragma mark - Initiate or Accept Call
- (IBAction)makeOrAccepetCallFromSelectedUser:(UIButton *)sender
{
    //TODO: Accept/Call logic
}

#pragma mark - Deny or Hang Up Call
- (IBAction)rejectOrHangUpCallFromSelectedUser:(UIButton *)sender
{
    //TODO: Reject/hangup logic
}

@end
