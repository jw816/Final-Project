//
//  SelectBackgroundViewController.h
//  Final_Project
//
//  Created by unbounded on 11/10/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BackgroundCell.h"
#import "CardViewController.h"
@interface SelectBackgroundViewController : UICollectionViewController
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray * cards;
@end
