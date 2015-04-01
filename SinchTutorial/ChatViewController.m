//
//  ChatViewController.m
//  SinchTutorial
//
//  Created by Jordan Morgan on 3/13/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import "ChatViewController.h"
#import "UserAvatar.h"
#import "UIButton+Bootstrap.h"

@interface ChatViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedUserName;
@property (weak, nonatomic) IBOutlet UserAvatar *imgUserProfile;
@property (weak, nonatomic) IBOutlet UserAvatar *imgSelectedUserProfile;

@end

@implementation ChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.btnCall primaryStyle];
    [self.btnMessage primaryStyle];

    self.lblUserName.text = [[FacebookManager sharedManager] getUserName];
    self.imgUserProfile.image = [[FacebookManager sharedManager] getUserProfileImage];
}

#pragma mark - Contact User
- (IBAction)startChat:(id)sender
{
    [self performSegueWithIdentifier:@"Messaging" sender:self];
}

- (IBAction)startCall:(id)sender
{
    
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
