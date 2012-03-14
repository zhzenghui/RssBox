//
//  DRRecommendViewController.m
//  DouBanRss
//
//  Created by dong xin on 12-3-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRRecommendViewController.h"
#import "DRRssViewController.h"


#import "ASIHTTPRequest.h"
#import "DRXmlToArr.h"
#import "DRUtility.h"
#import "RssList.h"
#import "RssInfo.h"
#import "DRMethodUtility.h"

@implementation DRRecommendViewController
@synthesize rssRecord;
@synthesize rssRecords;
@synthesize request;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    
    [request clearDelegatesAndCancel];
    
    [rssRecord release];
    [rssRecords release];

    
    [super dealloc];
}


#pragma mark -  

- (IBAction)addSubScription:(id)sender {

    UITableViewCell* valueCell= (UITableViewCell*)[[sender superview] superview];
	UITableView* tableView  = (UITableView*)[valueCell superview];
	NSIndexPath* path = [tableView indexPathForCell:valueCell];
    
    RssInfo *rInfo = [[RssInfo alloc] init];

    UIButton *button = (UIButton *)sender;
    
    NSMutableDictionary *rssdict = [NSMutableDictionary dictionaryWithDictionary:[rssRecords objectAtIndex:path.row]];
   
    
    if (button.titleLabel.text  == @"+") {
        
        [button setBackgroundImage:[UIImage imageNamed:@"rss_delete.png"] forState:UIControlStateNormal];
        
        [button setTitle:@"-" forState:UIControlStateNormal];        
        
        NSMutableDictionary *dictRss = [NSMutableDictionary dictionaryWithDictionary:[rssRecords objectAtIndex:path.row]];

        [dictRss setObject:@"1" forKey:@"subscribe"];

        [rInfo updateRss:dictRss];            
        
        
    }
    else {
        
        NSMutableDictionary *dictRss = [NSMutableDictionary dictionaryWithDictionary:[rssRecords objectAtIndex:path.row]];

        [dictRss setObject:@"0" forKey:@"subscribe"];
        [rInfo updateRss:rssdict];
        [button setTitle:@"+" forState:UIControlStateNormal];
        
        [button setBackgroundImage:[UIImage imageNamed:@"rss_add.png"] forState:UIControlStateNormal];  
    }

    [rInfo release];
}


- (void)rssListArrToSqlite {
    
      
    RssList *rssList = [[RssList alloc] init];
    [rssList checkRssListTable:@""];
    
    for (NSMutableDictionary *rssDict in rssRecords) {
        
        [rssDict setObject:@"0" forKey:@"isget"];
        [rssDict setObject:[DRMethodUtility getTodayDate] forKey:@"datetime"];
        [rssDict setObject:@"1" forKey:@"UserID"];        
        [rssList insertRssList: rssDict];
    }
    
    [rssList release];
}


- (void)openUrl :(NSString *)subLink {

    
    
    NSURL *url = [NSURL URLWithString:subLink];
    request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:60];
    [request setDelegate:self];
    [request startAsynchronous];
    
}



#pragma mark -  ASIHTTPRequest

