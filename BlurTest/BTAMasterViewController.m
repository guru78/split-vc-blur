//
//  BTAMasterViewController.m
//  BlurTest
//
//  Created by Matthew Wymore on 9/17/13.
//  Copyright (c) 2013 Uncorked Studios. All rights reserved.
//

#import "BTAMasterViewController.h"

#import "BTADetailViewController.h"
#import "UIImage+ImageEffects.h"

@interface BTAMasterViewController ()
@property (nonatomic, strong) NSArray *objects;

//Cache the landscape background since this will not depend on view content that may change
//When in portrait, the detail view below this view controller may change so we dynamically generate a blurred background in those situations
@property (nonatomic, strong) UIImage *landscapeBackground;
@end

@implementation BTAMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.detailViewController = (BTADetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    self.objects = @[@"One", @"Two", @"Three", @"Four"];
    self.tableView.backgroundView = [[UIImageView alloc] init];
}

- (void) viewWillAppear:(BOOL)animated
{
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self configureLandscapeTable];
    }
    else
    {
        [self configurePortraitTable];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //If rotating to Landscape and the master controller is visible we need to call configureLandscapeTable to get the correct background showing
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        [self configureLandscapeTable];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Table Backgrounds

- (void) configureLandscapeTable
{
    if (!self.landscapeBackground)
    {
        self.landscapeBackground = [[UIImage imageNamed:@"doggyLeft.png"] applyDarkEffectWithTent:20];
    }
    
    //Can do a simple pointer compare since we cache the landscape background
    if ([(UIImageView *)self.tableView.backgroundView image] != self.landscapeBackground)
    {
        [(UIImageView *)self.tableView.backgroundView setImage:self.landscapeBackground];
    }
}

- (void) configurePortraitTable
{
    //set up the graphics context to render the screen snapshot. Note the scale value... Values greater than 1 make a context smaller than
    //the detail view controller. Smaller context means faster rendering of the final blurred background image
    const CGFloat scaleValue = 8;
    CGSize contextSize = CGSizeMake(self.detailViewController.view.frame.size.width / scaleValue , self.detailViewController.view.frame.size.height / scaleValue);
    UIGraphicsBeginImageContextWithOptions(contextSize, YES, 1);
    CGRect drawingRect = CGRectMake(0, 0, contextSize.width, contextSize.height);
    
    //Now grab the snapshot of the detail view controllers content
    [self.detailViewController.view drawViewHierarchyInRect:drawingRect afterScreenUpdates:NO];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Now get a sub-image of our snapshot. Just grab the portion of the shapshot that would be covered by the master view controller when it becomes visible.
    //Pulling out the sub-image means we can supply an appropriately sized background image for the master controller, and makes application of the blur
    //effect run faster since we are only only blurring image data that will actually be visible.
    CGRect subRect = CGRectMake(0, 0, self.view.frame.size.width / scaleValue, self.view.frame.size.height / scaleValue);
    CGImageRef subImage = CGImageCreateWithImageInRect(snapshotImage.CGImage, subRect);
    UIImage *backgroundImage = [UIImage imageWithCGImage:subImage];
    CGImageRelease(subImage);
    
    //Now actually apply the blur to the snapshot and set the background behind our master view controller
    UIImage *darkImage = [backgroundImage applyDarkEffectWithTent:5];
    [(UIImageView *)self.tableView.backgroundView setImage:darkImage];
}



@end
