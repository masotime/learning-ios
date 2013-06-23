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
    @property (nonatomic, weak) UIViewController* uiView;
@end

@implementation PineappleData


@synthesize publications = _publications;
@synthesize viewer = _viewer;
@synthesize uiView = _uiView;

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
    
    }
    return self;
}

- (void)setViewController:(UIViewController *)controller {
    self.uiView = controller;
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
    NSURL *url = [NSURL URLWithString:partUrl];
    
    NSLog(@"%@", partUrl);
    
    // we download the file first before displaying it (http://stackoverflow.com/a/5331675/302266)
    
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if (urlData) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"temp.pdf"];
        [urlData writeToFile:filePath atomically:YES];
        NSLog(@"Downloaded to %@", filePath);
        
        NSURL* fileURL = [NSURL fileURLWithPath:filePath];
        NSLog(@"fileURL = %@", fileURL);
        
        // create a PDFViewer and launch it modally
        PDFViewer* viewer = [[PDFViewer alloc] initWithMagazine:fileURL];
        viewer.dataSource = viewer;
        
        [self.uiView presentViewController:viewer animated:YES completion:NULL];
        
    }
    
    
}


@end