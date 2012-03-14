//
//  DRAppDelegate.h
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouMiView.h"

@interface DRAppDelegate : UIResponder <UIApplicationDelegate> {


    YouMiView *adView;
    
    UINavigationController *navigationController;
    UITabBarController *tabBarController;
    
    UISplitViewController  *splitViewController;
    UIPopoverController *popoverController; 
    UIBarButtonItem *rootPopoverButtonItem;
}

@property (nonatomic, retain) YouMiView *adView;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UITabBarController *tabBarController;


@property (nonatomic, retain) UISplitViewController  *splitViewController;
@property (nonatomic, retain) UIPopoverController *popoverController;

@end
