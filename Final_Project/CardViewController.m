//
//  CardViewController.m
//  Final_Project
//
//  Created by unbounded on 11/10/13.
//  Copyright (c) 2013 unlimited. All rights reserved.
//

#import "CardViewController.h"

@interface CardViewController ()

@end

@implementation CardViewController

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
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.cardImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationLandscapeLeft;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPhoto:(id)sender {
    
    NSString *actionSheetTitle = @"Add Photos From";
    
    //Action Sheet Button Titles
    NSString *choice1 = @"Phone";
    NSString *choice2 = @"Facebook";
    NSString *choice3 = @"Take New";
    
    //Instantiation action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:choice1,choice2,choice3, nil];
    
    //showing action sheet in current view
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if([buttonTitle isEqualToString:@"Phone"]){
        UINavigationController * navController = [self.storyboard instantiateViewControllerWithIdentifier:@"FindPictures"];
        PictureViewController * pictureViewController = [navController.childViewControllers objectAtIndex:0];
        NSArray * imageArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"person1.jpg"],[UIImage imageNamed:@"person2.jpg"],[UIImage imageNamed:@"person3.jpg"],[UIImage imageNamed:@"person4.jpg"], nil];
        pictureViewController.images = imageArray;
        [self presentViewController:navController animated:YES completion:nil];
    }
    if([buttonTitle isEqualToString:@"Facebook"]){
        UINavigationController * navController = [self.storyboard instantiateViewControllerWithIdentifier:@"FindPictures"];
        //navController set = UIInterfaceOrientationMaskPortrait;
        //PictureViewController * pictureViewController = [navController.childViewControllers objectAtIndex:0];
        
        //get photos from facebook
        NSArray *permissions =
        [NSArray arrayWithObjects:@"email", nil];
        [FBSession openActiveSessionWithReadPermissions:permissions allowLoginUI:YES completionHandler:
         ^(FBSession *session, FBSessionState status, NSError *error) {
             if (error == nil) {
                 NSLog(@"success");
             }
             else{
                 NSLog(@"%@",error);
             }
         }];
        
        if (FBSession.activeSession.isOpen) {
            [[FBRequest requestForMe] startWithCompletionHandler:
             ^(FBRequestConnection *connection,
               NSDictionary<FBGraphUser> *user,
               NSError *error) {
                 if (!error) {
                     NSLog(@"test");
                     
                     NSURL * albumURL = [NSURL URLWithString:[NSString stringWithFormat: @"https://graph.facebook.com/%@?fields=albums", user.id]];
                     NSLog(@"%@", [albumURL absoluteString]);
                     
                     NSData * data = [NSData dataWithContentsOfURL:albumURL];
                     NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                     NSLog(@"%@", data);
                     NSLog(@"%@",jsonDict);
                     
                     NSDictionary *albumDict = [jsonDict objectForKey:@"albums"];
                     NSMutableArray * photos;
                     
                     for (id key in albumDict) {
                         [photos addObject:[albumDict objectForKey:key]];
                     }
                     UINavigationController * navController = [self.storyboard instantiateViewControllerWithIdentifier:@"FindPictures"];
                     PictureViewController * pictureViewController = [navController.childViewControllers objectAtIndex:0];
                     NSArray * imageArray = [[NSArray alloc]initWithArray:photos];
                     pictureViewController.images = imageArray;
                     [self presentViewController:navController animated:YES completion:nil];
                 }
             }];
        }
        
        [self presentViewController:navController animated:YES completion:nil];
    }
    if([buttonTitle isEqualToString:@"Take New"]){
        
    }
}
@end
