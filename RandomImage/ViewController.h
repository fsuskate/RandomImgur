//
//  ViewController.h
//  RandomImage
//
//  Created by Francisco Surroca on 1/27/14.
//  Copyright (c) 2014 Francisco Surroca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSDictionary *imageDict;
    NSMutableArray *imageStrings;
    IBOutlet UIImageView *imageView;
}

-(IBAction)getRandomImage:(id)sender;

@end
