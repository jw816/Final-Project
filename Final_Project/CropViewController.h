//
//  CropViewController.h
//  Final_Project
//
//  Created by unbounded on 11/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage * personImage;
- (IBAction)BackButton:(id)sender;
- (IBAction)cropImage:(id)sender;
@end
