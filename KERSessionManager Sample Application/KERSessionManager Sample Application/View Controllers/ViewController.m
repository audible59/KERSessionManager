//
//  ViewController.m
//  KERSessionManager Sample Application
//
//  Created by Kevin E. Rafferty on 3/3/17.
//  Copyright © 2017 Quiver Coding. All rights reserved.
//

#import "ViewController.h"

static const NSString *weatherAPIURL = @"http://api.openweathermap.org/data/2.5/weather";
static const NSString *weatherAPIKey = @"72c543337934d7aa4934b1bed8e5ca18";

@interface ViewController ()

#pragma mark - Private Properties -

@property (weak, nonatomic) IBOutlet UIButton *getWeatherButton;

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end

@implementation ViewController

#pragma mark - View Life Cycle -

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - IBAction Methods -

- (IBAction)onGetWeatherButtonPressed:(id)sender {
    NSString *zipCode = self.zipCodeTextField.text;
    
    if (zipCode &&
        zipCode.length > 0) {
        NSURL *urlRequest = [NSURL URLWithString:[NSString stringWithFormat:@"%@?zip=%@,us&units=imperial&APPID=%@", weatherAPIURL, zipCode, weatherAPIKey]];
        
        [[KERSessionManager sharedInstance] GETRequestForURL:urlRequest
                                           completionHandler:^(NSDictionary *resultsDictionary) {
                                               NSLog(@"We have returned to the Sample Application");
                                               NSLog(@"Weather Dictionary - %@", resultsDictionary);
                                           }];
    }
}

@end
