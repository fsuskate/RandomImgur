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
            NSLog(@"%@", responseString);
            
            NSArray *components = [responseString componentsSeparatedByString:@"},"];
            
            NSString *str = [NSString stringWithFormat:@"%@%@", [components objectAtIndex:1], @"}"];
            
            NSLog(@"%@", str);
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:response options:nil  error:nil];
            NSLog(@"%@", resultDict);
            
            if (resultDict)
            {
                imageDict = [resultDict objectForKey:@"data"];
                if (imageDict)
                {
                    imageStrings = [[NSMutableArray alloc] init];
                    NSLog(@"%@", imageDict);
                    for(NSDictionary *itemDict in imageDict)
                    {
                        NSLog(@"%@", itemDict);
                        NSLog(@"%@", [itemDict objectForKey:@"link"]);
                        NSString *linkStr = [itemDict objectForKey:@"link"];
                        [imageStrings addObject:linkStr];
                    }
                    NSLog(@"%@", imageStrings);
                }
            }
        }
        
        if (imageDict)
        {
            int randomIndex = rand() % imageStrings.count;
            NSString *imageUrlString = [imageStrings objectAtIndex:randomIndex];
            NSURL *url = [NSURL URLWithString:imageUrlString];
            NSData *data = [[NSData alloc] initWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            [imageView setImage:image];
        }
            
    }
    @catch (NSException *exception)
    {
        NSLog(@"Exception%@", exception);
    }
    
}

-(IBAction)getRandomImage:(id)sender
{
    if (imageDict)
    {
        int randomIndex = rand() % imageStrings.count;
        NSString *imageUrlString = [imageStrings objectAtIndex:randomIndex];
        NSURL *url = [NSURL URLWithString:imageUrlString];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        [imageView setImage:image];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
