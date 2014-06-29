//
//  XYZBiddingViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 25-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZBiddingViewController.h"

@interface XYZBiddingViewController ()

@end

@implementation XYZBiddingViewController

@synthesize totalAmountLabel, amountCardsLabels, cardSteppers, playerLabel;
NSInteger moneyValues[6] = {0, 10, 50, 100, 200, 500};

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
    
    self.gp.bidCounter++;
    
    // determine and display bidder
    if (self.gp.bidCounter == 1) {
        self.bidder = self.gp.currentPlayer;
    }
    else if (self.gp.bidCounter == 2) {
        self.bidder = self.gp.tradeEnemy;
    }
    self.playerLabel.text = [NSString stringWithFormat:@"%@ make your bet!", self.bidder.name];

    
    // sort amountCardsLabels by y-coordinate
    self.amountCardsLabels = [self.amountCardsLabels sortedArrayUsingComparator:^NSComparisonResult(id label1, id label2) {
        if ([label1 frame].origin.y < [label2 frame].origin.y) return NSOrderedAscending;
        else if ([label1 frame].origin.y > [label2 frame].origin.y) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
    
    // sort cardSteppers by y-coordinate
    self.cardSteppers = [self.cardSteppers sortedArrayUsingComparator:^NSComparisonResult(id label1, id label2) {
        if ([label1 frame].origin.y < [label2 frame].origin.y) return NSOrderedAscending;
        else if ([label1 frame].origin.y > [label2 frame].origin.y) return NSOrderedDescending;
        else return NSOrderedSame;
    }];
    
    // set-up setters with max amount equal to amount of cards or hide them if no cards of that value
    for (int i = 0; i < 6; i++) {
        if ([[self.bidder.moneyCards objectAtIndex:i] integerValue] == 0) {
            [[self.amountCardsLabels objectAtIndex:i] setText:[NSString stringWithFormat:@"No cards with value %d!", moneyValues[i]]];
            [[self.cardSteppers objectAtIndex:i] setHidden: YES];
        }
        else {
            [(UIStepper *)[self.cardSteppers objectAtIndex:i] setMaximumValue:[[self.bidder.moneyCards objectAtIndex:i] floatValue]];
        }
    }
    
    // display total bidding amount
    self.totalAmount = 0;
    self.totalAmountLabel.text = @"Total amount: 0";
    
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

- (IBAction)stepperValueChanged:(id)sender {
    int index = 0;
    self.totalAmount = 0;
    
    // update totalAmount and determine which stepper changed
    for (int i = 0; i < 6; i++){
        self.totalAmount += (int)[(UIStepper *)[self.cardSteppers objectAtIndex:i] value] * moneyValues[i];
        if (sender == [self.cardSteppers objectAtIndex:i]) {
            index = i;
            break;
        }
    }
    
    // determine stepper value
    int stepperValue = (int)[(UIStepper *)[self.cardSteppers objectAtIndex:index] value];
    
    // determine correct grammar
    NSString *tempString;
    if (stepperValue == 1) {
        tempString = @"card";
    }
    else {
        tempString = @"cards";
    }
    
    // update labels
    [[self.amountCardsLabels objectAtIndex:index] setText:[NSString stringWithFormat:@"%d %@ with value %d", stepperValue, tempString, moneyValues[index]]];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"Total amount: %d", self.totalAmount];
}

- (IBAction)placeBet:(id)sender {
    
    // alloc new mutable array for the cards the player bid and add to tradeBids array in gameplay object
    NSMutableArray *bidInCards = [[NSMutableArray alloc] init];
    for (int i = 0; i < 6; i++){
        [bidInCards addObject:[NSNumber numberWithInt:(int)[(UIStepper *)[self.cardSteppers objectAtIndex:i] value]]];
        self.bidder.moneyCards[i] = [NSNumber numberWithInt:[self.bidder.moneyCards[i] integerValue] - (int)[(UIStepper *)[self.cardSteppers objectAtIndex:i] value]];
    }
    [bidInCards addObject:[NSNumber numberWithInt:self.totalAmount]];
    [self.gp.tradeBids addObject:bidInCards];
    
    // go to confirm bid screen
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XYZBiddingViewController *cbvc = [storyboard instantiateViewControllerWithIdentifier:@"XYZConfirmBidViewController"];
    cbvc.gp = self.gp;
    [cbvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:cbvc animated:YES completion:nil];
}


@end
