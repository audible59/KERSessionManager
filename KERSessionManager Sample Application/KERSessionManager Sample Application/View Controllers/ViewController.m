//
//  ViewController.m
//  KERSessionManager Sample Application
//
//  Created by Kevin E. Rafferty on 3/3/17.
//  Copyright © 2017 Quiver Coding. All rights reserved.
//

#import "ViewController.h"

static const NSString *weatherAPIKey = @"72c543337934d7aa4934b1bed8e5ca18";

@interface ViewController ()

#pragma mark - Private Properties -

@property (weak, nonatomic) IBOutlet UIButton *getWeatherButton;

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

#pragma mark - Private Methods -

- (void)GETRequestForURL:(NSURL *)urlRequest;

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
        NSURL *urlRequest = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?zip=%@,us&APPID=%@", zipCode, weatherAPIKey]];
        
        [self GETRequestForURL:urlRequest];
    }
}

- (void)GETRequestForURL:(NSURL *)urlRequest {
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:urlRequest
                                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                     if (error == nil) {
                                                                         
                                                                     } else {
                                                                         NSLog(@"There was an error reaching the Open Weather Map API - %@", error.localizedDescription);
                                                                     }
                                                                 }];
    
    [dataTask resume];
}

@end
