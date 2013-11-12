//
//  FinishedCardCell.h
//  Final_Project
//
//  Created by unbounded on 11/9/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Social/social.h"

//@class FinishedCardViewController;

@interface FinishedCardCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *facebookButton;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) UIImage * cardImage;

@end
