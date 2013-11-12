//
//  FinishedCardViewController.m
//  Final_Project
//
//  Created by unbounded on 11/9/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "FinishedCardViewController.h"

@interface FinishedCardViewController ()

@end

@implementation FinishedCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.imageView.image = self.i
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.cards = [[NSMutableArray alloc]init];
    [self.cards addObject:[UIImage imageNamed:@"holiday_card_front.gif"]];
    [self.cards addObject:[UIImage imageNamed:@"Holiday-Card-2.jpg"]];
    [self.cards addObject:[UIImage imageNamed:@"holiday_card_3.jpg"]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cards.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cardCell";
    FinishedCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage * cellImage = [self.cards objectAtIndex:indexPath.row];
    //cell.cardImage = cellImage;
    cell.imageView.image = cellImage;
    [cell.facebookButton addTarget:self action:@selector(postToFB:)
                           forControlEvents:UIControlEventTouchUpInside];
    [cell.sendButton addTarget:self action:@selector(sendToEmail:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)postToFB:(id)sender {
    //NSLog(@"test");
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            slCVC = [[SLComposeViewController alloc]init];
            slCVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            UIImage * sendImage = [self.cards objectAtIndex:indexPath.row];
            [slCVC addImage:sendImage];
            [self presentViewController:slCVC animated:YES completion:nil];
        }
        else{
            UIAlertView*av = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Facebook type is not available" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [av show];
        }
    }
}
-(void)sendToEmail:(id)sender{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:buttonPosition];
    if (indexPath != nil)
    {
        //email stuff
        mc= [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = self;
        [mc setSubject:@"holiday card"];
        UIImage * sendImage = [self.cards objectAtIndex:indexPath.row];
        NSData * imageData = UIImagePNGRepresentation(sendImage);
        [mc addAttachmentData:imageData mimeType:@"png" fileName:@"Holiday_Card.png"];
        [self presentViewController:mc animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"email sent");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    return;
}
@end
