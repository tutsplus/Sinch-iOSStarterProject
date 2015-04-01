//
//  FacebookManager.h
//  SinchTutorial
//
//  Created by Jordan Morgan on 3/12/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookManager : NSObject
//Gets the permissions we are interested in from the user.
@property NSArray *desiredUserPermissions;
//Instance of the manager, follows the singleton pattern
+ (id)sharedManager;
- (void)cacheUserInfo:(id<FBGraphUser>)user;
- (NSString *)getUserName;
- (UIImage *)getUserProfileImage;
- (void)flushData;
@end
