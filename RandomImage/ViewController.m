//
//  ViewController.m
//  RandomImage
//
//  Created by Francisco Surroca on 1/27/14.
//  Copyright (c) 2014 Francisco Surroca. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImageInfo:)];
    [imageView addGestureRecognizer:tap];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(getRandomImage:)];
    [imageView addGestureRecognizer:swipe];
    
    @try
    {
        NSMutableURLRequest *getRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.imgur.com/3/gallery/random/random/0"]];
    
        [getRequest setHTTPMethod:@"GET"];
    
        [getRequest addValue:@"Client-Id f609571ab85f649" forHTTPHeaderField:@"Authorization"];
        
        NSError *requestError;
        NSURLResponse *urlResponse = nil;
        
        NSData *response = [NSURLConnection sendSynchronousRequest:getRequest returningResponse:&urlResponse error:&requestError];
        if (response)
        {
            NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
            //NSLog(@"%@", responseString);
            
            if (responseString)
            {
                NSArray *components = [responseString componentsSeparatedByString:@"},"];
                
                NSString *str = [NSString stringWithFormat:@"%@%@", [components objectAtIndex:1], @"}"];
                //NSLog(@"%@", str);
                
                NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response options:nil  error:nil];
                //NSLog(@"%@", resultDict);
                if (resultDict)
                {
                    imageDict = [resultDict objectForKey:@"data"];
                    if (imageDict)
                    {
                        //NSLog(@"%@", imageDict);
                        imageItemsArray = [[NSMutableArray alloc] init];
                        for(NSDictionary *itemDict in imageDict)
                        {
                            [imageItemsArray addObject:itemDict];
                            NSLog(@"%@", itemDict);
                        }
                    }
                }
            }
        }
        
        [self getRanDomImageData];
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception%@", exception);
    }
    
}

-(void)getRanDomImageData
{
    if (imageDict)
    {
        currentIndex = rand() % imageItemsArray.count;
        NSDictionary *itemData = [imageItemsArray objectAtIndex:currentIndex];
        
        NSString *imageUrlString = [itemData objectForKey:@"link"];
        NSURL *url = [NSURL URLWithString:imageUrlString];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        [imageView setImage:image];
    }
}

-(IBAction)getRandomImage:(id)sender
{
    [self getRanDomImageData];
}

-(IBAction)showImageInfo:(id)sender
{
    NSDictionary *itemData = [imageItemsArray objectAtIndex:currentIndex];
    NSString *message = [NSString stringWithFormat:@"Title: %@\nSection: %@\nLink: %@\nHeight: %@\nWidth: %@\nSize: %@",
                         [itemData objectForKey:@"title"],
                         [itemData objectForKey:@"section"],
                         [itemData objectForKey:@"link"],
                         [itemData objectForKey:@"height"],
                         [itemData objectForKey:@"width"],
                         [itemData objectForKey:@"size"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Image Info" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
