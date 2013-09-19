//
//  BTADetailViewController.m
//  BlurTest
//
//  Created by Matthew Wymore on 9/17/13.
//  Copyright (c) 2013 Uncorked Studios. All rights reserved.
//

#import "BTADetailViewController.h"
#import "BTAMasterViewController.h"

@interface BTADetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation BTADetailViewController

#pragma mark - Managing the detail item


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (UIPopoverController *) popover
{
    return self.masterPopoverController;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    NSLog(@"hide");
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"show");
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
