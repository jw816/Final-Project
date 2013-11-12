//
//  CardViewController.h
//  Final_Project
//
//  Created by unbounded on 11/10/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureViewController.h"
@interface CardViewController : UIViewController <UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage * cardImage;
- (IBAction)backButton:(id)sender;
- (IBAction)addPhoto:(id)sender;

@end
