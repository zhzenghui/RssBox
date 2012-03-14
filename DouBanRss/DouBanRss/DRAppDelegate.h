//
//  DRAppDelegate.h
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DRAppDelegate : UIResponder <UIApplicationDelegate> {

    UINavigationController *navigationController;
    UITabBarController *tabBarController;
    
    UISplitViewController  *splitViewController;
    UIPopoverController *popoverController; 
    UIBarButtonItem *rootPopoverButtonItem;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UITabBarController *tabBarController;


@property (nonatomic, retain) UISplitViewController  *splitViewController;
@property (nonatomic, retain) UIPopoverController *popoverController;

@end
