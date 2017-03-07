//
//  KERSessionManager.h
//  KERSessionManager
//
//  Created by Kevin E. Rafferty on 3/3/17.
//  Copyright © 2017 Quiver Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for KERSessionManager.
FOUNDATION_EXPORT double KERSessionManagerVersionNumber;

//! Project version string for KERSessionManager.
FOUNDATION_EXPORT const unsigned char KERSessionManagerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <KERSessionManager/PublicHeader.h>

@interface KERSessionManager : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)sharedInstance;

/**
 This method with take a constructed URL and perform a GET request for data.

 @param urlRequest An NSURL object containing the GET request URL
 */
- (void)GETRequestForURL:(NSURL *)urlRequest
       completionHandler:(void (^)(NSError *error, NSDictionary *resultsDictionary))completionHandler;

/**
 This method with take a constructed URL and perform a POST request for data.
 
 @param urlRequest An NSURL object containing the POST request URL
 */
- (void)POSTRequestForURL:(NSURL *)urlRequest
           withDictionary:(NSDictionary *)dictionary
        completionHandler:(void (^)(NSError *error, NSDictionary *resultsDictionary))completionHandler;

@end
