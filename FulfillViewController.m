//
//  FulfillViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "FulfillViewController.h"
#import "StackMob.h"
#import "AppDelegate.h"
#import "FulfillOfferViewController.h"
#import "FulfillRequestViewController.h"

@interface FulfillViewController ()

@end

@implementation FulfillViewController

@synthesize map, list, typeControl, managedObjectContext, requests, offers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        NSShadow *dropShadow = [[NSShadow alloc] init];
//        [dropShadow setShadowColor:[NSColor redColor]];
//        [dropShadow setShadowOffset:NSMakeSize(0, -10.0)];
//        [dropShadow setShadowBlurRadius:10.0];


//        [self.map setWantsLayer: YES];
//        [self.map setShadow: dropShadow];
//        map.layer.masksToBounds = NO;
//        map.layer.cornerRadius = 8; // if you like rounded corners
//        map.layer.shadowOffset = CGSizeMake(-15, 20);
//        map.layer.shadowRadius = 5;
//        map.layer.shadowOpacity = 0.5;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(zoom) withObject:nil afterDelay:1.0];
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    map.layer.borderColor =[UIColor colorWithWhite:0.7 alpha:0.7].CGColor;
    map.layer.borderWidth = 2;
    list.layer.borderColor =[UIColor colorWithWhite:0.7 alpha:0.5].CGColor;
    list.layer.borderWidth = 2;
    [self getRequests];
}

- (IBAction)changed:(id)sender
{
    if ([typeControl selectedSegmentIndex] == 0) {
        NSLog(@"settings to requests");
        [self getRequests];
    }
    else if ([typeControl selectedSegmentIndex] == 1) {
        NSLog(@"settings to offers");
        [self getOffers];
    }
}

- (void) getRequests
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Request"];
    
    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        //NSLog(@"results: %@", results);
        [self setRequests:[NSMutableArray arrayWithArray:results]];
        [self addPins];
        [self.list reloadData];
        NSLog(@"loaded requests");
        //NSLog(@"got requests: %@", requests);
    } onFailure:^(NSError *error) {
        NSLog(@"Error Fetching: %@", error);
    }];
}

- (void) getOffers
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Offer"];
    
    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        //NSLog(@"results: %@", results);
        [self setOffers:[NSMutableArray arrayWithArray:results]];
        [self addPins];
        [self.list reloadData];
        NSLog(@"loaded offers");
    } onFailure:^(NSError *error) {
        NSLog(@"Error Fetching: %@", error);
    }];
}

- (void)addPins
{
    id userLocation = [map userLocation];
    NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[map annotations]];
    if ( userLocation != nil ) {
        [pins removeObject:userLocation]; // avoid removing user location off the map
    }
    
    [map removeAnnotations:pins];
    pins = nil;
    
    if (typeControl.selectedSegmentIndex == 0) {
        for (NSManagedObject *object in requests) {
            
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [[object valueForKey:@"orglatitude"] doubleValue];
            coordinate.longitude = [[object valueForKey:@"orglongitude"] doubleValue];
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coordinate;
            point.title = [object valueForKey:@"requestdescription"];
            point.subtitle = [object valueForKey:@"orgwebsite"];
            [map addAnnotation:point];
            NSLog(@"request pin: %@", point);
        }
    }
    else if (typeControl.selectedSegmentIndex == 1) {
        for (NSManagedObject *object in offers) {
            
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = [[object valueForKey:@"pickuplatitude"] doubleValue];
            coordinate.longitude = [[object valueForKey:@"pickuplongitude"] doubleValue];
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = coordinate;
            point.title = [object valueForKey:@"offerdescription"];
            point.subtitle = [NSString stringWithFormat:@"%@ - %@", [object valueForKey:@"offertype"], [object valueForKey:@"contactemail"]];
            [map addAnnotation:point];
            NSLog(@"offer pin: %@", point);
        }
    }
    NSLog(@"done adding pins");
}

