//
//  XYZNewGameViewController.h
//  Koehandel
//
//  Created by Boris van Linschoten on 23-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZAuctionViewController.h"

@interface XYZNewGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name1Textfield;
@property (weak, nonatomic) IBOutlet UITextField *name2Textfield;
@property (weak, nonatomic) IBOutlet UITextField *name3Textfield;

- (IBAction)newGameButton:(id)sender;

@end
