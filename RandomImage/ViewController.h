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
    NSMutableArray *imageItemsArray;
    NSDictionary *imageDict;
    IBOutlet UIImageView *imageView;
    int currentIndex;
}

-(IBAction)getRandomImage:(id)sender;
-(IBAction)showImageInfo:(id)sender;

@end
