//
//  ViewController.m
//  Threads
//
//  Created by Douglas Riches on 2015-04-28.
//  Copyright (c) 2015 New Toronto Group. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@property (strong,nonatomic) NSURL* phobos;
@property (strong,nonatomic) NSURL* earth;

@end



@implementation ViewController

- (id) init{
    if (self = [super init]) {
        [self prepareController];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self prepareController];
    }
    return self;
}


- (void)prepareController
{
    self.phobos = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/f/f4/Phobos_edit_2.jpg"];
    
    self.earth = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/d/db/Nasa_blue_marble.jpg"];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ImageViewController *imageVC = (ImageViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"earth"]) {
        
        NSLog(@"prepare URL: %@",self.earth);
        imageVC.imageURL = self.earth;
        imageVC.title = @"Earth";
    }
    if ([segue.identifier isEqualToString:@"phobos"]) {
        imageVC.imageURL = self.phobos;
        imageVC.title = @"Phobos";
    }
}

@end
