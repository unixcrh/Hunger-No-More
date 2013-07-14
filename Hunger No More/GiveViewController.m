//
//  GiveViewController.m
//  Hunger No More
//
//  Created by John Luttig on 7/14/13.
//  Copyright (c) 2013 Hackathon. All rights reserved.
//

#import "GiveViewController.h"

@interface GiveViewController ()

@end

@implementation GiveViewController
@synthesize itemsButton, moneyButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[QBFlatButton appearance] setFaceColor:[UIColor colorWithWhite:0.75 alpha:1.0] forState:UIControlStateDisabled];
    [[QBFlatButton appearance] setSideColor:[UIColor colorWithWhite:0.55 alpha:1.0] forState:UIControlStateDisabled];
    
    itemsButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    itemsButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    itemsButton.radius = 8.0;
    itemsButton.margin = 4.0;
    itemsButton.depth = 3.0;
    [itemsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    moneyButton.faceColor = [UIColor colorWithRed:86.0/255.0 green:161.0/255.0 blue:217.0/255.0 alpha:1.0];
    moneyButton.sideColor = [UIColor colorWithRed:79.0/255.0 green:127.0/255.0 blue:179.0/255.0 alpha:1.0];
    moneyButton.radius = 8.0;
    moneyButton.margin = 4.0;
    moneyButton.depth = 3.0;
    [moneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoplainlarge.png"]];
    backgroundImage.frame = CGRectMake(backgroundImage.frame.origin.x-40, backgroundImage.frame.origin.y+200, backgroundImage.frame.size.width, backgroundImage.frame.size.height);
    backgroundImage.alpha = 0.3;
    
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
    //btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    //[btn setTitle:@"Button" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
