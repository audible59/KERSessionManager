//
//  KERSessionManager.m
//  KERSessionManager
//
//  Created by Kevin E. Rafferty on 3/3/17.
//  Copyright © 2017 Quiver Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KERSessionManager.h"

@implementation KERSessionManager

#pragma mark - Singleton Method -

+ (instancetype)sharedInstance {
    static KERSessionManager *sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - Initializer Method -

- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Public API -

- (void)GETRequestForURL:(NSURL *)urlRequest
       completionHandler:(void (^)(NSDictionary *resultsDictionary))completionHandler {
    NSOperationQueue *dataTaskQueue = [[NSOperationQueue alloc] init];
    
    [dataTaskQueue addOperationWithBlock:^{
        NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:urlRequest
                                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                         if (error == nil) {
                                                                             NSError *jsonError = nil;
                                                                             
                                                                             // Parse the JSON data object
                                                                             id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                             options:0
                                                                                                                               error:&jsonError];
                                                                             
                                                                             if (jsonError == nil) {
                                                                                 if ([jsonObject isKindOfClass:[NSArray class]]) {
                                                                                     
                                                                                 } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                                                                                     NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                                                                                     
                                                                                     [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                                         completionHandler(jsonDictionary);
                                                                                     }];
                                                                                 }
                                                                             } else {
                                                                                 NSLog(@"There was an error parsing the JSON data object - %@", jsonError.localizedDescription);
                                                                             }
                                                                             
                                                                             
                                                                         } else {
                                                                             NSLog(@"There was an error reaching the Open Weather Map API - %@", error.localizedDescription);
                                                                         }
                                                                     }];
        
        [dataTask resume];
    }];
}

@end
