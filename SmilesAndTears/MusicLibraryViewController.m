//
//  MusicLibraryViewController.m
//  SmilesAndTears
//
//  Created by Ran Tao on 8.29.12.
//  Copyright (c) 2012 Ran Tao. All rights reserved.
//

#import "MusicLibraryViewController.h"

@interface MusicLibraryViewController () <MPMediaPickerControllerDelegate>

@end

@implementation MusicLibraryViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker
   didPickMediaItems: (MPMediaItemCollection *) collection {
    
    [self dismissModalViewControllerAnimated: YES];
    MPMediaItem *currentSong = [collection.items objectAtIndex:0];
    MPMediaPickerController *picker =
    [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAnyAudio];
    
    [picker setDelegate: self]; 
    picker.prompt = NSLocalizedString (@"Add songs to play",
                       "Prompt in media item picker");
    
    [self presentModalViewController: picker animated: YES]; 
}

- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker {
    
    [self dismissModalViewControllerAnimated: YES];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
