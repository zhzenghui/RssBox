//
//  DRRssViewController.m
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRRssViewController.h"

#import "ASIHTTPRequest.h"
#import "DRXmlToArr.h"
#import "DRMethodUtility.h"
#import "ContentViewContrller.h"
#import "GDataXMLNode.h"

#import "ItemInfo.h"
#import "DRUtility.h"

@implementation DRRssViewController

@synthesize rssRecord;

@synthesize itemRecords;
@synthesize rssLink;
@synthesize request;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    [request release];
    
    [rssRecord release];
    [itemRecords release];
    [rssLink release];
    
    [super dealloc];
}

#pragma mark -  ASIHTTPRequest

- (void)requestFinished:(ASIHTTPRequest *)request1
{
    NSData *responseData = [request1 responseData];
    NSString *xml = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Items:%@", xml);
    
    [xml release];
    
    
    [self.itemRecords setArray:[DRXmlToArr getElementToArr:responseData :@"item"]];
    
    
    ItemInfo *itemInfo = [[ItemInfo alloc] init];
    [itemInfo checkItemTable:@""];
    
    NSMutableArray *locationArr = [itemInfo getItemsPtitle:rssLink];
    
    if ([locationArr count] == 0) {
        
        
        for (NSMutableDictionary *rssDict in itemRecords) {
                       
            [rssDict setObject:@"0" forKey:@"issave"];            
            [rssDict setObject:rssLink forKey:@"ptitle"];
            [rssDict setObject:[DRMethodUtility getTodayDate] forKey:@"datetime"];
            [rssDict setObject:@"1" forKey:@"UserID"];        
            [itemInfo insertItem: rssDict];
        }
    }

    [itemInfo release];
    
    [self.tableView reloadData];
}

- (void)requestFailed:(ASIHTTPRequest *)request1
{
    NSError *error = [request1 error];
    
    
    NSLog(@"%@", error);
}




- (void)openUrl :(NSString *)subLink {
    
    
    
    NSURL *url = [NSURL URLWithString:subLink];
    request = [ASIHTTPRequest requestWithURL:url];
    [request retain];
    [request setTimeOutSeconds:60];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (IBAction)myButtonHandlerAction:(id)sender {
    
    if ( !  [request isCancelled]) {
        
        [request cancel];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
    
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(myButtonHandlerAction:)] autorelease];
    

    self.view.backgroundColor = RGBA(255, 241, 224, 1) ;
    self.title = [rssRecord objectForKey:@"title"];
    itemRecords = [[NSMutableArray alloc] init];
  
    ItemInfo *itemInfo = [[ItemInfo alloc] init];
    [itemInfo checkItemTable:@""];
    
    NSMutableArray *locationArr = [itemInfo getItemsPtitle:rssLink];
    
    if ([locationArr count] == 0) {
        
        [self openUrl:rssLink];
//        NSURL *url = [NSURL URLWithString:rssLink];
//        request = [ASIHTTPRequest requestWithURL:url];
//        [request setDelegate:self];
//        [request startAsynchronous];
        
    }
    else {
        NSMutableDictionary *dictItem = [locationArr objectAtIndex:[locationArr count]-1] ;
        
        
        if (! [[dictItem objectForKey:@"datetime"] isEqualToString:[DRMethodUtility getTodayDate]] && [[dictItem objectForKey:@"datetime"] isEqual:nil]){

            [self openUrl:rssLink];
//            NSURL *url = [NSURL URLWithString:rssLink];
//            request = [ASIHTTPRequest requestWithURL:url];
//            [request setDelegate:self];
//            [request startAsynchronous];
            
        }
        else {
            
            self.itemRecords = [NSMutableArray arrayWithArray:[itemInfo getItemsPtitle:rssLink]];
        }
    }
          

    [itemInfo release];
}

- (void)viewWillUnload {

    [super viewWillUnload];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    
    [super viewDidDisappear:animated];
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
    return [self.itemRecords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    



    if ([[[itemRecords objectAtIndex:indexPath.row] objectForKey:@"isHidden"] isEqualToString:@"1"]) {

        cell.textLabel.backgroundColor = [UIColor lightGrayColor];
    }
    else {
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    cell.textLabel.text = [[itemRecords objectAtIndex:indexPath.row] objectForKey:@"title"] ;

    cell.detailTextLabel.text = [[itemRecords objectAtIndex:indexPath.row]  objectForKey:@"description"];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
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
    

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableDictionary *dictItem = [itemRecords objectAtIndex:indexPath.row];

    ItemInfo *itemInfo = [[ItemInfo alloc] init];
    [dictItem setObject:@"1" forKey:@"isHidden"];            
    [itemInfo updateItem:dictItem];
    [itemInfo release];
 
    [[itemRecords objectAtIndex:indexPath.row] setObject:@"1" forKey:@"isHidden"];
    
    ContentViewContrller *detailViewController = [[ContentViewContrller alloc] init];
    detailViewController.workingEntry = [itemRecords objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0;
}

@end
