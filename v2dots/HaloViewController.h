//
//  HaloViewController.h
//  v2dots
//
//  Created by Ri Quan on 10/14/13.
//  Copyright (c) 2013 Ri Quan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaloViewController : UIViewController <UIAlertViewDelegate>{
    CGPoint velocity;
    bool up;
    UIAlertView *alert;
    bool moveEnable;
    
    NSTimer *timer;
    float m_alphaInterval;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *upArrowImgView;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowImgView;

@end
