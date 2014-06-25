//
//  XYZViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 20-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZAuctionViewController.h"

@interface XYZAuctionViewController ()

@end

@implementation XYZAuctionViewController

@synthesize cardsRemainingLabel, scoreLabel, animalImage, cardImage, currentPlayerLabel, drawCardButton, soldButton;

NSInteger newPlayerCounter = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    currentPlayerLabel.text = @"";
    soldButton.hidden = YES;
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    self.gp = tbvc.gp;
    UIAlertView *playerAmount = [[UIAlertView alloc] initWithTitle:@"New Game" message:@"Amount of players:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"3", @"4", @"5", nil];
    [playerAmount setAlertViewStyle:UIAlertViewStyleDefault];
    playerAmount.tag = 1;
    [playerAmount show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawCard:(id)sender {
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    tbvc.turnDecided = YES;
    self.gp.currentCard = [self.gp.deck draw];
    scoreLabel.text = [NSString stringWithFormat:@"%d", self.gp.currentCard.value];
    cardsRemainingLabel.text = [NSString stringWithFormat:@"Cards remaining: %d", [self.gp.deck.cards count]];
    cardImage.image = [UIImage imageNamed:@"card-border.png"];
    drawCardButton.enabled = NO;
    soldButton.hidden = NO;

    switch ([[self.gp.deck.animalDict objectForKey:self.gp.currentCard.animal] integerValue]) {
        case 0:
            animalImage.image = [UIImage imageNamed:@"Chicken.png"];
            break;
        case 1:
            animalImage.image = [UIImage imageNamed:@"Goose.png"];
            break;
        case 2:
            animalImage.image = [UIImage imageNamed:@"Cat.png"];
            break;
        case 3:
            animalImage.image = [UIImage imageNamed:@"Dog.png"];
            break;
        case 4:
            animalImage.image = [UIImage imageNamed:@"Sheep.png"];
            break;
        case 5:
            animalImage.image = [UIImage imageNamed:@"Goat.png"];
            break;
        case 6:
            animalImage.image = [UIImage imageNamed:@"Donkey.png"];
            break;
        case 7:
            animalImage.image = [UIImage imageNamed:@"Pig.png"];
            break;
        case 8:
            animalImage.image = [UIImage imageNamed:@"Cow.png"];
            break;
        case 9:
            animalImage.image = [UIImage imageNamed:@"Horse.png"];
            break;
    }
}

- (IBAction)cardSold:(id)sender {
    UIActionSheet *cardSold = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (int i = 0; i < [self.gp.waitingPlayers count]; i++) {
        [cardSold addButtonWithTitle:[NSString stringWithFormat:@"Sold to %@", [[self.gp.waitingPlayers objectAtIndex:i] name]]];
    }
    [cardSold addButtonWithTitle:@"Oops! Go back!"];
    cardSold.cancelButtonIndex = [self.gp.waitingPlayers count];
    cardSold.tag = 1;
    [cardSold showInView:self.view];
}


-(void)nextTurn {
    [self.gp nextTurn];
    if ([self.gp.deck.cards count] > 0) {
        cardImage.image = [UIImage imageNamed:@"card-back.png"];
    }
    else {
        cardImage.image = NULL;
    }
    animalImage.image = NULL;
    currentPlayerLabel.text = [NSString stringWithFormat:@"%@'s turn!", self.gp.currentPlayer.name];
    drawCardButton.enabled = YES;
    soldButton.hidden = YES;
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    tbvc.turnDecided = NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (alertView.tag) {
        case 1:
            cardsRemainingLabel.text = [NSString stringWithFormat:@"Cards remaining: %d", [self.gp.deck.cards count]];
            self.gp.amountOfPlayers = buttonIndex + 3;
            newPlayerCounter = 1;
            [self askForPlayerName:newPlayerCounter];
            break;
        case 2:
            if (buttonIndex == 0) {
                NSString *name = [[alertView textFieldAtIndex:0] text];
                XYZPlayer *tempPlayer = [[XYZPlayer alloc] initWithName:name];
                [self.gp.players addObject:tempPlayer];
                if (newPlayerCounter == 1) {
                    self.gp.currentPlayer = tempPlayer;
                }
                else {
                    [self.gp.waitingPlayers addObject:tempPlayer];
                }
                newPlayerCounter++;
                if (newPlayerCounter <= self.gp.amountOfPlayers) {
                    [self askForPlayerName:newPlayerCounter];
                }
                else {
                    currentPlayerLabel.text = [NSString stringWithFormat:@"%@'s turn!", self.gp.currentPlayer.name];
                }
            }
            break;
        case 3:
            if (buttonIndex == 0) {
                return;
            }
            else if(buttonIndex == 1) {
                NSInteger amount = [[[alertView textFieldAtIndex:0] text] integerValue];
                if ([self.gp auctionCard:self.gp.currentCard soldfor:amount buyer:self.gp.buyer]) {;
                    [self nextTurn];
                }
                else {
                    UIAlertView *cardSold = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ doesn't have enough money!", self.gp.buyer.name] message:@"Enter new amount:" delegate:self cancelButtonTitle:@"Oops! Go Back!" otherButtonTitles:@"Sold!", nil];
                    [cardSold setAlertViewStyle:UIAlertViewStylePlainTextInput];
                    UITextField * alertTextField = [cardSold textFieldAtIndex:0];
                    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
                    alertTextField.placeholder = @"Enter amount";
                    cardSold.tag = 3;
                    [cardSold show];
                }
            }
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == [self.gp.waitingPlayers count]) {
        return;
    }
    else {
        for (int i = 0; i <= [self.gp.waitingPlayers count]; i++){
            if (buttonIndex == i) {
                self.gp.buyer = [self.gp.waitingPlayers objectAtIndex:i];
                UIAlertView *cardSold = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Sold to %@!", self.gp.buyer.name] message:@"Animal sold for:" delegate:self cancelButtonTitle:@"Oops! Go Back!" otherButtonTitles:@"Sold!", nil];
                [cardSold setAlertViewStyle:UIAlertViewStylePlainTextInput];
                UITextField * alertTextField = [cardSold textFieldAtIndex:0];
                alertTextField.keyboardType = UIKeyboardTypeNumberPad;
                alertTextField.placeholder = @"Enter amount";
                cardSold.tag = 3;
                [cardSold show];
            }
        }
    }
}

-(void)askForPlayerName:(NSInteger)player {
    UIAlertView *newPlayer = [[UIAlertView alloc] initWithTitle:@"New Player" message:[NSString stringWithFormat:@"Player %d enter your name:", player] delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    [newPlayer setAlertViewStyle:UIAlertViewStylePlainTextInput];
    newPlayer.tag = 2;
    [newPlayer show];
}


@end
