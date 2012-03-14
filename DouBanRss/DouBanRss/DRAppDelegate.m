//
//  DRAppDelegate.m
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRAppDelegate.h"

#import "DRHomeViewController.h"
#import "DRRssViewController.h"

#import "DRString.h"
#import "DRUtility.h"

@implementation DRAppDelegate

@synthesize window = _window;
@synthesize navigationController;
@synthesize tabBarController;

@synthesize splitViewController;
@synthesize popoverController;

- (void)dealloc
{
    [_window release];
    
    [tabBarController release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    

    
    
    DRHomeViewController *homeView = [[DRHomeViewController alloc] init];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        splitViewController = [[UISplitViewController alloc] init];
        
        DRRssViewController *rssView = [[DRRssViewController alloc] init];
        
        UINavigationController *nav1 = [[[UINavigationController alloc] initWithRootViewController:homeView] autorelease];
        UINavigationController *nav2 = [[[UINavigationController alloc] initWithRootViewController:rssView] autorelease];
        
        splitViewController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nil];
        
        [self.window addSubview:splitViewController.view];
    }
    else {
        

        navigationController = [[UINavigationController alloc] initWithRootViewController:homeView];
            self.navigationController.navigationBar.tintColor = RGBA(158, 47, 80, 1);
        [self.window addSubview:navigationController.view];
    }
    
    [homeView release];
       
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
