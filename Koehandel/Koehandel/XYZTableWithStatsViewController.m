//
//  XYZTableWithStatsViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 27-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZTableWithStatsViewController.h"

@interface XYZTableWithStatsViewController ()

@end

@implementation XYZTableWithStatsViewController

@synthesize playerLabel;

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
    self.playerLabel.text = self.player.name;
    self.deck = [[XYZDeck alloc] init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    else if (section == 1){
        return 10;
    }
    else {
        return 7;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.player.name;
    }
    else if (section == 1) {
        return @"Animals";
    }
    else {
        return @"Money";
    }
}


- (StatsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableIdentifier = @"tableItem";
    int moneyValues[6] = {0, 10, 50, 100, 200, 500};
    StatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        cell = [[StatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    
    if (indexPath.section == 0){
        if (indexPath.row == 0) {
            cell.animalAmount.text = [NSString stringWithFormat:@"Score: %d", [self.player getSets]];
            cell.animalImage.image = [UIImage imageNamed:@"score.png"];
        }
        else if (indexPath.row == 1) {
            cell.animalAmount.text = [NSString stringWithFormat:@"Sets: %d", [self.player getSets]];
            cell.animalImage.image = [UIImage imageNamed:@"set.png"];
        }
        else {
            cell.animalAmount.text = [NSString stringWithFormat:@"Money cards: %d", [self.player getAmountMoneyCards]];
            cell.animalImage.image = [UIImage imageNamed:@"coins.png"];
        }
    }
    else if (indexPath.section == 1) {
        cell.animalAmount.text = [[self.player.animalCards objectAtIndex:indexPath.row] stringValue];
        NSLog(@"%@", [self.deck.animals objectAtIndex:indexPath.row]);
        cell.animalImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [self.deck.animals objectAtIndex:indexPath.row]]];
    }
    else {
        if (indexPath.row == 0 ) {
            cell.animalAmount.text = [NSString stringWithFormat:@"Total amount: %d", [self.player getTotalMoney]];
            cell.animalImage.image = [UIImage imageNamed:@"coins.png"];
        }
        else {
            cell.animalAmount.text = [NSString stringWithFormat:@"%d cards", [[self.player.moneyCards objectAtIndex:indexPath.row - 1] integerValue]];
            cell.animalImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"moneybag%d.png", moneyValues[indexPath.row - 1]]];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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

@end
