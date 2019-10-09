//
//  BBPostController.m
//  RedditStarteriOS29
//
//  Created by Bethany Wride on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "BBPostController.h"


static NSString * const kBaseURLString = @"https://www.reddit.com";
static NSString * const kRComponentString = @"r";
static NSString * const kFunnyComponent = @"funny";
static NSString * const kJSONExtension = @"json";
@implementation BBPostController

+ (instancetype)sharedInstance
{
    static BBPostController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [BBPostController new];
    });
    return sharedInstance;
}

- (void)fetchPosts:(void (^)(BOOL))completion
{
    NSURL *baseURL = [NSURL URLWithString:kBaseURLString];
    NSURL *rURL = [baseURL URLByAppendingPathComponent:kRComponentString];
    NSURL *funnyURL = [rURL URLByAppendingPathComponent:kFunnyComponent];
    NSURL *finalURL = [funnyURL URLByAppendingPathExtension:kJSONExtension];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            // Set a BOOL completion, so complete with false
            completion(false);
            return;
        }
        if (response)
        {
            // DO NOT PUT ANYTHING UNDER THE RESPONSE OR IT WILL BREAK
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"No data");
            completion(false);
            return;
        }
        
        if (data)
        {
            // Top level dictionary
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (error)
            {
                NSLog(@"Error parsing JSON data: %@", error.localizedDescription);
                completion(false);
                return;
            }
            // Level 2 - subscript at the key
            NSDictionary *dataDictionary = topLevelDictionary[@"data"];
            // Array of dictionaries - parse down
            NSArray<NSDictionary *>*childrenArray = dataDictionary[@"children"];
            // Placeholder for Posts once serialized
            NSMutableArray *arrayOfPosts = [NSMutableArray new];
            for (NSDictionary *childDictionary in childrenArray)
            {
                NSDictionary *dataDictionary = childDictionary[@"data"];
                BBPost *post = [[BBPost alloc] initWithDictionary:dataDictionary];
                [arrayOfPosts addObject:post];
            }
            if (arrayOfPosts.count != 0)
            {
                BBPostController.sharedInstance.posts = arrayOfPosts;
                completion(true);
            } else {
                completion(false);
            }
            
        }
    }]resume];
       
} // End of function

- (void)fetchImageForPost:(BBPost *)post completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *imageURL = [NSURL URLWithString:post.thumbnail];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        
//      Guard against data - if (!data)
        if (data)
        {
            UIImage *thumbnail = [UIImage imageWithData:data];
            completion(thumbnail);
        }
    }]resume];
    
}  // End of function

@end
