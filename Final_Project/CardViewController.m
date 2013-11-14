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
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountChanged) name:ACAccountStoreDidChangeNotification object:nil];
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
        
        //get photos from facebook
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        
        ACAccountType *facebookAccountType = [accountStore
                                              accountTypeWithAccountTypeIdentifier:
                                              ACAccountTypeIdentifierFacebook];
        NSDictionary *options = @{ACFacebookAppIdKey: @"608089375896907",
                                  ACFacebookPermissionsKey: @[@"email"]
                                  };
        
        [accountStore requestAccessToAccountsWithType:facebookAccountType options:options completion:^(BOOL granted, NSError *e) {
            if (granted) {
                NSLog(@"granted");
            }
            else
            {
                // Handle Failure
                NSLog(@"%@",e);
            }
        }];
        
        //get albums
        NSDictionary *options2 = @{
                                   ACFacebookAppIdKey: @"608089375896907",
                                   ACFacebookPermissionsKey: @[@"user_photos",
                                                               @"friends_photos"]
                                   };
        
        [accountStore requestAccessToAccountsWithType:facebookAccountType options:options2 completion:^(BOOL granted, NSError *e) {
            NSArray *accounts = [accountStore
                                 accountsWithAccountType:facebookAccountType];
            self.facebookAccount = [accounts lastObject];
            [accountStore renewCredentialsForAccount:self.facebookAccount completion:^(ACAccountCredentialRenewResult renewResult, NSError *error){
                
            }];
            NSString *accessToken = [NSString stringWithFormat:@"%@",self.facebookAccount.credential.oauthToken];
            NSDictionary *parameters = @{@"access_token": accessToken};
            NSLog(@"%@",accessToken);
            
            NSURL *albumURL = [NSURL URLWithString:@"https://graph.facebook.com/me?fields=albums"];
            SLRequest *albumRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:albumURL parameters:parameters];
            
            albumRequest.account = self.facebookAccount;
            [albumRequest performRequestWithHandler:^(NSData *responseData,
                                                      NSHTTPURLResponse *urlResponse, NSError *error)
            {
                NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                NSLog(@"%@", jsonDict);
            }];
            //get cover photos
            //[albumRequest
        
        }];
        [self presentViewController:navController animated:YES completion:nil];
    }
    if([buttonTitle isEqualToString:@"Take New"]){
        
    }
}
@end
