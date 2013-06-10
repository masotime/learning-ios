//
//  PineappleData.m
//  PineappleTarts
//
//  Created by Benjamin Goh on 9/6/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "PineappleData.h"

@interface PineappleData()
    @property (nonatomic, strong) NSMutableArray* latestDownloads;
@end

@implementation PineappleData

@synthesize latestDownloads = _latestDownloads;

- (NSArray*) latestDownloads {
    if (!_latestDownloads) _latestDownloads = [[NSMutableArray alloc] init];
    return _latestDownloads;
}

- (id)init {
    self = [super init];
    if (self) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bkt" ofType:@"json"];
        NSData* jsonData = [NSData dataWithContentsOfFile:filePath];
        NSError *requestError = NULL;
        self.latestDownloads = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&requestError];
        if (requestError){
            NSLog(@"Some shit happened: %@", requestError);
        }
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // return [NSString stringWithFormat:@"Section %d", section];
    return @"Bathroom and Kitchen Today";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"erm"];
    result.textLabel.text = [NSString stringWithFormat:@"Section %d Row %d", indexPath.section, indexPath.row];
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

@end