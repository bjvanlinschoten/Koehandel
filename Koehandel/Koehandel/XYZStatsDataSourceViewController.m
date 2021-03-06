//
//  XYZStatsDataSourceViewController.m
//  Koehandel
//
//  Created by Boris van Linschoten on 26-06-14.
//  Copyright (c) 2014 bjvanlinschoten. All rights reserved.
//

#import "XYZStatsDataSourceViewController.h"

@interface XYZStatsDataSourceViewController ()

@end

@implementation XYZStatsDataSourceViewController

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
    
    // set up the page view
    self.statsPageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"XYZStatsPageViewController"];
    self.statsPageViewController.dataSource = self;
    XYZTableWithStatsViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.statsPageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.statsPageViewController];
    [self.view addSubview:self.statsPageViewController.view];
    [self.statsPageViewController didMoveToParentViewController:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// page before current page
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((XYZTableWithStatsViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

// page after current page
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((XYZTableWithStatsViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.gp.players count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

// set up page
- (XYZTableWithStatsViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.gp.players count] == 0) || (index >= [self.gp.players count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    XYZTableWithStatsViewController *twsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"XYZTableWithStatsViewController"];
    twsvc.player = [self.gp.players objectAtIndex:index];
    twsvc.pageIndex = index;
    
    return twsvc;
}

// set up page indicator
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.gp.players count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    /*for (int i = 0; i < [self.gp.players count]; i++) {
        if ([self.gp.players objectAtIndex:i] == self.gp.currentPlayer) {
            return i;
        }
    }*/
    
    return 0;
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
