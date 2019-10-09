//
//  BBPost.m
//  RedditStarteriOS29
//
//  Created by Bethany Wride on 10/9/19.
//  Copyright © 2019 Darin Armstrong. All rights reserved.
//

#import "BBPost.h"

static NSString * const kTitle = @"title";
static NSString * const kThumbnail = @"thumbnail";

@implementation BBPost

- (BBPost *)initWithTitle:(NSString *)title thumbnail:(NSString *)thumbnail
{
    // Initialize superclass (NSObject)
    self = [super init];
    if (self)
    {
        _title = title;
        _thumbnail = thumbnail;
    }
    return self;
}
@end

@implementation BBPost (JSONConvertable)

- (BBPost *)initWithDictionary:(NSDictionary<NSString *,id> *)dictionary
{
    // Keys to initialize
    NSString *title = dictionary[kTitle];
    NSString *thumbnail = dictionary[kThumbnail];
    return [self initWithTitle:title thumbnail:thumbnail];
}

@end
