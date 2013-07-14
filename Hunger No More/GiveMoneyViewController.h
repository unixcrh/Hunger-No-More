//
//  GiveMoneyViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"
#import "QBFlatButton.h"

@interface GiveMoneyViewController : UIViewController <PayPalPaymentDelegate, UITextFieldDelegate> {
    NSString *receiverEmail;
}

@property (nonatomic, retain) IBOutlet QBFlatButton* backButton;
@property (nonatomic, retain) IBOutlet QBFlatButton* donateButton;
@property (nonatomic, retain) IBOutlet UITextField* donationAmountField;
@property (nonatomic, retain) IBOutlet UITextField* emailField;

- (IBAction)back:(id)sender;
- (IBAction)startTransaction:(id)sender;

@end