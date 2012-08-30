//
//  SmilesAndTearsViewController.m
//  SmilesAndTears
//
//  Created by Ran Tao on 8.21.12.
//  Copyright (c) 2012 Ran Tao. All rights reserved.
//

#import "SmilesAndTearsViewController.h"

@interface SmilesAndTearsViewController ()
@property (nonatomic, retain)	MPMusicPlayerController	*musicPlayerFromLibrary;
@property (nonatomic, strong) MPMediaItem *nowPlayingItem;
@property (nonatomic) NSTimeInterval currentPlaybackTime;
@end

@implementation SmilesAndTearsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.musicPlayerFromLibrary = [MPMusicPlayerController new];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) collection {
    
    [self updatePlayerQueueWithMediaCollection: collection];
    [self dismissModalViewControllerAnimated: YES];
    
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker {
    
    [self dismissModalViewControllerAnimated: YES];
}


- (void) updatePlayerQueueWithMediaCollection: (MPMediaItemCollection *) mediaItemCollection {
    
    [self.musicPlayerFromLibrary setQueueWithItemCollection: mediaItemCollection];
    self.currentPlaybackTime = 0;
    
}


- (IBAction)musicButtonPressed:(UIButton *)sender {
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAnyAudio];
    
    [picker setDelegate: self];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackOpaque animated: YES];
    
    
    [self presentModalViewController: picker animated: YES];
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.musicPlayerFromLibrary.nowPlayingItem			= self.nowPlayingItem;
    self.musicPlayerFromLibrary.currentPlaybackTime		= self.currentPlaybackTime;
    [self.musicPlayerFromLibrary play]; 
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.nowPlayingItem = self.musicPlayerFromLibrary.nowPlayingItem;
    self.currentPlaybackTime	= self.musicPlayerFromLibrary.currentPlaybackTime;
    [self.musicPlayerFromLibrary stop];

    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
