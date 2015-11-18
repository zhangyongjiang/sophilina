//
//  WebService.m
//  NextShopperSwift
//
//  Created by Kevin Zhang on 10/17/14.
//  Copyright (c) 2014 Kevin Zhang. All rights reserved.
//

#import "WebService.h"
#import "ObjectMapper.h"
#import "SVProgressHUD.h"
#import "TMCache.h"

static WebService* instance;
static BOOL useLocalHost = NO;
static BOOL useStaging = NO;

@interface WebService()

@property(strong, nonatomic)MyOperationManager* operationManager;

@end

@implementation WebService

+(void)load {
    [self loadCookies];
    instance = [[WebService alloc] init];
}

+(MyOperationManager*)getOperationManager {
    return instance.operationManager;
}

+ (NSString *)baseUrl
{
    if (useLocalHost) {
        return @"http://localhost:9090";
    }
    else if(useStaging){
        return @"http://api.onsalelocal.com";
    }
    else {
        return @"http://sophilina.com/sophilina";
    }
}

+(void)switchServer {
    useStaging = !useStaging;
    instance = [[WebService alloc] init];
    [self UserAPI_Logout:^(GenericResponse *resp) {
        [[AppDelegate getInstance] startWelcomePage:NO];
    } onError:^(APIError *err) {
    }];
}

+ (void)saveCookies{
    NSData *savecookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: savecookiesData forKey: @"sessionCookies"];
    [defaults synchronize];
}

+ (void)loadCookies{
    NSArray *loadcookiesarray = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie * c in loadcookiesarray){
        NSLog(@"=== cookie %@", c);
        [cookieStorage setCookie: c];
    }
}

+ (void)removeAllCookies{
    NSArray *loadcookiesarray = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"sessionCookies"]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie * c in loadcookiesarray){
        [cookieStorage deleteCookie: c];
    }
    [self saveCookies];
}

-(id)init {
    self = [super init];

    MyOperationManager *manager = [[MyOperationManager alloc] initWithBaseURL:[NSURL URLWithString:[WebService baseUrl]]];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    manager.requestSerializer.timeoutInterval = 15;
    
    self.operationManager = manager;

    return self;
}

+ (void)showError:(NSError *)err withOperation:(AFHTTPRequestOperation *)operation {
    NSString* data = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
    NSString* errStr = [NSString stringWithFormat:@"%@ %@", err.description, data];
    NSLog(@"%@", errStr);
    APIError* apiError = [[APIError alloc] initWithOperation:operation andError:err];
    if ([operation.response statusCode] == 540) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNoGuest object:nil];
    }
    else {
        if (apiError.errorMsg) {
            errStr = [NSString stringWithFormat:@"%@\n%@", apiError.errorCode, apiError.errorMsg];
        }
        else {
            errStr = [NSString stringWithFormat:@"%@", apiError.errorCode];
        }
//        [[[iToast makeText:errStr] setGravity:iToastGravityBottom] show];
        [[AppDelegate getInstance] alertWithTitle:@"Oops" andMsg:errStr handler:^(UIAlertAction *action) {
        }];
    }
}

+(AFHTTPRequestOperation*)upload:(NSData *)request onSuccess:(void (^)(Resource *))successBlock onError:(void (^)(APIError *))errorBlock {
    return [self upload:request toPath:@"ws/resource/upload-for-user" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                             options:kNilOptions
                                                               error:&error];
        ObjectMapper *mapper = [ObjectMapper mapper];
        Resource* resp = [mapper mapObject:json toClass:[Resource class] withError:&error];
        if (error) {
            errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
        } else {
            successBlock(resp);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString* newStr = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Error: %@", newStr);
        errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
    }];
}

+(AFHTTPRequestOperation*)uploadImage:(NSData *)request forProduct:(NSString*)prodId onSuccess:(void (^)(Product *))successBlock onError:(void (^)(APIError *))errorBlock {
    NSString* path = [NSString stringWithFormat:@"ws/product/add-image/%@", prodId];
    return [self upload:request toPath:path success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                             options:kNilOptions
                                                               error:&error];
        ObjectMapper *mapper = [ObjectMapper mapper];
        Product* resp = [mapper mapObject:json toClass:[Product class] withError:&error];
        if (error) {
            errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
        } else {
            successBlock(resp);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
    }];
}

+(AFHTTPRequestOperation*)uploadUserAvatar:(NSData *)request onSuccess:(void (^)(User *))successBlock onError:(void (^)(APIError *))errorBlock {
    return [self upload:request toPath:@"ws/user/upload-image" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:operation.responseData
                                                             options:kNilOptions
                                                               error:&error];
        ObjectMapper *mapper = [ObjectMapper mapper];
        User* resp = [mapper mapObject:json toClass:[User class] withError:&error];
        if (error) {
            errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
        } else {
            [NSUserDefaults saveUser:resp];
            successBlock(resp);
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMeChanged object:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
    }];
}

