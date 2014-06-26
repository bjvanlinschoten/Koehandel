//
//  XYZTradingViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 24-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZTradingViewController.h"

@interface XYZTradingViewController ()

@end

@implementation XYZTradingViewController

@synthesize tradePicker;
@synthesize tradeButton, warningLabel;

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
    self.gp = [(XYZTabBarViewController *)self.tabBarController gp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    if (tbvc.turnDecided == YES) {
        tradePicker.hidden = YES;
        tradeButton.hidden = YES;
        warningLabel.hidden = NO;
        warningLabel.text = @"You already decided to auction!";
    }
    else {
        self.mutualAnimals = [self.gp determineMutualAnimals];
        BOOL tradePossible = NO;
        for (int i = 0; i < [self.gp.waitingPlayers count]; i++) {
            if ([self.mutualAnimals count] > 0) {
                tradePossible = YES;
                break;
            }
        }
        if (tradePossible == NO) {
            tradePicker.hidden = YES;
            tradeButton.hidden = YES;
            warningLabel.hidden = NO;
            warningLabel.text = @"Sorry, you don't have any mutual animals with the other players!";
        }
        else {
            tradePicker.hidden = NO;
            tradeButton.hidden = NO;
            warningLabel.hidden = YES;
            [tradePicker reloadAllComponents];
        }
    }
}

#pragma mark Picker Data Source Methods
    
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
    }
    if (component == 1) {
        [pickerView reloadComponent:2];
    }
}

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [self.mutualAnimals count];
    }
    else if (component == 1) {
        int selectedPlayer = [pickerView selectedRowInComponent:0];
        int numRows = [[self.mutualAnimals objectAtIndex:selectedPlayer] count] - 1;
        return numRows;
    }
    else if (component == 2) {
        int selectedAnimal = [pickerView selectedRowInComponent:1];
        int selectedPlayer = [pickerView selectedRowInComponent:0];
        return [[[[self.mutualAnimals objectAtIndex:selectedPlayer] objectAtIndex:selectedAnimal] objectAtIndex:1] integerValue];
    }
    else {
        return 0;
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [[[self.mutualAnimals objectAtIndex:row] lastObject] name];
    }
    else if (component == 1) {
        int selectedPlayer = [pickerView selectedRowInComponent:0];
        return [[[self.mutualAnimals objectAtIndex:selectedPlayer] objectAtIndex:row] objectAtIndex:0];
    }
    else if (component == 2) {
        return [NSString stringWithFormat:@"%d", row + 1];
    }
    else {
        return NULL;
    }
}


- (IBAction)trade:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XYZBiddingViewController *bvc = [storyboard instantiateViewControllerWithIdentifier:@"XYZBiddingViewController"];
    //XYZBiddingViewController *bvc = [[XYZBiddingViewController alloc] init];
    bvc.gp = self.gp;
    self.gp.tradeBids = [[NSMutableArray alloc] init];
    self.gp.bidCounter = 0;
    self.gp.tradeEnemy = [[self.mutualAnimals objectAtIndex:[tradePicker selectedRowInComponent:0]] lastObject];
    self.gp.animalForTrade = [[[self.mutualAnimals objectAtIndex:[tradePicker selectedRowInComponent:0]] objectAtIndex:[tradePicker selectedRowInComponent:1]] objectAtIndex:0];
    self.gp.amountOfAnimalsForTrade = [tradePicker selectedRowInComponent:2] + 1;
    [bvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:bvc animated:YES completion:nil];
}
                    
@end
