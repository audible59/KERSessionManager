//
//  ViewController.m
//  KERSessionManager Sample Application
//
//  Created by Kevin E. Rafferty on 3/3/17.
//  Copyright © 2017 Quiver Coding. All rights reserved.
//

#import "ViewController.h"

static const NSString *openWeatherAPIURL = @"http://api.openweathermap.org/data/2.5/weather";
static const NSString *openWeatherAPIKey = @"72c543337934d7aa4934b1bed8e5ca18";

static const NSString *globalWeatherAPIURL = @"http://www.webservicex.com/globalweather.asmx/GetWeather";

@interface ViewController ()

#pragma mark - Private Properties -

@property (weak, nonatomic) IBOutlet UIButton *getWeatherButton;
@property (weak, nonatomic) IBOutlet UIButton *postWeatherButton;

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
        NSURL *urlRequest = [NSURL URLWithString:[NSString stringWithFormat:@"%@?zip=%@,us&units=imperial&APPID=%@", openWeatherAPIURL, zipCode, openWeatherAPIKey]];
        
        [[KERSessionManager sharedInstance] GETRequestForURL:urlRequest
                                           completionHandler:^(NSError *error, NSDictionary *resultsDictionary) {
                                               NSLog(@"We have returned to the Sample Application");
                                               
                                               if (error) {
                                                   NSLog(@"There was an error with the GET Request - %@", error.localizedDescription);
                                               }
                                               
                                               if (resultsDictionary) {
                                                   NSLog(@"Weather Dictionary - %@", resultsDictionary);
                                               }
                                           }];
    }
}

- (IBAction)onPOSTWeatherButtonPressed:(id)sender {
    NSURL *urlRequest = [NSURL URLWithString:[NSString stringWithFormat:@"%@", globalWeatherAPIURL]];
    
    NSDictionary *postDictionary = @{@"CityName"   : @"tustin",
                                     @"CountryName": @"us"};
    
    [[KERSessionManager sharedInstance] POSTRequestForURL:urlRequest
                                           withDictionary:postDictionary
                                        completionHandler:^(NSError *error, NSDictionary *resultsDictionary) {
                                            NSLog(@"We have returned to the Sample Application");
                                            
                                            if (error) {
                                                NSLog(@"There was an error with the POST Request - %@", error.localizedDescription);
                                            }
                                            
                                            if (resultsDictionary) {
                                                NSLog(@"Weather Dictionary - %@", resultsDictionary);
                                            }
                                        }];
}

@end
