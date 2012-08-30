//
//  SmilesAndTearsViewController.h
//  SmilesAndTears
//
//  Created by Ran Tao on 8.21.12.
//  Copyright (c) 2012 Ran Tao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


@interface SmilesAndTearsViewController : UIViewController <MPMediaPickerControllerDelegate>
- (IBAction)musicButtonPressed:(UIButton *)sender;

@end
