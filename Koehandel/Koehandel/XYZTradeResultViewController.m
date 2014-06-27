//
//  XYZTradeResultViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZTradeResultViewController.h"

@interface XYZTradeResultViewController ()

@end

@implementation XYZTradeResultViewController

@synthesize winnerLabel;

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
    XYZPlayer *winner = [self.gp trade];
    int animalIndex = [[self.gp.deck.animalDict objectForKey:self.gp.animalForTrade] integerValue];
    
    if (winner.name == NULL) {
        winnerLabel.text = @"It's a draw!";
    }
    else {
        winnerLabel.text = [NSString stringWithFormat:@"%@ won the trade! He now has %d %@ cards!", winner.name, [[winner.animalCards objectAtIndex:animalIndex] integerValue], self.gp.animalForTrade];
    }
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

- (IBAction)back:(id)sender {
    [self.gp nextTurn];
    [self.presentingViewController.presentingViewController.presentingViewController.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}
@end
