//
//  SmilesAndTearsViewController.m
//  SmilesAndTears
//
//  Created by Ran Tao on 8.21.12.
//  Copyright (c) 2012 Ran Tao. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "SmilesAndTearsViewController.h"

@interface SmilesAndTearsViewController () 
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;

@end

@implementation SmilesAndTearsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Add some awesome beats here
    
    NSString *music = [[NSBundle mainBundle] pathForResource:@"waters" ofType:@"mp3"];
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
    self.musicPlayer.delegate;
    [self.musicPlayer play];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
