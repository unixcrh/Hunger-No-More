//
//  GiveViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

//PICKER TAG VALUES
#define TAGTYPEPICKER 10
#define TAGMETRICPICKER 11
#define TAGUSEBYPICKER 12



#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "StackMob.h"
#import "GiveViewController.h"
#import "QBFlatButton.h"

@interface GiveItemsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSArray *typeArray;
    NSArray *metricArray;
}
@property (nonatomic, retain) IBOutlet QBFlatButton* backButton;

//@property (nonatomic, retain) GiveViewController *delegate;

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveImageButton;

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPickerView* typeAndMetricPicker;
@property (nonatomic, retain) IBOutlet UITextField* descriptionField;
//@property (nonatomic, retain) IBOutlet UIPickerView* metricPicker;
@property (nonatomic, retain) IBOutlet UITextField* amountField;
@property (nonatomic, retain) IBOutlet UITextField* allergyField;
@property (nonatomic, retain) IBOutlet UITextField* contactEmailField;
@property (nonatomic, retain) IBOutlet UIDatePicker* usebyPicker;
@property (nonatomic, retain) IBOutlet QBFlatButton* pictureButton;
@property (nonatomic, retain) IBOutlet QBFlatButton* submitButton;

@property (nonatomic, retain) IBOutlet CLPlacemark *placemark;

@property (nonatomic, retain) IBOutlet UITextField* pickupAddressField;
@property (nonatomic, retain) IBOutlet UITextField* pickupCityField;
@property (nonatomic, retain) IBOutlet UITextField* pickupStateField;
@property (nonatomic, retain) IBOutlet UITextField* pickupZIPField;

@property (nonatomic, retain) UIImage *donationImage;

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

-(IBAction)saveImageAction:(id)sender;

- (IBAction)back:(id)sender;
- (IBAction)submit:(id)sender;
- (IBAction)selectPicture:(id)sender;
- (IBAction)removeKeyboard:(id)sender;

-(void)uploadOffer:(NSDictionary*) offer;
- (void)saveOffer:(NSManagedObject *)newManagedObject;

@end