- (void)zoom
{
    NSLog(@"zooming");
    MKCoordinateRegion mapRegion;
    mapRegion.center = map.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    [map setRegion:mapRegion animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    //call requestsInView and reload list
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //NSLog(@"did update user loc");
    MKCoordinateRegion mapRegion = map.region;
    if (userLocation.location.horizontalAccuracy >= 0) {
        mapRegion.center = map.userLocation.coordinate;
    }
    mapRegion.span = map.region.span;
    CLLocation *mapCenter = [[CLLocation alloc] initWithLatitude:map.region.center.latitude longitude:map.region.center.longitude];
    CLLocation *userCenter = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    //map.region.center;
    CLLocationDistance dist = [mapCenter distanceFromLocation: userCenter];
    if (dist > 100000)
        [map setRegion:mapRegion animated: YES];
}

- (NSMutableArray*)requestsInView {
    NSMutableArray *therequests = [[NSMutableArray alloc] init];
    //TODO
    //calculate points in current mapview
    
    return therequests;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (requests != nil || offers != nil) {
        if (typeControl.selectedSegmentIndex == 0)
            return [requests count];
        if (typeControl.selectedSegmentIndex == 1)
            return [offers count];
        
    }
    NSLog(@"rows in sect. failed");
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    [cell.imageView setImage:nil];
    if ([typeControl selectedSegmentIndex] == 0) {
        NSLog(@"creating cell for request");
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:15.0];
        if ([[requests objectAtIndex:indexPath.row] valueForKey:@"requestdescription"] != nil) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"   %@",[[requests objectAtIndex:indexPath.row] valueForKey:@"requestdescription"]];
        }
        else {
            NSLog(@"description failed");
        }
        if (![[NSString stringWithFormat:@"%@ - %@", [[requests objectAtIndex:indexPath.row] valueForKey:@"orgname"], [[requests objectAtIndex:indexPath.row] valueForKey:@"orgwebsite"]] isEqual: @"(null) - (null)"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [[requests objectAtIndex:indexPath.row] valueForKey:@"orgname"], [[requests objectAtIndex:indexPath.row] valueForKey:@"orgwebsite"]];
        }
        else {
            NSLog(@"subtitle failed");
        }
    }
    
    else if ([typeControl selectedSegmentIndex] == 1) {
        NSLog(@"creating cell for offer");
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:15.0];
        if ([[offers objectAtIndex:indexPath.row] valueForKey:@"offerdescription"] != nil) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"   %@",[[offers objectAtIndex:indexPath.row] valueForKey:@"offerdescription"]];
        }
        else {
            NSLog(@"description failed");
        }
        if (![[NSString stringWithFormat:@"%@ - %@", [[offers objectAtIndex:indexPath.row] valueForKey:@"offertype"], [[offers objectAtIndex:indexPath.row] valueForKey:@"contactemail"]] isEqual: @"(null) - (null)"]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [[offers objectAtIndex:indexPath.row] valueForKey:@"offertype"], [[offers objectAtIndex:indexPath.row] valueForKey:@"contactemail"]];
        }
        else {
            NSLog(@"contact subtitle failed");
        }
        
        if (![[[offers objectAtIndex:indexPath.row] valueForKey:@"image"] isEqualToString: @""]) {
            @try {
                UIImage *offerImage = [[UIImage alloc] init];
                
                NSString *picString = [[offers objectAtIndex:indexPath.row] valueForKey:@"image"];
                //if ([SMBinaryDataConversion stringContainsURL:picString]) {
                //    NSURL *urlForPic = [NSURL URLWithString:picString];
                //   NSLog(@"Set image from URL");
                //}
                //else {
                offerImage = [UIImage imageWithData:[SMBinaryDataConversion dataForString:picString]];
                cell.imageView.image = offerImage;
                NSLog(@"image: %@", offerImage);
                //}
            }
            @catch (NSException *exception) {
                NSLog(@"couldn't load image, exception: %@", exception);
            }
            
        }
        else {
            NSLog(@"no image found");
        }
        
    }
    else {
        NSLog(@"error loading cell");
    }
    
    return cell;
}

- (void)dismissDetail
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [list deselectRowAtIndexPath:[list indexPathForSelectedRow] animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"presenting viewcontroller");
    if ([typeControl selectedSegmentIndex] == 0) {
        FulfillRequestViewController *fulfillRequestViewController = [[FulfillRequestViewController alloc] initWithNibName:@"FulfillRequestViewController" bundle:nil];
        [fulfillRequestViewController setDelegate:self];
        [fulfillRequestViewController setRequest:[requests objectAtIndex:indexPath.row]];
        [self presentViewController:fulfillRequestViewController animated:YES completion:nil];
        [fulfillRequestViewController fillFields];
    }
    else if ([typeControl selectedSegmentIndex] == 1) {
        FulfillOfferViewController *fulfillOfferViewController = [[FulfillOfferViewController alloc] initWithNibName:@"FulfillOfferViewController" bundle:nil];
        [fulfillOfferViewController setDelegate:self];
        [fulfillOfferViewController setOffer:[offers objectAtIndex:indexPath.row]];
        [self presentViewController:fulfillOfferViewController animated:YES completion:nil];
        [fulfillOfferViewController fillFields];
    }
    
}

#pragma mark - Table view delegate


@end
