//
//  FacebookManager.m
//  SinchTutorial
//
//  Created by Jordan Morgan on 3/12/15.
//  Copyright (c) 2015 Jordan Morgan. All rights reserved.
//

#import "FacebookManager.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookManager ()

@end

@implementation FacebookManager
+ (id)sharedManager
{
    static FacebookManager *sharedFacebookManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedFacebookManager = [self new];
    });
    return sharedFacebookManager;
}

- (instancetype)init
{
    self = [super self];
    
    if (self)
    {
        self.desiredUserPermissions = @[@"public_profile", @"email",@"user_location"];
    }
    
    return self;
}

- (void)cacheUserInfo:(id<FBGraphUser>)user
{
    [self saveUserName:user.name];
    
    NSDictionary *params = @{
                             @"redirect": @NO,
                             @"height": @200,
                             @"width": @200,
                             @"type": @"normal",
                             };
    
    /* make the API call */
    [FBRequestConnection startWithGraphPath:@"/me/picture" parameters:params HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error){
        
        if(!error)
        {
            NSDictionary *dict = (NSDictionary*)result;
            NSURL *url = [NSURL URLWithString:dict[@"data"][@"url"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            [self saveUserProfileImage:data];
        }
        
    }];
        
}

- (void)saveUserName:(NSString *)name
{
    //Save for later use so we don't have to make another request
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"Username"];
}

- (void)saveUserProfileImage:(NSData *)data
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"Userprofile"];
}

- (NSString *)getUserName
{
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"Username"];
    return name ? name : @"";
}

- (UIImage *)getUserProfileImage
{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"Userprofile"];
    return data ? [[UIImage alloc] initWithData:data] : [UIImage imageNamed:@"NoAvatar"];
}

- (void)flushData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Userprofile"];
}

@end
