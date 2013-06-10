//
//  PineappleViewController.m
//  PineappleTarts
//
//  Created by Benjamin Goh on 9/6/13.
//  Copyright (c) 2013 Benjamin Goh. All rights reserved.
//

#import "PineappleViewController.h"
#import "PineappleData.h"

@interface PineappleViewController ()

    @property (weak, nonatomic) IBOutlet UITableView *tableView;
    @property (strong, nonatomic) PineappleData *data;

@end

@implementation PineappleViewController

@synthesize data = _data;

- (PineappleData*) data {

    if (!_data) {
        _data = [[PineappleData alloc] init];
    }
    
    return _data;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self.data;
    self.tableView.dataSource = self.data;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
