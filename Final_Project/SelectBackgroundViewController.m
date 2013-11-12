//
//  SelectBackgroundViewController.m
//  Final_Project
//
//  Created by unbounded on 11/10/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "SelectBackgroundViewController.h"

@interface SelectBackgroundViewController ()

@end

@implementation SelectBackgroundViewController

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
    
    static NSString *identifier = @"backgroundCell";
    BackgroundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    UIImage * cellImage = [self.cards objectAtIndex:indexPath.row];
    cell.imageView.image = cellImage;

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CardViewController * cardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"cardView"];
    //cardViewController.imageView.image = [self.cards objectAtIndex:indexPath.row];
    cardViewController.cardImage = [self.cards objectAtIndex:indexPath.row];
    
    //[self.navigationController pushViewController:cardViewController animated:YES];
    [self.navigationController presentViewController:cardViewController animated:YES completion:nil];
    //[self presentViewController:cardViewController animated:YES completion:nil];
}

@end
