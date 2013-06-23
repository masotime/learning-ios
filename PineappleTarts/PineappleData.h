//
//  PineappleData.h
//  PineappleTarts
//
//  Created by Benjamin Goh on 9/6/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PineappleData : UITableViewController

// section related
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

// row related
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

// just so that I have a pointer to the main view
- (void) setViewController:(UIViewController*) controller;

@end