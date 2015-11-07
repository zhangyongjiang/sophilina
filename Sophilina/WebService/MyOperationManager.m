#import "MyOperationManager.h"
#import "SVProgressHUD.h"
#import "TMCache.h"

static double nocacheTillSecond = 0;

@implementation MyOperationManager

+(void)load {
//    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHue:0.1 saturation:0.1 brightness:0.1 alpha:0.1]];
    [SVProgressHUD setForegroundColor:[UIColor colorFromRGB:0xe6383e]];
    [SVProgressHUD setRingThickness:2.5];
    CGFloat height = [UIView screenHeight];
//    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, height/2-8)];
}

+(void)disableCacheForSeconds:(double)seconds {
    nocacheTillSecond = CFAbsoluteTimeGetCurrent() + seconds;
    NSLog(@"disable cache till %f", (double)nocacheTillSecond);
}
+(BOOL)isCacheDisabled {
    return CFAbsoluteTimeGetCurrent() < nocacheTillSecond;
}

- (NSString *)getKeyWithParemeters:(id)parameters withUrlString:(NSString *)URLString
{
    return [[NSString stringWithFormat:@"%@?%@",URLString,parameters] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

- (AFHTTPRequestOperation*)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success apiError:(void (^)(APIError*))failure
{
    BOOL cacheDisabled = [MyOperationManager isCacheDisabled];
    NSString * key = [self getKeyWithParemeters:parameters withUrlString:URLString];
    __block BOOL gotRealResult = NO;
    if (!cacheDisabled) {
        [[TMCache sharedCache] objectForKey:key block:^(TMCache *cache, NSString *key, id object) {
            if (object) {
                
                double delayInSeconds = 2.0;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));

//                dispatch_after(popTime,
                dispatch_async(
                               dispatch_get_main_queue(), ^
                               {
                                   if (!gotRealResult) {
                                       success(nil, object);
                                       NSLog(@":)");
                                   }
                                   else {
                                       NSLog(@"(..)");
                                   }
                               });
                
            }
        }];
    }
    else {
        NSLog(@"skip cache");
    }
    
    [SVProgressHUD show];
    AFHTTPRequestOperation *operation = [super GET:URLString parameters:parameters
                                           success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                               gotRealResult = YES;
                                               [SVProgressHUD popActivity];
                                               dispatch_async(dispatch_get_main_queue(), ^
                                                              {
                                                                  success(operation, responseObject);
                                                              });
                                               [[TMCache sharedCache] setObject:responseObject forKey:key];
                                           }
                                           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                               [SVProgressHUD popActivity];
                                               
                                               APIError* apiError = [[APIError alloc] initWithOperation:operation andError:error];
                                               failure(apiError);
                                               if (!apiError.processed) {
                                                   [WebService showError:error withOperation:operation];
                                               }
    }];
    
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         apiError:(void (^)(APIError* error))failure
{
    NSLog(@"request: %@ with data: %@", URLString, parameters);
    BOOL cacheDisabled = [MyOperationManager isCacheDisabled];
    if (!cacheDisabled) {
        [SVProgressHUD show];
    }
    AFHTTPRequestOperation *operation = [super POST:URLString parameters:parameters
                                            success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                if (!cacheDisabled) {
                                                    [SVProgressHUD popActivity];
                                                }
                                                success(operation, responseObject);
                                            }
                                            failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                if (!cacheDisabled) {
                                                    [SVProgressHUD popActivity];
                                                }
                                                
                                                APIError* apiError = [[APIError alloc] initWithOperation:operation andError:error];
                                                failure(apiError);
                                                if (!apiError.processed) {
                                                    [WebService showError:error withOperation:operation];
                                                }
    }];
    return operation;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         apiError:(void (^)(APIError* error))failure
{
    [SVProgressHUD show];
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:block
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   [SVProgressHUD popActivity];
                   success(operation, responseObject);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   [SVProgressHUD popActivity];
                   APIError* apiError = [[APIError alloc] initWithOperation:operation andError:error];
                   failure(apiError);
                   if (!apiError.processed) {
                       [WebService showError:error withOperation:operation];
                   }
               }];
}

-(void)checkError:(AFHTTPRequestOperation*) operation {
    if (operation.responseObject && [operation respondsToSelector:@selector(objectForKey:)]) {
        NSString* errorCode = [operation.responseObject objectForKey:@"ErrorCode"];
        if ([errorCode isEqualToString:@"NoGuest"]) {
//            NSString* email = [NSUserDefaults savedEmail];
//            NSString* password = [NSUserDefaults savedEmail];
//            if (email && password) {
//                [ReuselocalApi UserAPI_Login:email password:password onSuccess:^(User *resp) {
//                    
//                } onError:^(APIError *err) {
//                    if ([errorCode isEqualToString:@"InvalidPassword"]) {
//                        [NSUserDefaults removeSavedEmail];
//                        [NSUserDefaults removeSavedPassword];
//                    }
//                }];
//            }
//            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNoGuest object:nil];
            [AppDelegate getInstance];
        }
    }
}

@end
