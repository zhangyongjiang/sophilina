//
//  APIError.h
//
//
//  Created by Kevin Zhang on 12/31/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface APIError : NSObject

@property(strong,nonatomic)NSString* errorCode;
@property(strong,nonatomic)NSString* stack;
@property(strong,nonatomic)NSString* errorMsg;
@property(assign,nonatomic)NSInteger statusCode;
@property(assign,nonatomic)BOOL processed;

-(id)initWithOperation:(AFHTTPRequestOperation*)operation andError:(NSError *)error;

-(BOOL)isUnknown;
-(BOOL)isInvalidInput;
-(BOOL)isInvalidPassword;
-(BOOL)isDuplicated;
-(BOOL)isNoGuest;
-(BOOL)isPermissionDenied;
-(BOOL)isNotFound;
-(BOOL)isStoreExists;
-(BOOL)isNoInventory;
-(BOOL)isInvalidStatus;
-(BOOL)isBillingError;
-(BOOL)isInvalidJson;
-(BOOL)isInvalidId;
-(BOOL)isUserHasNoStore;
-(BOOL)isNoStoreOwner;
-(BOOL)isSmsError;
-(BOOL)isReauthenticationError;


@end
