//
//  PineappleData.m
//  PineappleTarts
//
//  Created by Benjamin Goh on 9/6/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "PineappleData.h"
#import "PDFViewer.h"

@interface PineappleData()
    @property (nonatomic, strong) NSMutableArray* publications;
    @property (nonatomic, strong) PDFViewer* viewer;
@end

@implementation PineappleData


@synthesize publications = _publications;
@synthesize viewer = _viewer;

- (id)init {
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bkt" ofType:@"json"];
        NSData* jsonData = [NSData dataWithContentsOfFile:filePath];
        NSError *requestError = NULL;
        self.publications = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&requestError];
        if (requestError){
            NSLog(@"Some shit happened: %@", requestError);
        }
        
        // also init the viewer
        // PDFViewer* viewer = [[PDFViewer alloc] init];
    
    }
    return self;
}

- (NSDictionary*) getPublicationFor:(NSInteger)section {
    return [self.publications objectAtIndex:(int)section];
}

- (NSArray*) getIssuesFor:(NSInteger)section {
    return [[self getPublicationFor:section] objectForKey:@"issues"];
}

- (NSDictionary*) getIssueForSection:(NSInteger)section row:(NSInteger) row {
    NSArray* issues = [self getIssuesFor:section];
    return [issues objectAtIndex:row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.publications count];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    NSDictionary* publication = [self getPublicationFor:section];
    return [publication objectForKey:@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell* result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Nil];
    NSDictionary* issue = [self getIssueForSection:indexPath.section row:indexPath.row];
    
    result.textLabel.text = [NSString stringWithFormat:@"%@ Volume %@", [issue objectForKey:@"year"], [issue objectForKey:@"volume"]];
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self getIssuesFor:section] count];
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    NSDictionary* issue = [self getIssueForSection:indexPath.section row:indexPath.row];
    
    // just get the first part
    NSString* partUrl = [[issue objectForKey:@"parts"] objectAtIndex:0];
    
    // copy and paste from http://andycodes.tumblr.com/post/738375724/ios4-sdk-opening-pdfs-in-ibooks
    NSURL *url = [NSURL fileURLWithPath:partUrl];
    
    // this is really weird voodoo
    UIDocumentInteractionController* docController = [UIDocumentInteractionController interactionControllerWithURL:url];
    docController.delegate = self;
    
    BOOL isValid = [docController presentOpenInMenuFromRect:CGRectZero inView:self.view animated:YES];

    
    
    
}


@end