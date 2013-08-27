//
//  U.m
//  eInteract
//
//  Created by Mohsin Khan on 26/08/13.
//  Copyright (c) 2013 Codefrux Training. All rights reserved.
//

#import "U.h"

@implementation U

+(void)showErrorMessage:(NSString *)message{
    UIAlertView *errorAlert = [[UIAlertView alloc] init];
    [errorAlert setTitle:@""];
    [errorAlert setMessage:message];
    [errorAlert setDelegate:self];
    [errorAlert addButtonWithTitle:@"Ok"];
    [errorAlert show];
}

+(void)showErrorMessage:(NSString *)message  withTitle:(NSString *)title withButtonText:(NSString *)buttonText{
    UIAlertView *errorAlert = [[UIAlertView alloc] init];
    [errorAlert setTitle:title];
    [errorAlert setMessage:message];
    [errorAlert setDelegate:self];
    [errorAlert addButtonWithTitle:buttonText];
    [errorAlert show];
}

@end
