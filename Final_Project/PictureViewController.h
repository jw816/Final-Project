//
//  PictureViewController.h
//  Final_Project
//
//  Created by unbounded on 11/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureCell.h"
#import "CropViewController.h"
@interface PictureViewController : UICollectionViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray * images;
- (IBAction)backButton:(id)sender;

@end
