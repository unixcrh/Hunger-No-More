//
//  RequestViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "QBFlatButton.h"

@interface RequestViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate> {
    //NSArray *textFields;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UITextField* personNameField;
@property (nonatomic, retain) IBOutlet UITextField* contactEmailField;
@property (nonatomic, retain) IBOutlet UITextField* organizationNameField;
@property (nonatomic, retain) IBOutlet UITextField* organizationWebsiteField;
@property (nonatomic, retain) IBOutlet UITextField* organizationAddressField;
@property (nonatomic, retain) IBOutlet UITextField* organizationCityField;
@property (nonatomic, retain) IBOutlet UITextField* organizationStateField;
@property (nonatomic, retain) IBOutlet UITextField* organizationZIPField;
@property (nonatomic, retain) IBOutlet UITextField* requestDescriptionField;
@property (nonatomic, retain) IBOutlet UIDatePicker* neededByPicker;
@property (nonatomic, retain) IBOutlet QBFlatButton* submitButton;

@property (nonatomic, retain) IBOutlet CLPlacemark *placemark;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

- (IBAction)submit:(id)sender;
-(void)uploadRequest:(NSDictionary*) request;

@end