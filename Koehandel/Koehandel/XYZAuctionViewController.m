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

@synthesize cardsRemainingLabel, scoreLabel, animalImage, cardImage, currentPlayerLabel, waitingPlayer1BuysButton, waitingPlayer2BuysButton;

XYZDeck *deck = NULL;
XYZGameplay *gp = NULL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    deck = [[XYZDeck alloc] init];
    gp = [[XYZGameplay alloc] init];
    cardsRemainingLabel.text = [NSString stringWithFormat:@"Cards remaining: %d", [deck.cards count]];
    gp.player1 = [[XYZPlayer alloc] initWithName:self.name1];
    gp.player2 = [[XYZPlayer alloc] initWithName:self.name2];
    gp.player3 = [[XYZPlayer alloc] initWithName:self.name3];
    gp.currentPlayer = gp.player1;
    gp.waitingPlayer1 = gp.player2;
    gp.waitingPlayer2 = gp.player3;
    currentPlayerLabel.text = [NSString stringWithFormat:@"%@'s turn!", gp.currentPlayer.name];
    [waitingPlayer1BuysButton setTitle:[NSString stringWithFormat:@"%@ buys", gp.waitingPlayer1.name] forState:UIControlStateNormal];
    [waitingPlayer2BuysButton setTitle:[NSString stringWithFormat:@"%@ buys", gp.waitingPlayer2.name] forState:UIControlStateNormal];
    currentPlayerLabel.text = [NSString stringWithFormat:@"%@'s turn!", gp.currentPlayer.name];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)drawCard:(id)sender {
    if ([deck.cards count] > 0) {
        gp.currentCard = [deck draw];
        scoreLabel.text = [NSString stringWithFormat:@"%d", gp.currentCard.value];
        cardsRemainingLabel.text = [NSString stringWithFormat:@"Cards remaining: %d", [deck.cards count]];
        cardImage.image = [UIImage imageNamed:@"card-border.png"];
        
        switch (gp.currentCard.animal) {
            case Chicken:
                animalImage.image = [UIImage imageNamed:@"Chicken.png"];
                break;
            case Goose:
                animalImage.image = [UIImage imageNamed:@"Goose.png"];
                break;
            case Cat:
                animalImage.image = [UIImage imageNamed:@"Cat.png"];
                break;
            case Dog:
                animalImage.image = [UIImage imageNamed:@"Dog.png"];
                break;
            case Sheep:
                animalImage.image = [UIImage imageNamed:@"Sheep.png"];
                break;
            case Goat:
                animalImage.image = [UIImage imageNamed:@"Goat.png"];
                break;
            case Donkey:
                animalImage.image = [UIImage imageNamed:@"Donkey.png"];
                break;
            case Pig:
                animalImage.image = [UIImage imageNamed:@"Pig.png"];
                break;
            case Cow:
                animalImage.image = [UIImage imageNamed:@"Cow.png"];
                break;
            case Horse:
                animalImage.image = [UIImage imageNamed:@"Horse.png"];
                break;
        }
    }
    else {
        scoreLabel.text = @"";
        cardImage.image = NULL;
        animalImage.image = NULL;
    }
}

-(void)nextTurn {
    if ([deck.cards count] > 0) {
        cardImage.image = [UIImage imageNamed:@"card-back.png"];
    }
    else {
        cardImage.image = NULL;
    }
    animalImage.image = NULL;
    
    XYZPlayer *tempPlayer = [XYZPlayer alloc];
    tempPlayer = gp.currentPlayer;
    gp.currentPlayer = gp.waitingPlayer1;
    gp.waitingPlayer1 = gp.waitingPlayer2;
    gp.waitingPlayer2 = tempPlayer;
    [waitingPlayer1BuysButton setTitle:[NSString stringWithFormat:@"%@ buys", gp.waitingPlayer1.name] forState:UIControlStateNormal];
    [waitingPlayer2BuysButton setTitle:[NSString stringWithFormat:@"%@ buys", gp.waitingPlayer2.name] forState:UIControlStateNormal];
    currentPlayerLabel.text = [NSString stringWithFormat:@"%@'s turn!", gp.currentPlayer.name];
}

- (IBAction)waitingPlayer1Buys:(id)sender {
    gp.buyer = gp.waitingPlayer1;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Sold to %@!", gp.waitingPlayer1.name] message:@"Animal sold for:" delegate:self cancelButtonTitle:@"Oops! Go Back!" otherButtonTitles:@"Buy!", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Enter amount";
    [alert show];
}

- (IBAction)waitingPlayer2Buys:(id)sender {
    gp.buyer = gp.waitingPlayer2;
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Sold to %@!", gp.waitingPlayer2.name] message:@"Animal sold for:" delegate:self cancelButtonTitle:@"Oops! Go Back!" otherButtonTitles:@"Buy!", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    alertTextField.placeholder = @"Enter amount";
    [alert show];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }
    else if(buttonIndex == 1) {
        NSInteger amount = [[[alertView textFieldAtIndex:0] text] integerValue];
        [gp auctionCard:gp.currentCard soldfor:amount buyer:gp.buyer];
        [self nextTurn];
    }
}


@end
