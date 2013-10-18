//
//  HaloViewController.m
//  v2dots
//
//  Created by Ri Quan on 10/14/13.
//  Copyright (c) 2013 Ri Quan. All rights reserved.
//

#import "HaloViewController.h"

@interface HaloViewController ()

@end

@implementation HaloViewController
@synthesize imageView;
@synthesize upArrowImgView;
@synthesize downArrowImgView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIAccelerometer *theAccelerometer = [UIAccelerometer sharedAccelerometer];
    theAccelerometer.updateInterval = 0.1; //in seconds
    theAccelerometer.delegate = self;
    
    CGPoint pos = self.view.center;
    imageView.center = pos;
    
    upArrowImgView.hidden = NO;
    downArrowImgView.hidden = YES;
    
    up = YES;
    moveEnable = YES;
    
    timer  = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateMethod:)
                                            userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView == alert) {
        
        CGPoint pos = self.view.center;
        imageView.center = pos;
        
        upArrowImgView.hidden = NO;
        downArrowImgView.hidden = YES;
        
        up = YES;
        moveEnable = YES;
        timer  = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateMethod:)
                                                userInfo:nil repeats:YES];
    }
    
}

- (void)updateMethod:(NSTimer *)theTimer {
    if (upArrowImgView.alpha >= 0.9)
        m_alphaInterval = -0.1;
    else if (upArrowImgView.alpha <= 0.2)
        m_alphaInterval = 0.1;
    [upArrowImgView setAlpha:upArrowImgView.alpha + m_alphaInterval];
    
    if (downArrowImgView.alpha >= 0.9)
        m_alphaInterval = -0.1;
    else if (downArrowImgView.alpha <= 0.2)
        m_alphaInterval = 0.1;
    [downArrowImgView setAlpha:downArrowImgView.alpha + m_alphaInterval];

}

//http://install.diawi.com/7pGkG6
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration

{
    if (moveEnable == NO)
        return;
    
    float deceleration = 0.8f;
    float sensetivity = 10.0f;
    float maxVelocity = 100;
    
    velocity.x = velocity.x * deceleration + acceleration.x * sensetivity;
    velocity.y = velocity.y * deceleration + -1.0f * acceleration.y * sensetivity;
    
    if (velocity.x > maxVelocity)
        velocity.x = maxVelocity;
    else if (velocity.x < -maxVelocity)
        velocity.x = -maxVelocity;
    
    if (velocity.y > maxVelocity)
        velocity.y = maxVelocity;
    else if (velocity.y < -maxVelocity)	
        velocity.y = -maxVelocity;
    
    CGPoint pos = imageView.center;
    pos.x += velocity.x;
    pos.y += velocity.y;
    
    CGSize bounds = self.view.frame.size;
    float imageWidthHalved = imageView.frame.size.width * 0.5f;
    float imageHeightHalved = imageView.frame.size.height * 0.5f;
    
    float leftBorderLimit = imageWidthHalved;
    float rightBorderLimit = bounds.width - imageWidthHalved;	
    
    float topBorderLimit = imageHeightHalved;
    float bottomBorderLimit = bounds.height - imageHeightHalved;
    
    if (pos.x < leftBorderLimit)	
    {
        pos.x = leftBorderLimit;
        velocity.x = 0.0f;
    }
    else if (pos.x > rightBorderLimit)
    {
        pos.x = rightBorderLimit;
        velocity.x = 0.0f;
    }
    
    if (pos.y < topBorderLimit)
    {
        pos.y = topBorderLimit;
        velocity.y = 0.0f;
        up = NO;
        upArrowImgView.hidden = YES;
        downArrowImgView.hidden = NO;
    }
    else if (pos.y > bottomBorderLimit)
    {
        pos.y = bottomBorderLimit;
        velocity.y = 0.0f;
    }
    
    if (imageView.center.y > bounds.height / 2 && up == NO)
    {
        moveEnable = NO;
        [timer invalidate];
        alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"You achieved success. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    [UIView animateWithDuration:0.1 animations:^{
        imageView.center = pos;
    }] ;
}

@end
