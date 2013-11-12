//
//  FinishedCardViewController.h
//  Final_Project
//
//  Created by unbounded on 11/9/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinishedCardCell.h"
#import "Social/social.h"
#import <MessageUI/MessageUI.h>
@interface FinishedCardViewController : UICollectionViewController <MFMailComposeViewControllerDelegate>
{
    SLComposeViewController*slCVC;
    MFMailComposeViewController *mc;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray * cards;
@end
