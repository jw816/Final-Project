//
//  PictureViewController.m
//  Final_Project
//
//  Created by unbounded on 11/11/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "PictureViewController.h"

@interface PictureViewController ()

@end

@implementation PictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}*/
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"PictureCell";
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage * cellImage = [self.images objectAtIndex:indexPath.row];
    cell.imageView.image = cellImage;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CropViewController* cropViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"cropView"];
    cropViewController.imageView.image = [self.images objectAtIndex:indexPath.row];
    cropViewController.personImage = [self.images objectAtIndex:indexPath.row];
    //cardViewController.cardImage = [self.cards objectAtIndex:indexPath.row];
    
    //[self.navigationController pushViewController:cardViewController animated:YES];
    [self.navigationController presentViewController:cropViewController animated:YES completion:nil];
    //[self presentViewController:cardViewController animated:YES completion:nil];
}
@end
