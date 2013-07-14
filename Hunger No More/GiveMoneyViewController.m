//
//  GiveMoneyViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "GiveMoneyViewController.h"

@interface GiveMoneyViewController ()

@end

@implementation GiveMoneyViewController

@synthesize backButton, donationAmountField, donateButton, emailField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    [PayPalPaymentViewController prepareForPaymentUsingClientId:@"YOUR_CLIENT_ID"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoplainlarge.png"]];
    backgroundImage.frame = CGRectMake(backgroundImage.frame.origin.x-40, backgroundImage.frame.origin.y+200, backgroundImage.frame.size.width, backgroundImage.frame.size.height);
    backgroundImage.alpha = 0.3;
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    
    donateButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    donateButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    donateButton.radius = 8.0;
    donateButton.margin = 4.0;
    donateButton.depth = 3.0;
    [donateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    backButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    backButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    backButton.radius = 3.0;
    backButton.margin = 2.0;
    backButton.depth = 2.0;
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTransaction:(id)sender
{
    if ([donationAmountField.text isEqualToString:@""] ||
        [emailField.text isEqualToString:@""]) {
        UIAlertView *incompleteAlert = [[UIAlertView alloc] initWithTitle:@"Incomplete Form" message:@"Please check to make sure all required fields are complete." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [incompleteAlert show];
        return;
    }
    
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.amount = [[NSDecimalNumber alloc] initWithString:donationAmountField.text];
    payment.currencyCode = @"USD";
    payment.shortDescription = @"Hunger No More Donation";
    
    [PayPalPaymentViewController setEnvironment:PayPalEnvironmentNoNetwork];
    
    receiverEmail = emailField.text;
    NSString *payerID = @"example@organization.com";
    PayPalPaymentViewController *paymentViewController;
    paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:@"YOUR_CLIENT_ID" receiverEmail:receiverEmail payerId:payerID payment:payment delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (void) payPalPaymentDidComplete:(PayPalPayment *)completedPayment
{
    [self verifyCompletedPayment:completedPayment];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) payPalPaymentDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) verifyCompletedPayment:(PayPalPayment*)completedPayment
{
    //NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation options:0 error:nil];
    UIAlertView *verifiedAlert = [[UIAlertView alloc] initWithTitle:@"Confirmed!" message:[NSString stringWithFormat:@"Congratulations! Thank you for donating $%.02f to %@.", [donationAmountField.text doubleValue], receiverEmail] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [verifiedAlert show];
    NSLog(@"Payment Confirmed");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
