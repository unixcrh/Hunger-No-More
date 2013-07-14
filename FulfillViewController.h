//
//  FulfillViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FulfillViewController : UIViewController <MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
    CLLocationManager* locManager;
}

@property (nonatomic, retain) IBOutlet MKMapView *map;
@property (nonatomic, retain) IBOutlet UITableView *list;
@property (nonatomic, retain) IBOutlet UISegmentedControl *typeControl;

-(void)zoom;

@end