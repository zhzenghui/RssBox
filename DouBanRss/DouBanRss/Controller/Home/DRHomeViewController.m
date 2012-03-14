//
//  DRHomeViewController.m
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DRHomeViewController.h"
#import "DRRssViewController.h"
#import "DRRecommendViewController.h"

#import "DRUtility.h"
#import "DRString.h"
#import "DRXmlToArr.h"
#import "DRMethodUtility.h"
#import "ASIHTTPRequest.h"
#import "RssList.h"
#import "RssInfo.h"
#import "DRGdataXmlToArr.h"


@implementation DRHomeViewController

@synthesize entryRss;
@synthesize entryRssRecords;
@synthesize settingRecords;
@synthesize request;
@synthesize imageDownloadsInProgress;

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
    [entryRssRecords release];
    [entryRss release];
    
    [super dealloc];
}




#pragma mark - 

- (void)openUrl :(NSString *)subLink {
    
    
    
    NSURL *url = [NSURL URLWithString:subLink];
    request = [ASIHTTPRequest requestWithURL:url];
    [request retain];
    [request setTimeOutSeconds:60];
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (IBAction)myButtonHandlerAction {
    
    if ( !  [request isCancelled]) {
        
        [request cancel];
    }
}


#pragma mark sina tx  douban  delegate 

#pragma mark -  UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch ( buttonIndex ) {
        case 0:
        {        
            
            break;
        }   
        case 1:
        {     


            break;
        }
        case 2:
        {      

            break;
        }
        default:
            break;
    }
}


- (IBAction)myButtonHandlerAction:(id)sender
{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"新浪", @"腾讯", @"豆瓣", nil];
//    
//    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)refresh{
    
    RssInfo *rInfo = [[RssInfo alloc] init];
    [rInfo checkRssTable:@""];
    
    self.entryRssRecords = [rInfo getRsssSub];
    
    [rInfo release];
    

    [self.tableView reloadData];
}

#pragma mark -  ASIHTTPRequest

- (void)requestFinished:(ASIHTTPRequest *)request1
{
    NSData *responseData = [request1 responseData];
    
    
    NSMutableArray *rssListArr = [NSMutableArray arrayWithArray:[DRXmlToArr getAttributeToArr:responseData : @"outline"]];


    
    RssList *rssList = [[RssList alloc] init];
    [rssList checkRssListTable:@""];
    
    NSMutableArray *locationArr = [rssList getRssLists];
    
    if (! [rssListArr count] == [locationArr count]) {
        

        [rssList checkRssListTable:@""];
        [rssList deleteRssList];
        
        for (NSMutableDictionary *rssDict in rssListArr) {
            
            [rssDict setObject:@"0" forKey:@"isget"];
            [rssDict setObject:[DRMethodUtility getTodayDate] forKey:@"datetime"];
            [rssDict setObject:@"1" forKey:@"UserID"];        
            [rssList insertRssList: rssDict];
        }
    }
    

    [rssList release];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request1
{
    NSError *error = [request1 error];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"网络错误" delegate:self
                                       cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
    
    [av show];

    [av release];
    NSLog(@"%@", error);
}


- (void)openRss {
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSString *documentsDirectory = [paths objectAtIndex:0]; 

    RssList *rlistInfo = [[RssList alloc] init];
    [rlistInfo checkRssListTable:@""];

    NSString *dbPath = [[[NSString alloc] initWithFormat:@"%@/%@.xml", documentsDirectory, [[[rlistInfo getRssLists] objectAtIndex:0] objectForKey:@"title"]] autorelease];
    [rlistInfo release];
    
    
    
    RssInfo *rInfo = [[RssInfo alloc] init];
    [rInfo checkRssTable:@""];
    
    NSMutableArray *rssInfo = [NSMutableArray arrayWithArray: [rInfo getRsss]];
    
    if ([rssInfo count] == 0) {
        
        
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:dbPath];
        
        self.entryRssRecords = [DRXmlToArr getAttributeToArr:data : @"outline"];
        [data release];
        
        
        for (NSMutableDictionary *dictRss in entryRssRecords) {
            
            
            [rInfo insertRss:dictRss];
        }
        
    }
    else {
        
        self.entryRssRecords = rssInfo;
    }
    
    [rInfo release];
    
}


