#import "AFHTTPRequestOperationManager.h"
#import "APIError.h"

@interface MyOperationManager : AFHTTPRequestOperationManager

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        apiError:(void (^)(APIError* error))apiError;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         apiError:(void (^)(APIError*error))apiError;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
       constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        apiError:(void (^)(APIError* error))apiError;

+(void)disableCacheForSeconds:(double)seconds;

@end
