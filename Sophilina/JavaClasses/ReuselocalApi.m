#import "ReuselocalApi.h"
#import "ReuselocalApi.h"

@implementation ReuselocalApi

+(AFHTTPRequestOperation*) AdminAPI_SetSuperUser:(NSString*)userId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/admin/set-super-user/{userId}";
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:[userId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) AdminAPI_SuspendUser:(NSString*)userId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/admin/suspend-user/{userId}";
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:[userId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_GetUserMessages:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(MessageDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/msg-list";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(offset) [dict setObject:offset forKey:@"offset"];
    if(size) [dict setObject:size forKey:@"size"];
    return [[WebService getOperationManager] GET:url
	            parameters:dict
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   MessageDetailsList* resp = [mapper mapObject:responseObject toClass:[MessageDetailsList class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_GetSystemMessages:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(MessageDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/msg-list";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(offset) [dict setObject:offset forKey:@"offset"];
    if(size) [dict setObject:size forKey:@"size"];
    return [[WebService getOperationManager] GET:url
	            parameters:dict
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   MessageDetailsList* resp = [mapper mapObject:responseObject toClass:[MessageDetailsList class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_MarkUserMsgAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/mark-as-read/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_MarkAllUserMsgAsRead:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/mark-all-read";
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_MarkUserMsgThreadAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/mark-thread-as-read/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_MarksysMsgAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/mark-as-read/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_MarksysMsgThreadAsRead:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/mark-thread-as-read/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_UserToSystemMessage:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/to-system";
    return [[WebService getOperationManager] POST:url
	            parameters:[msg toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Message* resp = [mapper mapObject:responseObject toClass:[Message class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_SystemToUserMessage:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/system/to-user";
    return [[WebService getOperationManager] POST:url
	            parameters:[msg toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Message* resp = [mapper mapObject:responseObject toClass:[Message class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_DeleteUserMessage:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/delete/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_DeleteUserMessageList:(StringList*)list onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/delete";
    return [[WebService getOperationManager] POST:url
	            parameters:[list toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_DeleteSysMessage:(NSString*)msgId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/delete/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_DeleteSysMessageList:(StringList*)list onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/delete";
    return [[WebService getOperationManager] POST:url
	            parameters:[list toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_DeleteAllUserMessages:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/delete-all";
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_GetUserMessageById:(NSString*)msgId onSuccess:(void (^)(MessageDetails *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   MessageDetails* resp = [mapper mapObject:responseObject toClass:[MessageDetails class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_GetSysMessageById:(NSString*)msgId onSuccess:(void (^)(MessageDetails *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   MessageDetails* resp = [mapper mapObject:responseObject toClass:[MessageDetails class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_GetUserMessageThreadsByMsgId:(NSString*)msgId onSuccess:(void (^)(MessageThread *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/{msgId}/threads";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   MessageThread* resp = [mapper mapObject:responseObject toClass:[MessageThread class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_GetSysMessageThreadsByMsgId:(NSString*)msgId onSuccess:(void (^)(MessageThread *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/{msgId}/threads";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   MessageThread* resp = [mapper mapObject:responseObject toClass:[MessageThread class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_UserReplyMessage:(NSString*)msgId msg:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/user/reply/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:[msg toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Message* resp = [mapper mapObject:responseObject toClass:[Message class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MessageAPI_SysReplyMessage:(NSString*)msgId msg:(Message*)msg onSuccess:(void (^)(Message *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/message/sys/reply/{msgId}";
    url = [url stringByReplacingOccurrencesOfString:@"{msgId}" withString:[msgId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:[msg toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Message* resp = [mapper mapObject:responseObject toClass:[Message class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) MiscAPI_GetSupportedVersion:(void (^)(SupportedVersions *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/misc/supported-versions";
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   SupportedVersions* resp = [mapper mapObject:responseObject toClass:[SupportedVersions class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Remove:(NSString*)productId info:(ProductInfo*)info onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/remove/{productId}";
    url = [url stringByReplacingOccurrencesOfString:@"{productId}" withString:[productId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:[info toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Get:(NSString*)productId onSuccess:(void (^)(ProductDetails *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/{productId}";
    url = [url stringByReplacingOccurrencesOfString:@"{productId}" withString:[productId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   ProductDetails* resp = [mapper mapObject:responseObject toClass:[ProductDetails class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Search:(NSString*)keywords category:(NSString*)category offset:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(ProductDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/search";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(keywords) [dict setObject:keywords forKey:@"keywords"];
    if(category) [dict setObject:category forKey:@"category"];
    if(offset) [dict setObject:offset forKey:@"offset"];
    if(size) [dict setObject:size forKey:@"size"];
    return [[WebService getOperationManager] GET:url
	            parameters:dict
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   ProductDetailsList* resp = [mapper mapObject:responseObject toClass:[ProductDetailsList class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Flag:(FlagRequest*)flagRequest onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/flag";
    return [[WebService getOperationManager] POST:url
	            parameters:[flagRequest toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Update:(NSString*)productId info:(ProductInfo*)info onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/update/{productId}";
    url = [url stringByReplacingOccurrencesOfString:@"{productId}" withString:[productId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:[info toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_CreateProduct:(Product*)prod onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/create";
    return [[WebService getOperationManager] POST:url
	            parameters:[prod toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_RemoveImage:(NSString*)productId imgIndex:(NSNumber*)imgIndex onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/remove-image/{productId}/{imgIndex}";
    url = [url stringByReplacingOccurrencesOfString:@"{productId}" withString:[productId description]];
    url = [url stringByReplacingOccurrencesOfString:@"{imgIndex}" withString:[imgIndex description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Take:(NSString*)productId info:(ProductInfo*)info onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/take/{productId}";
    url = [url stringByReplacingOccurrencesOfString:@"{productId}" withString:[productId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:[info toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_Unflag:(FlagRequest*)flagRequest onSuccess:(void (^)(Product *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/unflag";
    return [[WebService getOperationManager] POST:url
	            parameters:[flagRequest toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Product* resp = [mapper mapObject:responseObject toClass:[Product class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ProductAPI_ListUserProducts:(NSString*)userId onSuccess:(void (^)(ProductDetailsList *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/product/user-product-list";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(userId) [dict setObject:userId forKey:@"userId"];
    return [[WebService getOperationManager] GET:url
	            parameters:dict
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   ProductDetailsList* resp = [mapper mapObject:responseObject toClass:[ProductDetailsList class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_Remove:(NSString*)notificationId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/remove/{notificationId}";
    url = [url stringByReplacingOccurrencesOfString:@"{notificationId}" withString:[notificationId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_Update:(NSString*)token settings:(NotificationSettings*)settings onSuccess:(void (^)(NotificationSettings *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/settings/{token}";
    url = [url stringByReplacingOccurrencesOfString:@"{token}" withString:[token description]];
    return [[WebService getOperationManager] POST:url
	            parameters:[settings toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   NotificationSettings* resp = [mapper mapObject:responseObject toClass:[NotificationSettings class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_RegisterAppleDeviceToken:(PushNotificationToken*)token onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/register/apple-device-token";
    return [[WebService getOperationManager] POST:url
	            parameters:[token toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_RegisterGoogleDeviceToken:(PushNotificationToken*)token onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/register/google-device-token";
    return [[WebService getOperationManager] POST:url
	            parameters:[token toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_UpdatePushNotificationSetting:(NotificationSettings*)settings onSuccess:(void (^)(NotificationSettings *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/update-settings/";
    return [[WebService getOperationManager] POST:url
	            parameters:[settings toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   NotificationSettings* resp = [mapper mapObject:responseObject toClass:[NotificationSettings class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_SendNotification:(Notification*)notification onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/send";
    return [[WebService getOperationManager] POST:url
	            parameters:[notification toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_ListUserNotifications:(NSNumber*)offset size:(NSNumber*)size onSuccess:(void (^)(NotificationList *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/mine";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(offset) [dict setObject:offset forKey:@"offset"];
    if(size) [dict setObject:size forKey:@"size"];
    return [[WebService getOperationManager] GET:url
	            parameters:dict
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   NotificationList* resp = [mapper mapObject:responseObject toClass:[NotificationList class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_GetNotificationById:(NSString*)notificationId onSuccess:(void (^)(Notification *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/{notificationId}";
    url = [url stringByReplacingOccurrencesOfString:@"{notificationId}" withString:[notificationId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   Notification* resp = [mapper mapObject:responseObject toClass:[Notification class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) PushNotificationAPI_MarkAsRead:(NSString*)notificationId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/push-notification/mark-as-read/{notificationId}";
    url = [url stringByReplacingOccurrencesOfString:@"{notificationId}" withString:[notificationId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ResourceAPI_ListUserResources:(void (^)(ResourceList *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/resource/list-user-resources";
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   ResourceList* resp = [mapper mapObject:responseObject toClass:[ResourceList class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) ResourceAPI_DeleteRedource:(NSString*)resourceId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/resource/delete/{resourceId}";
    url = [url stringByReplacingOccurrencesOfString:@"{resourceId}" withString:[resourceId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_Register:(RegisterRequest*)req onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/register";
    return [[WebService getOperationManager] POST:url
	            parameters:[req toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   User* resp = [mapper mapObject:responseObject toClass:[User class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_Update:(UserBasicInfo*)info onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/update-profile";
    return [[WebService getOperationManager] POST:url
	            parameters:[info toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   User* resp = [mapper mapObject:responseObject toClass:[User class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_Login:(NSString*)email password:(NSString*)password onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/login";
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    if(email) [dict setObject:email forKey:@"email"];
    if(password) [dict setObject:password forKey:@"password"];
    return [[WebService getOperationManager] GET:url
	            parameters:dict
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   User* resp = [mapper mapObject:responseObject toClass:[User class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_Login:(LoginRequest*)req onSuccess:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/login";
    return [[WebService getOperationManager] POST:url
	            parameters:[req toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   User* resp = [mapper mapObject:responseObject toClass:[User class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_Logout:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/logout";
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_SetAsAgent:(NSString*)agentId onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/set-as-agent/{agentId}";
    url = [url stringByReplacingOccurrencesOfString:@"{agentId}" withString:[agentId description]];
    return [[WebService getOperationManager] POST:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_GetUserDetails:(NSString*)userId onSuccess:(void (^)(UserInfo *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/profile/{userId}";
    url = [url stringByReplacingOccurrencesOfString:@"{userId}" withString:[userId description]];
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   UserInfo* resp = [mapper mapObject:responseObject toClass:[UserInfo class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_ResetPassword:(LoginRequest*)req onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/reset-password";
    return [[WebService getOperationManager] POST:url
	            parameters:[req toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_ChangePassword:(ChangePasswordRequest*)req onSuccess:(void (^)(GenericResponse *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/change-password";
    return [[WebService getOperationManager] POST:url
	            parameters:[req toDictionary]
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   GenericResponse* resp = [mapper mapObject:responseObject toClass:[GenericResponse class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}

+(AFHTTPRequestOperation*) UserAPI_Me:(void (^)(User *resp))successBlock onError:(void (^)(APIError *err))errorBlock {
    NSString* url = @"ws/user/me";
    return [[WebService getOperationManager] GET:url
	            parameters:nil
	               success:^(AFHTTPRequestOperation *operation, id responseObject) {
	                   ObjectMapper *mapper = [ObjectMapper mapper];
	                   NSError *error;
	                   User* resp = [mapper mapObject:responseObject toClass:[User class] withError:&error];
	                   if (error) {
	                       errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	                   } else { 
	                       successBlock(resp);
	                   }
	               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
	                   errorBlock([[APIError alloc] initWithOperation:operation andError:error]);
	               }];
}


@end
