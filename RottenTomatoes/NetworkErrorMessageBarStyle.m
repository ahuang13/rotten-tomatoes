//
//  NetworkErrorMessageBarStyle.m
//  RottenTomatoes
//
//  Created by Angus Huang on 1/21/14.
//  Copyright (c) 2014 Angus Huang. All rights reserved.
//

#import "NetworkErrorMessageBarStyle.h"

@implementation NetworkErrorMessageBarStyle

- (UIColor *)backgroundColorForMessageType:(TWMessageBarMessageType)type
{
    return nil;
}

- (UIColor *)strokeColorForMessageType:(TWMessageBarMessageType)type
{
    return nil;
}

- (UIImage *)iconImageForMessageType:(TWMessageBarMessageType)type
{
    return [UIImage imageNamed:@"WarningIcon"];
}

@end
