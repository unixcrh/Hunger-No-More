//
//  GiveViewController.h
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBFlatButton.h"

@interface GiveViewController : UIViewController

@property (nonatomic, retain) IBOutlet QBFlatButton *moneyButton;
@property (nonatomic, retain) IBOutlet QBFlatButton *itemsButton;

//-(IBAction)next:(id)sender;
-(void)dismissView;

@end