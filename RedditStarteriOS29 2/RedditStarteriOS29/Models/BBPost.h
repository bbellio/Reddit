//
//  BBPost.h
//  RedditStarteriOS29
//
//  Created by Bethany Wride on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBPost : NSObject

@property(nonatomic, copy, readonly, nonnull)NSString *title;
@property(nonatomic, copy, readonly, nullable)NSString* thumbnail;

// could also be -(BBPost *)/(instancetype)
-(BBPost *)initWithTitle:(NSString *)title
                     thumbnail:(NSString *)thumbnail;

@end

@interface BBPost (JSONConvertable)

-(BBPost *)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end

NS_ASSUME_NONNULL_END
