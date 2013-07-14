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

@interface GiveViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UITextViewDelegate> {
    NSArray *typeArray;
    NSArray *metricArray;
}

@property (nonatomic, retain) IBOutlet UIPickerView* typePicker;
@property (nonatomic, retain) IBOutlet UITextView* descriptionField;
@property (nonatomic, retain) IBOutlet UIPickerView* metricPicker;
@property (nonatomic, retain) IBOutlet UITextField* amountField;
@property (nonatomic, retain) IBOutlet UITextField* allergyField;
@property (nonatomic, retain) IBOutlet UIDatePicker* usebyPicker;
@property (nonatomic, retain) IBOutlet UIButton* pictureButton;
@property (nonatomic, retain) IBOutlet UIButton* submitButton;

@property (nonatomic, retain) UIImage *donationImage;


- (IBAction)submit:(id)sender;
- (IBAction)selectPicture:(id)sender;
- (IBAction)removeKeyboard:(id)sender;

@end