//
//  ImageViewController.m
//  Threads
//
//  Created by Douglas Riches on 2015-04-28.
//  Copyright (c) 2015 New Toronto Group. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong,nonatomic) UIImage *image;

@property (strong,nonatomic) UIImageView *imageView;

//@property (strong,nonatomic) NSOperationQueue* queue;

- (void) fetchImage;
- (void) fetchImageBlocking;


@end

@implementation ImageViewController

NSURL *_imageURL;

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    if (self.view.window != nil) {
        [self fetchImageBlocking];
    }
}

- (NSURL *)imageURL
{
    return _imageURL;
}


-(void)setImage:(UIImage *)image
{
    _image = image;
    
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.imageView.frame.size;
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self.activityIndicator stopAnimating];
    
}


- (void)fetchImage
{
    [self.activityIndicator startAnimating];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 2;
    
    __weak ImageViewController *weakSelf = self;
    
    
    [queue addOperationWithBlock:^{
        NSLog(@"block Executing");
        NSData *data = [NSData dataWithContentsOfURL:weakSelf.imageURL];
        NSLog(@"data recieved");
        UIImage * image = nil;
        if (data) {
            image = [UIImage imageWithData:data];
        }else{
            NSLog(@"no data! from url %@",weakSelf.imageURL);
        }
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            //we have to interact with th UI on the main thread!
            NSLog(@"now on the main thread!");
            weakSelf.image = image;
        }];
        
    }];
    
    
}

- (void)fetchImageBlocking
{
    [self.activityIndicator startAnimating];

    
    NSData *data = [NSData dataWithContentsOfURL:self.imageURL];
    UIImage * image = nil;
    if (data) {
        image = [UIImage imageWithData:data];
    }else{
        NSLog(@"no data! from url %@",self.imageURL);
    }
    
    //we have to interact with th UI on the main thread!
    NSLog(@"now on the main thread!");
    self.image = image;
    
    
}


-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc] init];
    self.imageView.userInteractionEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.1;
    self.scrollView.maximumZoomScale = 2.0;
    [self.scrollView addSubview:self.imageView];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.image == nil) {
        [self fetchImageBlocking];
    }
}


@end
