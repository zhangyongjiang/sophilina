#import "Data.h"

@interface Resource : Data

@property(strong, nonatomic) NSString* ownerId;
@property(strong, nonatomic) NSString* operatorId;
@property(strong, nonatomic) NSString* title;
@property(strong, nonatomic) NSString* _description;
@property(strong, nonatomic) NSString* fileName;
@property(strong, nonatomic) NSString* contentType;
@property(strong, nonatomic) NSString* path;
@property(strong, nonatomic) NSNumber* length;
@property(strong, nonatomic) NSNumber* isPrivate;
@property(strong, nonatomic) NSString* targetId;
@property(strong, nonatomic) NSString* type;
@property(strong, nonatomic) NSString* id;
@property(strong, nonatomic) NSNumber* version;
@property(strong, nonatomic) NSNumber* created;
@property(strong, nonatomic) NSNumber* updated;

@end