+(AFHTTPRequestOperation*)upload:(NSData *)request
                          toPath:(NSString*)path success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    NSData *imageData = [NSData dataWithData:request];
    MyOperationManager *manager = [[MyOperationManager alloc] initWithBaseURL:[NSURL URLWithString:[WebService baseUrl]]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [SVProgressHUD show];
    AFHTTPRequestOperation * requestOperation = [manager POST:path parameters:[NSDictionary dictionaryWithObjectsAndKeys:@"true", @"isImage", nil] constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:imageData name:@"file"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [SVProgressHUD popActivity];
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD popActivity];
        failure(operation, error);
    }];
    
//    [requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        double percentDone = ((double)totalBytesWritten / (double)totalBytesExpectedToWrite) * 100.;
//        NSString* progress = [NSString stringWithFormat:@"%lld bytes of total %lld bytes have been uploaded.", totalBytesWritten, totalBytesExpectedToWrite ];
//        [[iToast makeText:progress] show];
//    }];
    
    return requestOperation;
}

+ (NSURL*)urlWithString:(NSString*)str {
    if([str hasPrefix:@"http"]) {
        return [NSURL URLWithString:str];
    }
    else {
        return [NSURL URLWithString:[NSString stringWithFormat:@"%@/ws/resource/download?path=%@", [WebService baseUrl], str]];
    }
}

+(AFHTTPRequestOperation*)UserAPI_Register:(RegisterRequest *)req onSuccess:(void (^)(User *))successBlock onError:(void (^)(APIError *))errorBlock {
    return [ReuselocalApi UserAPI_Register:req onSuccess:^(User *resp) {
        [WebService saveCookies];
        [NSUserDefaults saveUser:resp];
        [[AppDelegate getInstance] userLoggedIn];

        NSString* token = [NSUserDefaults savedPushNotificationToken];
        if(token) {
            PushNotificationToken *pushReq = [[PushNotificationToken alloc] init];
            pushReq.token = token;
            [ReuselocalApi PushNotificationAPI_RegisterAppleDeviceToken:pushReq onSuccess:^(GenericResponse *pushResp) {
                successBlock(resp);
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMeChanged object:resp];
            } onError:^(APIError *err) {
                successBlock(resp);
            }];
        }
        else {
            successBlock(resp);
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMeChanged object:resp];
        }
    } onError:errorBlock];
}

+(AFHTTPRequestOperation*)UserAPI_Login:(LoginRequest *)req onSuccess:(void (^)(User *))successBlock onError:(void (^)(APIError *))errorBlock {
    return [ReuselocalApi UserAPI_Login:req onSuccess:^(User *resp) {
        [WebService saveCookies];
        [NSUserDefaults saveUser:resp];
        [NSUserDefaults saveEmail:req.email];
        [NSUserDefaults savePassword:req.password];
        [[AppDelegate getInstance] userLoggedIn];
        
        NSString* token = [NSUserDefaults savedPushNotificationToken];
        if(token) {
            PushNotificationToken *pushReq = [[PushNotificationToken alloc] init];
            pushReq.token = token;
            [ReuselocalApi PushNotificationAPI_RegisterAppleDeviceToken:pushReq onSuccess:^(GenericResponse *pushResp) {
                successBlock(resp);
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMeChanged object:resp];
            } onError:^(APIError *err) {
                successBlock(resp);
            }];
        }
        else {
            successBlock(resp);
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMeChanged object:resp];
        }
    } onError:errorBlock];
}

+(AFHTTPRequestOperation*) UserAPI_Update:(UserBasicInfo*)info onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    return [ReuselocalApi UserAPI_Update:info onSuccess:^(User *resp) {
        [WebService saveCookies];
        [NSUserDefaults saveUser:resp];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationMeChanged object:resp];
        successBlock(resp);
    } onError:errorBlock];
}


+(AFHTTPRequestOperation*)UserAPI_Logout:(void (^)(GenericResponse *))successBlock onError:(void (^)(APIError *))errorBlock {
    return [ReuselocalApi UserAPI_Logout:^(GenericResponse *resp) {
        [WebService removeAllCookies];
        [[TMCache sharedCache] removeAllObjects];
        [NSUserDefaults deleteSavedUser];
        [NSUserDefaults remove:@"LoginPassword"];
        successBlock(resp);
        [[AppDelegate getInstance] userLoggedOut];
    } onError:errorBlock];
}

+(void) requestImageWithPath:(NSString*)path complete:(void (^)(UIImage *))complete {
    NSURL* URLString = [WebService urlWithString:path];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:URLString cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];

    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        complete(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(nil);
    }];
    [requestOperation start];
}


+(AFHTTPRequestOperation*) getContentFromUrl:(NSString *)url onSuccess:(void (^)(NSString *))successBlock onError:(void (^)(APIError *))errorBlock {
    [MyOperationManager disableCacheForSeconds:1];
    MyOperationManager *manager = [[MyOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    return [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString* resp = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        successBlock(resp);
    } apiError:^(APIError *error) {
        errorBlock(error);
    }];
}

@end
