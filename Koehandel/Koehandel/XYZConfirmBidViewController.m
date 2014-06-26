//
//  XYZConfirmBidViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZConfirmBidViewController.h"

@interface XYZConfirmBidViewController ()

@end

@implementation XYZConfirmBidViewController

@synthesize player1BidLabel, player2BidLabel, confirmButton;

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
    int totalCards1 = 0;
    for (int i = 0; i < 6; i++) {
        totalCards1 += [[[self.gp.tradeBids objectAtIndex:0] objectAtIndex:i] integerValue];
    }
    
    self.player1BidLabel.text = [NSString stringWithFormat:@"%@'s bid exists of %d cards", self.gp.currentPlayer.name, totalCards1];
    
    if (self.gp.bidCounter == 1) {
        self.player2BidLabel.hidden = YES;
        [self.confirmButton setTitle:@"Make counterbid" forState:UIControlStateNormal];
    }
    else {
        int totalCards2 = 0;
        for (int i = 0; i < 6; i++) {
            totalCards1 += [[[self.gp.tradeBids objectAtIndex:1] objectAtIndex:i] integerValue];
        }
        self.player2BidLabel.hidden = NO;
        self.player2BidLabel.text = [NSString stringWithFormat:@"%@'s bid exists of %d cards", self.gp.tradeEnemy.name, totalCards2];
        [self.confirmButton setTitle:@"Show result!" forState:UIControlStateNormal];
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

- (IBAction)confirm:(id)sender {
    if (self.gp.bidCounter == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        XYZBiddingViewController *bvc = [storyboard instantiateViewControllerWithIdentifier:@"XYZBiddingViewController"];
        bvc.gp = self.gp;
        [bvc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:bvc animated:YES completion:nil];
    }
    else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        XYZBiddingViewController *trvc = [storyboard instantiateViewControllerWithIdentifier:@"XYZTradeResultViewController"];
        trvc.gp = self.gp;
        [trvc setModalPresentationStyle:UIModalPresentationFullScreen];
        trvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:trvc animated:YES completion:nil];
    }
}
@end
