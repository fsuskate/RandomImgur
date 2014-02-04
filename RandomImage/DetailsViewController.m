//
//  DetailsViewController.m
//  RandomImage
//
//  Created by Francisco Surroca on 1/29/14.
//  Copyright (c) 2014 Francisco Surroca. All rights reserved.
//

#import "DetailsViewController.h"
#import "AppDelegate.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBackToImage:)];
    [self.view addGestureRecognizer:tap];
    
    self.titleLabel.text = self.titleText;
    self.sectionLabel.text = self.sectionText;
    self.linkLabel.text = self.linkText;
    self.heightLabel.text = self.heightText;
    self.widthLabel.text = self.widthText;
    self.sizeLabel.text = self.sizeText;
    
    NSString *imageUrlString = self.linkText;
    NSURL *url = [NSURL URLWithString:imageUrlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [self.imageView setImage:image];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)goBackToImage:(id)sender
{
    [self performSegueWithIdentifier:@"ShowImage" sender:self];
}



@end
