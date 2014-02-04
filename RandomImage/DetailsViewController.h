//
//  DetailsViewController.h
//  RandomImage
//
//  Created by Francisco Surroca on 1/29/14.
//  Copyright (c) 2014 Francisco Surroca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface DetailsViewController : UIViewController 

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *sectionLabel;
@property (strong, nonatomic) IBOutlet UILabel *linkLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *widthLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property NSString *titleText;
@property NSString *sectionText;
@property NSString *linkText;
@property NSString *heightText;
@property NSString *widthText;
@property NSString *sizeText;

-(IBAction)goBackToImage:(id)sender;


@end