- (void)requestFinished:(ASIHTTPRequest *)request1
{
    // Use when fetching text data
//    NSString *responseString = [request responseString];    
//    NSLog(@"%@", responseString);
    
    
    
    // Use when fetching binary data
    NSData *responseData = [request1 responseData];
    
    if ( isRssInfo == NO) {
            
        NSMutableArray *rssListArr = [NSMutableArray arrayWithArray:[DRXmlToArr getAttributeToArr:responseData : @"outline"]];
        
        [self openUrl:[[rssListArr objectAtIndex:0] objectForKey:@"xmlUrl"]];

        isRssInfo = YES;
        
        [self rssListArrToSqlite];
        
    }
    else {
        
        self.rssRecords = [DRXmlToArr getAttributeToArr:responseData : @"outline"];
        
        [self.tableView reloadData];

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
        NSString *documentsDirectory = [paths objectAtIndex:0]; 
        NSString *dbPath = [[[NSString alloc] initWithFormat:@"%@/%@.xml", documentsDirectory, [rssRecord objectForKey:@"title"] ]autorelease];

        if ( ![[NSFileManager defaultManager] fileExistsAtPath:dbPath] ) {
            
            [[NSFileManager defaultManager] createFileAtPath:dbPath
                                                         contents:responseData
                                                       attributes:nil];
            
        }
        isRssInfo = NO;
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request1
{
    NSError *error = [request1 error];
    
    
    NSLog(@"%@", error);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"推荐";
    isRssInfo = NO;
    
    rssRecords = [[NSMutableArray alloc] init];
    rssRecord  = [[NSMutableDictionary alloc] init];

    self.view.backgroundColor = RGBA(255, 241, 224, 1) ;

    //推荐的访问
//    NSString *subLink = [NSString stringWithFormat:@"http://1.rssbox.sinaapp.com/rsslist.xml"];
//    
//    [self openUrl:subLink];
    
    
    //
    RssList *rssList = [[RssList alloc] init]; 
    
    NSMutableArray *arrayRlist = [NSMutableArray arrayWithArray:[rssList getRssLists]];
    
    if (! ([arrayRlist count]==0)) {
        
        [rssRecord setDictionary:[arrayRlist objectAtIndex:0]];
        
    }
    [rssList release];
    
    
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0]; 
    NSString *dbPath = [[[NSString alloc] initWithFormat:@"%@/%@.xml", documentsDirectory, [rssRecord objectForKey:@"title"] ]autorelease];

    if ( ![[NSFileManager defaultManager] fileExistsAtPath:dbPath] ) {
        
//        http://1.rssbox.sinaapp.com/rss1.xml
//        http://1.rssbox.sinaapp.com/rsslist.xml
        NSString *subLink = [NSString stringWithFormat:@"http://1.rssbox.sinaapp.com/rsslist.xml"];
    
        [self openUrl:subLink];
        
    }
    else {
        
                
        RssInfo *rInfo = [[RssInfo alloc] init];
        [rInfo checkRssTable:@""];
        
        NSMutableArray *rssInfo = [NSMutableArray arrayWithArray: [rInfo getRsss]];

        if ([rssInfo count] == 0) {


            NSData *data = [[NSMutableData alloc] initWithContentsOfFile:dbPath];

            self.rssRecords = [DRXmlToArr getAttributeToArr:data : @"outline"];
            [data release];

            
            for (NSMutableDictionary *dictRss in rssRecords) {
                    

                [rInfo insertRss:dictRss];
            }

        }
        else {
            
            self.rssRecords = rssInfo;
        }
    
        [rInfo release];
        
        
        [self.tableView reloadData];
    }

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.rssRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
        UIButton *subButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        subButton.frame =  CGRectMake(screenWidth *0.85, 15, 30, 30) ;

        subButton.tag = 1;
        [subButton addTarget:self action:@selector(addSubScription:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:subButton];
        
    }
    
    UIButton *subButton = (UIButton *)[cell.contentView viewWithTag:1];
        
    NSDictionary *item = [rssRecords objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item objectForKey:@"title"];
    cell.detailTextLabel.text = [item objectForKey:@"text"];
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rss_list_cell" ofType:@"png"];
    UIImage *theImage = [UIImage imageWithContentsOfFile:path];
    cell.imageView.image = theImage;
    
    
    
    if ([[item objectForKey:@"subscribe"] isEqualToString:@"1"]) {
        [subButton setTitle:@"-" forState:UIControlStateNormal];
        [subButton setBackgroundImage:[UIImage imageNamed:@"rss_delete.png"] forState:UIControlStateNormal];
    }
    else {
        [subButton setTitle:@"+" forState:UIControlStateNormal];        
        [subButton setBackgroundImage:[UIImage imageNamed:@"rss_add.png"] forState:UIControlStateNormal];        
    }

    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    DRRssViewController *detailViewController = [[DRRssViewController alloc] init];
    
    detailViewController.rssLink = [[rssRecords objectAtIndex:indexPath.row] objectForKey:@"xmlUrl"];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
}


@end
