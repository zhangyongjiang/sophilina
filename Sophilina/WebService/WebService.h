//
//  WebService.h
//  NextShopperSwift
//
//  Created by Kevin Zhang on 10/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MyOperationManager.h"
#import "User.h"
#import "Resource.h"
#import "Product.h"
#import "RegisterRequest.h"
#import "LoginRequest.h"
#import "GenericResponse.h"
#import "APIError.h"

@interface WebService : NSObject

+ (NSString *)baseUrl;
+ (MyOperationManager*)getOperationManager;
+ (void)saveCookies;
+ (void)loadCookies;
+ (void)removeAllCookies;
+ (void)showError:(NSError*)err withOperation:(AFHTTPRequestOperation*)operation;
+ (void)switchServer;

+(AFHTTPRequestOperation*) UserAPI_Register:(RegisterRequest*)req onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Login:(LoginRequest*)req onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Logout:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Update:(UserBasicInfo*)info onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*)upload:(NSData *)request onSuccess:(void (^)(Resource *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*)uploadUserAvatar:(NSData *)request onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+ (NSURL*)urlWithString:(NSString*)str;

+(void) requestImageWithPath:(NSString*)path complete:(void (^)(UIImage *))complete;

+(AFHTTPRequestOperation*) getContentFromUrl:(NSString*)url onSuccess:(void (^)(NSString *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*)uploadImage:(NSData *)request forProduct:(NSString*)prodId onSuccess:(void (^)(Product *))successBlock onError:(void (^)(APIError *))errorBlock ;

@end
