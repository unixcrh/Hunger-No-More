//
//  FulfillDetailViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMob.h"
#import "FulfillViewController.h"
#import <MessageUI/MessageUI.h>
#import "QBFlatButton.h"

@class FulfillViewController;

@interface FulfillRequestViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet QBFlatButton *doneButton;
@property (nonatomic, retain) IBOutlet QBFlatButton *fulfillButton;
@property (nonatomic, retain) FulfillViewController* delegate;
@property (nonatomic, retain) NSManagedObject *request;

@property (nonatomic, retain) IBOutlet UILabel *orgNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *neededByLabel;
@property (nonatomic, retain) IBOutlet UILabel *contactLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *websiteLabel;
@property (nonatomic, retain) IBOutlet UILabel *emailLabel;


- (void) fillFields;
- (IBAction)fulfill:(id)sender;
- (IBAction)done:(id)sender;

@end