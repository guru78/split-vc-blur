//
//  BTAMasterViewController.h
//  BlurTest
//
//  Created by Matthew Wymore on 9/17/13.
//  Copyright (c) 2013 Uncorked Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BTADetailViewController;

@interface BTAMasterViewController : UITableViewController

@property (strong, nonatomic) BTADetailViewController *detailViewController;

- (void) configureLandscapeTable;
- (void) configurePortraitTable;

@end
