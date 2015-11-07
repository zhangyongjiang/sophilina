//
//  APIError.m
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "APIError.h"

@implementation APIError

-(id)initWithOperation:(AFHTTPRequestOperation *)operation andError:(NSError *)error {
    self = [super init];
    self.statusCode = [operation.response statusCode];
    if (self.statusCode == 500) {
        self.errorCode = @"System Error";
        self.errorMsg = @"Please report to NextShopper. Thanks.";
    }
    else if (operation.responseObject && [operation.responseObject respondsToSelector:@selector(objectForKey:)]) {
        self.errorCode = [operation.responseObject objectForKey:@"errorCode"];
        self.errorMsg = [operation.responseObject objectForKey:@"errorMsg"];
    }
    else if([@"NSURLErrorDomain" isEqualToString:error.domain]) {
        if(error.code == -1009) {
            self.errorCode = @"No Internet Connectivity";
            self.errorMsg = @"Please check your network connection.";
        }
        else if(error.code == -1001) {
            self.errorCode = @"Request Timeout";
            self.errorMsg = @"Please try later";
        }
    }
    else {
        self.errorCode = @"Unknown Error";
        self.errorMsg = [NSString stringWithFormat:@"%@", operation.response];
    }
    return self;
}

-(NSString*)description {
    if (self.errorMsg) {
        return [NSString stringWithFormat:@"%@\n%@", self.errorCode, self.errorMsg];
    }
    else
        return [NSString stringWithFormat:@"%@", self.errorCode];

}

-(BOOL)isUnknown{
    return [self.errorCode isEqualToString:@"Unknown"];
}

-(BOOL)isInvalidInput{
    return [self.errorCode isEqualToString:@"InvalidInput"];
}

-(BOOL)isInvalidPassword{
    return [self.errorCode isEqualToString:@"InvalidPassword"];
}

-(BOOL)isDuplicated{
    return [self.errorCode isEqualToString:@"Duplicated"];
}

-(BOOL)isNoGuest{
    return [self.errorCode isEqualToString:@"NoGuest"];
}

-(BOOL)isPermissionDenied{
    return [self.errorCode isEqualToString:@"PermissionDenied"];
}

-(BOOL)isNotFound{
    return [self.errorCode isEqualToString:@"NotFound"];
}

-(BOOL)isStoreExists{
    return [self.errorCode isEqualToString:@"StoreExists"];
}

-(BOOL)isNoInventory{
    return [self.errorCode isEqualToString:@"NoInventory"];
}

-(BOOL)isInvalidStatus{
    return [self.errorCode isEqualToString:@"InvalidStatus"];
}

-(BOOL)isBillingError{
    return [self.errorCode isEqualToString:@"BillingError"];
}

-(BOOL)isInvalidJson{
    return [self.errorCode isEqualToString:@"InvalidJson"];
}

-(BOOL)isInvalidId{
    return [self.errorCode isEqualToString:@"InvalidId"];
}

-(BOOL)isUserHasNoStore{
    return [self.errorCode isEqualToString:@"UserHasNoStore"];
}

-(BOOL)isNoStoreOwner{
    return [self.errorCode isEqualToString:@"NoStoreOwner"];
}

-(BOOL)isSmsError{
    return [self.errorCode isEqualToString:@"SmsError"];
}

-(BOOL)isReauthenticationError{
    return [self.errorCode isEqualToString:@"ReauthenticationError"];
}

@end
