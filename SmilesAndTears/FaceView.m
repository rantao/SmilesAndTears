//
//  FaceView.m
//  SmilesAndTears
//
//  Created by Ran Tao on 8.21.12.
//  Copyright (c) 2012 Ran Tao. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "FaceView.h"


@interface FaceView() <AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioPlayer *musicPlayer;
@end


@implementation FaceView {
    CGPoint touchLocation;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void) awakeFromNib {
    // Load background music
    [self loadMusic];
    
}


-(void) loadMusic {
    NSString *music = [[NSBundle mainBundle] pathForResource:@"waters" ofType:@"mp3"];
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:music] error:NULL];
    self.musicPlayer.delegate;
    [self.musicPlayer prepareToPlay];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    // Draw strobe lights
    [self drawStrobesinContext:context];
    
    // Draw guy
    [self drawGuyinContext:context];
   
}

-(void) drawGuyinContext: (CGContextRef) context {
    UIGraphicsPushContext(context);
    CGRect bounds  = self.bounds;
    self.backgroundColor = [self randomColor];
    //[[self randomColor] set];
    [[UIColor blackColor] set ];
    
    //define all points for bezier curve
    CGPoint start = CGPointMake(bounds.origin.x + bounds.size.width/4.0, bounds.origin.y + bounds.size.height);
    CGPoint controlPoint1 = CGPointMake(bounds.origin.x + bounds.size.width/2.0, bounds.origin.y + bounds.size.height*7.0/8.0);
    CGPoint controlPoint2 = CGPointMake(touchLocation.x - bounds.size.width*3.0/8.0, bounds.origin.y + bounds.size.height/8.0);
    CGPoint controlPoint3 = CGPointMake(touchLocation.x + bounds.size.width*3.0/8.0, bounds.origin.y + bounds.size.height/8.0);
    CGPoint controlPoint4 = CGPointMake(bounds.origin.x + bounds.size.width/2.0, bounds.origin.y + bounds.size.height*7.0/8.0);
    CGPoint end = CGPointMake(bounds.origin.x + bounds.size.width*3.0/4.0, bounds.origin.y + bounds.size.height);
    CGPoint apex = CGPointMake(bounds.origin.x + bounds.size.width/2.0, bounds.origin.y + bounds.size.height/8.0);
    
    //move to the start point
    CGContextMoveToPoint(context, start.x, start.y);
    
    //create a bezier curve for our little guy
    CGContextAddCurveToPoint(context,controlPoint1.x,controlPoint1.y, controlPoint2.x,controlPoint2.y, apex.x, apex.y);
    CGContextAddCurveToPoint(context,controlPoint3.x, controlPoint3.y,controlPoint4.x,controlPoint4.y, end.x, end.y);
    CGContextFillPath(context);
    
    //add eyes
    [[UIColor whiteColor] set];
    CGPoint leftEyeLocation = CGPointMake(touchLocation.x - bounds.size.width/8.0, bounds.origin.y + bounds.size.height*3.0/8.0);
    CGPoint rightEyeLocation = CGPointMake(touchLocation.x + bounds.size.width/8.0, bounds.origin.y + bounds.size.height*3.0/8.0);
    CGFloat eyeRadius = 10.0;
    CGContextAddArc(context,rightEyeLocation.x, rightEyeLocation.y, eyeRadius, 0.0, M_PI*2.0, YES);
    CGContextFillPath(context);
    CGContextAddArc(context,leftEyeLocation.x, leftEyeLocation.y, eyeRadius/2.0, 0.0, M_PI*2.0, YES);
    CGContextFillPath(context);
    UIGraphicsPopContext();
}

-(void) drawStrobesinContext: (CGContextRef) context {
    UIGraphicsPushContext(context);
    CGRect bounds  = self.bounds;
    // Define strobe start point
    CGPoint start = CGPointMake(bounds.origin.x + bounds.size.width/2.0, bounds.origin.y);
    
    CGContextMoveToPoint(context, start.x, start.y);
    
    // Define strobe end point
    CGPoint end = [self randomStrobeEndPoint];
    
    CGContextAddLineToPoint(context, end.x, end.y);
    CGContextAddLineToPoint(context, end.x + 20, end.y);
    
    //CGContextDrawLinearGradient(<#CGContextRef context#>, <#CGGradientRef gradient#>, <#CGPoint startPoint#>, <#CGPoint endPoint#>, <#CGGradientDrawingOptions options#>)
    [[self randomStrobeColor] set];
    CGContextFillPath(context);
    
    UIGraphicsPopContext();
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    touchLocation = [touch locationInView:touch.view];
    [self setNeedsDisplay];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.musicPlayer play];
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.musicPlayer stop];
    
}


-(float) randomIntensity {
    //return arc4random() % 11 * 0.1;
    // limit intensity to be very low
    return 1 - arc4random() % 11 * 0.01;
}

-(float) randomHighIntensity {
    //return arc4random() % 11 * 0.1;
    // limit intensity to be very low
    return 1-arc4random() % 11 * 0.05;
}



-(CGPoint) randomStrobeEndPoint {
    float temp = (float) self.bounds.size.width;
    double randomNumber = (double) arc4random() / INT_MAX * temp;
    
    return CGPointMake((CGFloat)randomNumber, self.bounds.size.height);
}

- (UIColor*) randomColor {
    return [UIColor colorWithRed:[self randomIntensity] green:[self randomIntensity]  blue:[self randomIntensity]  alpha:1];
}

- (UIColor*) randomStrobeColor {
    return [UIColor colorWithRed:[self randomHighIntensity] green:[self randomHighIntensity]  blue:[self randomHighIntensity]  alpha:1];
}

@end
