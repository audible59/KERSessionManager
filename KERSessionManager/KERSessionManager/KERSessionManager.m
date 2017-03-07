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
       completionHandler:(void (^)(NSError *error, NSDictionary *resultsDictionary))completionHandler {
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
                                                                                         completionHandler(nil, jsonDictionary);
                                                                                     }];
                                                                                 }
                                                                             } else {
                                                                                 NSLog(@"There was an error parsing the JSON data object - %@", jsonError.localizedDescription);
                                                                                 
                                                                                 [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                                     completionHandler(jsonError, nil);
                                                                                 }];
                                                                             }
                                                                             
                                                                             
                                                                         } else {
                                                                             NSLog(@"There was an error reaching the Open Weather Map API - %@", error.localizedDescription);
                                                                             
                                                                             [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                                 completionHandler(error, nil);
                                                                             }];
                                                                         }
                                                                     }];
        
        [dataTask resume];
    }];
}

- (void)POSTRequestForURL:(NSURL *)urlRequest
           withDictionary:(NSDictionary *)dictionary
        completionHandler:(void (^)(NSError *error, NSDictionary *resultsDictionary))completionHandler {
    NSOperationQueue *uploadTaskQueue = [[NSOperationQueue alloc] init];
    
    [uploadTaskQueue addOperationWithBlock:^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlRequest];
        request.HTTPMethod = @"POST";
        
        NSError *postDataError = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:kNilOptions
                                                         error:&postDataError];
        
        if (postDataError == nil) {
            NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                                       fromData:data
                                                              completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                                  if (error == nil) {
                                                                      NSError *jsonError = nil;
                                                                      
                                                                      // Parse the JSON data object
                                                                      id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                      options:NSJSONReadingAllowFragments
                                                                                                                        error:&jsonError];
                                                                      
                                                                      if (jsonError == nil) {
                                                                          if ([jsonObject isKindOfClass:[NSArray class]]) {
                                                                              
                                                                          } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                                                                              NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                                                                              
                                                                              [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                                  completionHandler(nil, jsonDictionary);
                                                                              }];
                                                                          }
                                                                      } else {
                                                                          NSLog(@"There was an error parsing the JSON data object - %@", jsonError.localizedDescription);
                                                                          
                                                                          [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                              completionHandler(jsonError, nil);
                                                                          }];
                                                                      }
                                                                      
                                                                      
                                                                  } else {
                                                                      NSLog(@"There was an error reaching the Global Weather API - %@", error.localizedDescription);
                                                                      
                                                                      [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                                          completionHandler(error, nil);
                                                                      }];
                                                                  }
                                                              }];
            
            [uploadTask resume];
        }
    }];
}

@end
