//
//  FulfillOfferViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "FulfillViewController.h"

@interface FulfillOfferViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) IBOutlet QBFlatButton *doneButton;
@property (nonatomic, retain) IBOutlet QBFlatButton *fulfillButton;
@property (nonatomic, retain) FulfillViewController* delegate;
@property (nonatomic, retain) NSManagedObject *offer;

@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *amountLabel;
@property (nonatomic, retain) IBOutlet UILabel *addressLabel;
@property (nonatomic, retain) IBOutlet UILabel *usebyLabel;
@property (nonatomic, retain) IBOutlet UILabel *emailLabel;


- (void) fillFields;
- (IBAction)fulfill:(id)sender;
- (IBAction)done:(id)sender;

@end