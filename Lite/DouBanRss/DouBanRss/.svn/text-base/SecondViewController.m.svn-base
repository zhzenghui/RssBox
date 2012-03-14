//
//  SecondViewController.m
//  Sample_TabBar_Nav
//
//  Created by daniel on 10-10-30.
//  Copyright 2010 http://desheng.me [desheng.young@gmail.com]. NO right reserved.
//

#import "SecondViewController.h"
#import "DRRssViewController.h"
#import "DRHomeViewController.h"
#import "DRLatestViewController.h"

@implementation SecondViewController

- (id)init {
  if (self = [super initWithNibName:nil bundle:nil]) {
    
    // TabBar1
    DRRssViewController *tab1 = [[[DRRssViewController alloc] init] autorelease];
    UINavigationController *tab1Nav = [[[UINavigationController alloc] init] autorelease];
    [tab1Nav pushViewController:tab1 animated:NO];
    tab1Nav.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"FirstTabBar" 
                                                        image:nil 
                                                          tag:0] autorelease];
    
    // TabBar2
    DRHomeViewController *tab2 = [[[DRHomeViewController alloc] init] autorelease];
    tab2.tabBarItem    = [[[UITabBarItem alloc] initWithTitle:@"SecondTabBar" 
                                                        image:nil 
                                                          tag:0] autorelease];
    
    // 组装TabBar
    self.viewControllers = [NSArray arrayWithObjects:tab1Nav, tab2, nil];
      
  }
  
  return self;
}

- (void)dealloc {
  [super dealloc];
}

@end
