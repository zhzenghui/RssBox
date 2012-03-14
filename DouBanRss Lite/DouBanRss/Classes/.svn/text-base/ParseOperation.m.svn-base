//
//  ItemInfo.h
//  DouBanRss
//
//  Created by dong xin on 12-2-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "ParseOperation.h"
#import "ItemInfo.h"

// string contants found in the RSS feed
static NSString *kTitleStr     = @"title";
static NSString *kLinkStr   = @"link";
static NSString *kDescriptionStr  = @"description";
static NSString *kContentStr = @"content:encoded";

static NSString *kCreatorStr  = @"dc:creator";
static NSString *kPubDateStr  = @"pubDate";
static NSString *kGuidStr  = @"guid";

static NSString *kItemStr  = @"item";


static NSString *language = @"language";
static NSString *copyright = @"copyright";


@interface ParseOperation ()
@property (nonatomic, assign) id <ParseOperationDelegate> delegate;
@property (nonatomic, retain) NSData *dataToParse;
@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) ItemInfo *workingEntry;
@property (nonatomic, retain) NSMutableString *workingPropertyString;
@property (nonatomic, retain) NSArray *elementsToParse;
@property (nonatomic, assign) BOOL storingCharacterData;
@end

@implementation ParseOperation

@synthesize delegate, dataToParse, workingArray, workingEntry, workingPropertyString, elementsToParse, storingCharacterData;

- (id)initWithData:(NSData *)data delegate:(id <ParseOperationDelegate>)theDelegate
{
    self = [super init];
    if (self != nil)
    {
        self.dataToParse = data;
        self.delegate = theDelegate;
        self.elementsToParse = [NSArray arrayWithObjects:kTitleStr, kLinkStr, kDescriptionStr, kContentStr, kCreatorStr, kPubDateStr, kGuidStr, nil];
    }
    return self;
}

// -------------------------------------------------------------------------------
//	dealloc:
// -------------------------------------------------------------------------------
- (void)dealloc
{
    [dataToParse release];
    [workingEntry release];
    [workingPropertyString release];
    [workingArray release];
    
    [super dealloc];
}

// -------------------------------------------------------------------------------
//	main:
//  Given data to parse, use NSXMLParser and process all the top paid apps.
// -------------------------------------------------------------------------------
- (void)main
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	self.workingArray = [NSMutableArray array];
    self.workingPropertyString = [NSMutableString string];
    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is not
	// desirable because it gives less control over the network, particularly in responding to
	// connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataToParse];
	[parser setDelegate:self];
    [parser parse];
	
	if (![self isCancelled])
    {
        // notify our AppDelegate that the parsing is complete
        [self.delegate didFinishParsing:self.workingArray];
    }
    
    self.workingArray = nil;
    self.workingPropertyString = nil;
    self.dataToParse = nil;
    
    [parser release];

	[pool release];
}


#pragma mark -
#pragma mark RSS processing

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
                                        namespaceURI:(NSString *)namespaceURI
                                       qualifiedName:(NSString *)qName
                                          attributes:(NSDictionary *)attributeDict
{
    // entry: { id (link), im:name (app name), im:image (variable height) }
    //
    if ([elementName isEqualToString:kItemStr])
	{
        self.workingEntry = [[[ItemInfo alloc] init] autorelease];
    }
    storingCharacterData = [elementsToParse containsObject:elementName];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
                                      namespaceURI:(NSString *)namespaceURI
                                     qualifiedName:(NSString *)qName
{

    if (self.workingEntry)
	{
        if (![elementName isEqualToString:kItemStr])
        {

            NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            [workingPropertyString setString:@""];  // clear the string for next time
            if ([elementName isEqualToString:kTitleStr])
            {
                self.workingEntry.title = trimmedString;
            }
            else if ([elementName isEqualToString:kLinkStr])
            {        
                self.workingEntry.link = trimmedString;
            }
            else if ([elementName isEqualToString:kDescriptionStr])
            {
                self.workingEntry.description = trimmedString;
            }
            else if ([elementName isEqualToString:kCreatorStr])
            {
                self.workingEntry.dc_creator = trimmedString;
            }
            else if ([elementName isEqualToString:kPubDateStr])
            {
                self.workingEntry.pubDate = trimmedString;
            }
            else if ([elementName isEqualToString:kGuidStr])
            {
                self.workingEntry.guid = trimmedString;
            }
        }
        else 
        {
            [self.workingArray addObject:self.workingEntry];  
            self.workingEntry = nil;
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingCharacterData)
    {
        [workingPropertyString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    [delegate parseErrorOccurred:parseError];
}

@end
