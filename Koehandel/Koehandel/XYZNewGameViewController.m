//
//  XYZNewGameViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 23-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZNewGameViewController.h"

@interface XYZNewGameViewController ()

@end

@implementation XYZNewGameViewController

@synthesize name1Textfield, name2Textfield, name3Textfield;

XYZAuctionViewController *avc = NULL;

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    avc = [storyboard instantiateViewControllerWithIdentifier:@"XYZAuctionViewController"];
    [name1Textfield becomeFirstResponder];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)newGameButton:(id)sender {
    avc.name1 = name1Textfield.text;
    avc.name2 = name2Textfield.text;
    avc.name3 = name3Textfield.text;
    [avc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:avc animated:YES completion:nil];
}
@end
