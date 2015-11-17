#import "Page.h"
#import "GalleryView.h"
#import "ProductNameViewBig.h"

@interface ProductDetailsPage : Page

@property(strong,nonatomic)ProductDetails* prodDetails;

@property(strong,nonatomic)GalleryView* galleryView;
@property(strong,nonatomic)UILabel* nameLabel;
@property(strong,nonatomic)UILabel* dateLabel;
@property(strong,nonatomic)UILabel* labelDesc;
@property(strong,nonatomic)UILabel* labelOwner;

@end
