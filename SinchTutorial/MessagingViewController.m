//
//  MessagingViewController.m
//  SinchTutorial
//
//  Created by Jordan Morgan on 3/31/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import "MessagingViewController.h"
#import "UsersTableViewCell.h"
#import "RecipientTableViewCell.h"
#import "TextInsetLabel.h"

@interface MessagingViewController () <UITableViewDataSource, UITableViewDataSource, UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *messages;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMessage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messagingBottomConstraint;

@end

static NSString * CELL_ID_RECIPIENT = @"RecipientCell";
static NSString * CELL_ID_USER = @"UserCell";

@implementation MessagingViewController

#pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Tableview Setup
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 66.0f;
    
    //Textfield Setup
    [self textFieldSetup];
}

#pragma mark - Textfield Delegate & Helpers
- (void)textFieldSetup
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    CGRect keyboardFrameEnd = [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.messagingBottomConstraint.constant = keyboardFrameEnd.size.height - 48;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    //Scroll to bottom
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:19 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)note
{
    self.messagingBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
 
}

- (void)dismissKeyboard
{
    [self.messageTextField resignFirstResponder];
}

#pragma mark - Table View Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.messages.count;
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    
    return cell;
}

#pragma mark - Sending Message
- (IBAction)sendMessage:(id)sender
{
    [self dismissKeyboard];
}

@end
