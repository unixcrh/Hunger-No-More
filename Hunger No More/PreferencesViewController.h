//
//  SettingsViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/13/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *emailField;
@property (nonatomic, retain) IBOutlet UITextField *addressField;
@property (nonatomic, retain) IBOutlet UITextField *cityField;
@property (nonatomic, retain) IBOutlet UITextField *stateField;
@property (nonatomic, retain) IBOutlet UITextField *zipField;
@property (nonatomic, retain) IBOutlet UITextField *nameField;

-(void)done;

@end