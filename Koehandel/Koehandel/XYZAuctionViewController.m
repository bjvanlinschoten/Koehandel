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
    
    // set up display
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    self.gp = tbvc.gp;
    currentPlayerLabel.text = @"";
    soldButton.hidden = YES;
    currentPlayerLabel.text = @"";
    
    // alertview with menu of amount of players for this game
    UIAlertView *playerAmount = [[UIAlertView alloc] initWithTitle:@"New Game" message:@"Amount of players:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"3", @"4", @"5", nil];
    [playerAmount setAlertViewStyle:UIAlertViewStyleDefault];
    playerAmount.tag = 1;
    [playerAmount show];
}

- (void) viewDidAppear:(BOOL)animated {
    
    // if player hasnt decided on turn, display view accordingly
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    if (tbvc.turnDecided == NO) {
        animalImage.image = NULL;
        if (self.gp.currentPlayer.name != NULL) {
            currentPlayerLabel.text = [NSString stringWithFormat:@"%@'s turn!", self.gp.currentPlayer.name];
        }
        drawCardButton.enabled = YES;
        soldButton.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawCard:(id)sender {
    XYZTabBarViewController *tbvc = (XYZTabBarViewController *)self.tabBarController;
    tbvc.turnDecided = YES;
    
    // draw a card from the deck
    self.gp.currentCard = [self.gp.deck draw];
    
    // if a donkey is drawn, give all players cashmoney (game rule)
    if ([self.gp.currentCard.animal isEqualToString:@"Donkey"]) {
        for (XYZPlayer *player in self.gp.players) {
            player.moneyCards[self.gp.donkeys + 2] = [NSNumber numberWithInt:[player.moneyCards[self.gp.donkeys + 2] integerValue] + 1];
        }
        int donkeyValues[4] = {50, 100, 200, 500};
        UIAlertView *donkey = [[UIAlertView alloc] initWithTitle:@"Donkey drawn!" message:[NSString stringWithFormat:@"All players receive a money card with value %d", donkeyValues[self.gp.donkeys]] delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil];
        [donkey setAlertViewStyle:UIAlertViewStyleDefault];
        [donkey show];
    }
    
    // update displays
    scoreLabel.text = [NSString stringWithFormat:@"%d", self.gp.currentCard.value];
    cardsRemainingLabel.text = [NSString stringWithFormat:@"Cards remaining: %d", [self.gp.deck.cards count]];
    cardImage.image = [UIImage imageNamed:@"card-border.png"];
    drawCardButton.enabled = NO;
    soldButton.hidden = NO;
    animalImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", self.gp.currentCard.animal]];
}

// prompt for player the animal is sold to through action sheet
- (IBAction)cardSold:(id)sender {
    UIActionSheet *cardSold = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (int i = 0; i < [self.gp.waitingPlayers count]; i++) {
        [cardSold addButtonWithTitle:[NSString stringWithFormat:@"Sold to %@", [[self.gp.waitingPlayers objectAtIndex:i] name]]];
    }
    [cardSold addButtonWithTitle:@"Oops! Go back!"];
    cardSold.cancelButtonIndex = [self.gp.waitingPlayers count];
    cardSold.tag = 1;
    [cardSold showFromTabBar:self.tabBarController.tabBar];
}

// next turn and update view
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
        // alertview for amount of players and start asking their names
        case 1:
            cardsRemainingLabel.text = [NSString stringWithFormat:@"Cards remaining: %d", [self.gp.deck.cards count]];
            self.gp.amountOfPlayers = buttonIndex + 3;
            newPlayerCounter = 1;
            [self askForPlayerName:newPlayerCounter];
            break;
        // alert view for asking the player's names
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
        // alert view for sold animals
        case 3:
            
            // cancel button
            if (buttonIndex == 1) {
                return;
            }
            else {
                // get amount for which animal is sold
                NSInteger amount = [[[alertView textFieldAtIndex:0] text] integerValue];
                
                // if button 'buy myself' is pressed, change the seller and buyer accordingly
                if (buttonIndex == 2) {
                    self.gp.seller = self.gp.buyer;
                    self.gp.buyer = self.gp.currentPlayer;
                }
                // else set up seller
                else {
                    self.gp.seller = self.gp.currentPlayer;
                }
                
                // if player has enough money, perform the sell
                if ([self.gp auctionCard:self.gp.currentCard soldFor:amount]) {;
                    [self nextTurn];
                }
                // else, warn them and ask for new amount
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
    // cancel button
    if (buttonIndex == [self.gp.waitingPlayers count]) {
        return;
    }
    else {
        for (int i = 0; i <= [self.gp.waitingPlayers count]; i++){
            
            // determine which player bought and display alertview accordingly
            if (buttonIndex == i) {
                self.gp.buyer = [self.gp.waitingPlayers objectAtIndex:i];
                UIAlertView *cardSold = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Sold to %@!", self.gp.buyer.name] message:@"Animal sold for:" delegate:self cancelButtonTitle:@"Sold!" otherButtonTitles:@"Oops! Go Back!", [NSString stringWithFormat:@"%@ buys himself!", self.gp.currentPlayer.name], nil];
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

// display alert view for player name prompt
-(void)askForPlayerName:(NSInteger)player {
    UIAlertView *newPlayer = [[UIAlertView alloc] initWithTitle:@"New Player" message:[NSString stringWithFormat:@"Player %d enter your name:", player] delegate:self cancelButtonTitle:@"Done" otherButtonTitles:nil];
    [newPlayer setAlertViewStyle:UIAlertViewStylePlainTextInput];
    newPlayer.tag = 2;
    [newPlayer show];
}


@end