- (void)copyXml {
    
    RssList *rInfo = [[RssList alloc] init];
    [rInfo checkRssListTable:@""];
  
    if ([[rInfo getRssLists] count] == 0) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:@"rss1" forKey:@"title"];
        [dict setObject:@"http://1.rssxml.sinaapp.com/rss1.xml" forKey:@"xmlurl"];        
        [dict setObject:@"0" forKey:@"isget"];
        [dict setObject:[DRMethodUtility getTodayDate] forKey:@"datetime"];
        [dict setObject:@"1" forKey:@"UserID"];   
        [rInfo insertRssList:dict];
        
        BOOL success;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"rss1.xml"];
        success = [fileManager fileExistsAtPath:writableDBPath];
        if (success) {   
            return;
        }
        // The writable database does not exist, so copy the default to the appropriate location.
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"greadersubscriptions.xml"];
        [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    }
    
    [rInfo release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];


//    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(myButtonHandlerAction:)] autorelease];
    
//    255 241 224
    self.view.backgroundColor = RGBA(255, 241, 224, 1);
    self.title = [NSString stringWithFormat:@"%@ %@", p_Name, p_version];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"" forKey:@""];
    
//    DefSaveRss, DefSetting, 
    
    entryRss = [[NSMutableDictionary alloc] init];
    settingRecords  = [[NSMutableArray alloc] initWithObjects:DefRecommend, nil];

    //
    [self copyXml];    

    
    [self openRss];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.request clearDelegatesAndCancel];
    self.request = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refresh];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if (section == 0) {
        return [settingRecords count];;
    }
    else {
        return [entryRssRecords count];        
    }
}


- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    ZYIDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        
        UILabel *editTimeTitleLab = (UILabel *)[cell.contentView viewWithTag:1001];
        
        // Display the newly loaded image
//        editTimeTitleLab .text = [[[dataArray objectAtIndex:1] objectAtIndex:indexPath.row] objectForKey:@"countNum"];
        //        cell.imageView.image = iconDownloader.appRecord.appIcon;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
    if (cell == nil) {
        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }

    
    if (indexPath.row == 0 && indexPath.section == 0) {

        
        cell.backgroundColor = [UIColor cyanColor];
        cell.textLabel.text = [settingRecords objectAtIndex:indexPath.row] ;
        cell.detailTextLabel.text = @"您可以把推荐的项目加入订阅列表";
    }
    else if (indexPath.section == 1) {
        
        NSDictionary *item = [entryRssRecords objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [item objectForKey:@"title"];
        cell.detailTextLabel.text = [item objectForKey:@"text"];
        
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
    
    [self myButtonHandlerAction];
    // Navigation logic may go here. Create and push another view controller.
    if (indexPath.section == 0) {
         
        switch ( indexPath.row ) {
            case 0:
            {
                DRRecommendViewController *recoViewController = [[DRRecommendViewController alloc] init];

                [self.navigationController pushViewController:recoViewController animated:YES];    
                [recoViewController release];  
                break;
            }
            case 1:
            {
                break;
            }
            case 2:
            {
                break;
            }   
            default:
                break;
        }
    }
    else {
        
        DRRssViewController *rssViewController = [[DRRssViewController alloc] init];
        rssViewController.rssRecord = [entryRssRecords objectAtIndex:indexPath.row];
        rssViewController.rssLink = [[entryRssRecords objectAtIndex:indexPath.row] objectForKey:@"xmlUrl"];
        [self.navigationController pushViewController:rssViewController animated:YES];    
        [rssViewController release];      
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20.0)] autorelease];
    headerView.backgroundColor = [UIColor underPageBackgroundColor];  //cyanColor
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 20.0)];
    headerLabel.backgroundColor = [UIColor clearColor];
    
    if (section == 0) {
        
        
        headerLabel.text = DefMyRss;
        [headerView addSubview:headerLabel];

    }
    else if (section == 1) {
        
        
        headerLabel.text = DefSubscriptions;        
        [headerView addSubview:headerLabel];
    }
    
    [headerLabel release];
    
    return headerView;
                            
}

@end
