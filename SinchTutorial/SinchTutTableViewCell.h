//
//  SinchTutTableViewCell.h
//  SinchTutorial
//
//  Created by Jordan Morgan on 3/12/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SinchTutTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgUserProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblDistanceFromMe;
@end
