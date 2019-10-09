//
//  BBPostController.h
//  RedditStarteriOS29
//
//  Created by Bethany Wride on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBPost.h"

NS_ASSUME_NONNULL_BEGIN

@interface BBPostController : NSObject

// Source of truth
@property (nonatomic, copy) NSArray<BBPost *>*posts;

// Singleton
+(instancetype)sharedInstance;

// Fetch posts
-(void)fetchPosts:(void (^)(BOOL))completion;

// Fetch images
-(void)fetchImageForPost:(BBPost *)post completion:(void (^) (UIImage *_Nullable))completion;

@end

NS_ASSUME_NONNULL_END
