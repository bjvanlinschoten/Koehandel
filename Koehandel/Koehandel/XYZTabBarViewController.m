//
//  XYZTabBarViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 25-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZTabBarViewController.h"

@interface XYZTabBarViewController ()

@end

@implementation XYZTabBarViewController

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
    // alloc new gameplay element
    
    self.gp = [[XYZGameplay alloc] init];
    
    // set up tab bar
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.translucent = NO;
    UITabBarItem *auctionItem = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *tradeItem = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *statsItem = [self.tabBar.items objectAtIndex:2];
    auctionItem.image = [UIImage imageNamed:@"auctionactive.png"];
    tradeItem.image = [UIImage imageNamed:@"tradeactive.png"];
    statsItem.image = [UIImage imageNamed:@"statsactive.png"];
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

@end
