#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "APIError.h"
#import "WebService.h"
#import "GenericResponse.h"
#import "MessageDetailsList.h"
#import "Message.h"
#import "StringList.h"
#import "MessageDetails.h"
#import "MessageThread.h"
#import "SupportedVersions.h"
#import "Product.h"
#import "ProductInfo.h"
#import "ProductDetails.h"
#import "ProductDetailsList.h"
#import "FlagRequest.h"
#import "NotificationSettings.h"
#import "PushNotificationToken.h"
#import "Notification.h"
#import "NotificationList.h"
#import "ResourceList.h"
#import "User.h"
#import "RegisterRequest.h"
#import "UserBasicInfo.h"
#import "ChangePasswordRequest.h"
#import "LoginRequest.h"
#import "UserInfo.h"

@interface ReuselocalApi : NSObject

+(AFHTTPRequestOperation*) AdminAPI_SetSuperUser:(NSString*)userId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) AdminAPI_SuspendUser:(NSString*)userId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_GetUserMessages:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(MessageDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_GetSystemMessages:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(MessageDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_MarkUserMsgAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_MarkAllUserMsgAsRead:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_MarkUserMsgThreadAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_MarksysMsgAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_MarksysMsgThreadAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_UserToSystemMessage:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_SystemToUserMessage:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_DeleteUserMessage:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_DeleteUserMessageList:(StringList*)list onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_DeleteSysMessage:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_DeleteSysMessageList:(StringList*)list onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_DeleteAllUserMessages:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_GetUserMessageById:(NSString*)msgId onSuccess:(void (^)(MessageDetails *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_GetSysMessageById:(NSString*)msgId onSuccess:(void (^)(MessageDetails *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_GetUserMessageThreadsByMsgId:(NSString*)msgId onSuccess:(void (^)(MessageThread *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_GetSysMessageThreadsByMsgId:(NSString*)msgId onSuccess:(void (^)(MessageThread *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_UserReplyMessage:(NSString*)msgId msg:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MessageAPI_SysReplyMessage:(NSString*)msgId msg:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) MiscAPI_GetSupportedVersion:(void (^)(SupportedVersions *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Remove:(NSString*)productId info:(ProductInfo*)info onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Get:(NSString*)productId onSuccess:(void (^)(ProductDetails *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Search:(NSString*)keywords category:(NSString*)category offset:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(ProductDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Flag:(FlagRequest*)flagRequest onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Update:(NSString*)productId info:(ProductInfo*)info onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_CreateProduct:(Product*)prod onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_RemoveImage:(NSString*)productId imgIndex:(NSNumber*)imgIndex onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Take:(NSString*)productId info:(ProductInfo*)info onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Unflag:(FlagRequest*)flagRequest onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ProductAPI_Mine:(void (^)(ProductDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_Remove:(NSString*)notificationId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_Update:(NSString*)token settings:(NotificationSettings*)settings onSuccess:(void (^)(NotificationSettings *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_RegisterAppleDeviceToken:(PushNotificationToken*)token onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_RegisterGoogleDeviceToken:(PushNotificationToken*)token onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_UpdatePushNotificationSetting:(NotificationSettings*)settings onSuccess:(void (^)(NotificationSettings *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_SendNotification:(Notification*)notification onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_ListUserNotifications:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(NotificationList *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_GetNotificationById:(NSString*)notificationId onSuccess:(void (^)(Notification *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) PushNotificationAPI_MarkAsRead:(NSString*)notificationId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ResourceAPI_ListUserResources:(void (^)(ResourceList *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) ResourceAPI_DeleteRedource:(NSString*)resourceId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Register:(RegisterRequest*)req onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Update:(UserBasicInfo*)info onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Me:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_ChangePassword:(ChangePasswordRequest*)req onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_ResetPassword:(LoginRequest*)req onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_SetAsAgent:(NSString*)agentId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_GetUserDetails:(NSString*)userId onSuccess:(void (^)(UserInfo *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Login:(NSString*)email password:(NSString*)password onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Login:(LoginRequest*)req onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock;

+(AFHTTPRequestOperation*) UserAPI_Logout:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock;


@end
