//
//  Setting.m
//  KnowYourLife
//
//  Created by wupeng on 15/04/11.
//  Copyright © 2015年 wupeng. All rights reserved.
//

#import "Setting.h"
//#import "Login.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"


//#import "UMSocialQQHandler.h"
#define WIDTH  self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
@interface Setting ()



@end

@implementation Setting

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    //self.navigationController.navigationBarHidden = YES;
}


-(void)createUI{
    //数据返回头像
     _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH/3, HEIGHT/8, WIDTH/3 ,WIDTH/3)];
    _imageView.backgroundColor = [UIColor purpleColor];
    
    _imageView.clipsToBounds = YES;
    
    _imageView.layer.cornerRadius = WIDTH/6;
    
    [self.view addSubview:_imageView];
    
    if (_imageUrl!=nil) {
        NSLog(@"_imageStr=44444%@", _imageUrl);
        [_imageView sd_setImageWithURL:_imageUrl];
    }
    //用户名
    
    _nameLabel = [UILabel new];
    if (_nameStr == nil) {
        _nameLabel.text = @"请登录";
    }else{
        _nameLabel.text = _nameStr;
    }
    
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = [UIColor greenColor];
    [self.view addSubview:_nameLabel];
    //布局适配
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(WIDTH/3);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-WIDTH/3);
        make.height.equalTo(@30);
    }];
    
    
    
    [self.view addSubview:_imageView];
    
    //底部登录按钮
    NSArray * arr = @[@"SinaWeibo_Selected",@"share_qq",@"TencentWeixin_Selected"];
    for (int i=0; i<3; i++) {
    UIButton * logButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH*(i+1)/5, HEIGHT*4/5, WIDTH/5, 40)];
        logButton.tag = i+1;
   // [logButton setTitle:arr[i] forState:UIControlStateNormal];
        [logButton setImage:[UIImage imageNamed:arr[i]] forState:UIControlStateNormal];
    //logButton.backgroundColor = [UIColor redColor];
    
        [logButton addTarget:self action:@selector(buttonToLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:logButton];
    }
}

-(void)buttonToLogin:(UIButton*)button{
    switch (button.tag) {
        case 1:{
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                //          获取微博用户名、uid、token等
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
                    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",snsAccount.iconURL]];
                    
                    [_imageView sd_setImageWithURL:imageURL];
                    
                    _nameLabel.text = [NSString stringWithFormat:@"%@",snsAccount.userName];
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }});
            
        }
            break;
        case 2:
        {
            [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
            
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                //          获取微博用户名、uid、token等
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
                    
                    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",snsAccount.iconURL]];
                    
                    [_imageView sd_setImageWithURL:imageURL];
                    
                    _nameLabel.text = [NSString stringWithFormat:@"%@",snsAccount.userName];
                    
                    
                    
                    
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }});
        }
            break;
        case 3:
        {
            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                if (response.responseCode == UMSResponseCodeSuccess) {
                    
                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
                    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",snsAccount.iconURL]];
                    
                    [_imageView sd_setImageWithURL:imageURL];
                    
                    _nameLabel.text = [NSString stringWithFormat:@"%@",snsAccount.userName];
                    
                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                }
                
            });
        }
            break;
        default:
            break;
    }

}

//-(void)LoginInfo:(NSNotification*)LoginInfo
//{
//    
//    
//    switch (tag) {
//        case 1:{
//            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//
//            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//                //          获取微博用户名、uid、token等
//
//                if (response.responseCode == UMSResponseCodeSuccess) {
//
//                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
//
//                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//
//                }});
//
//        }
//            break;
//        case 2:
//        {
//            [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
//
//            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
//
//            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//                //          获取微博用户名、uid、token等
//
//                if (response.responseCode == UMSResponseCodeSuccess) {
//
//                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
//                   
//                    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",snsAccount.iconURL]];
//                    
//                    [_imageView sd_setImageWithURL:imageURL];
//                    _nameLabel.text = [NSString stringWithFormat:@"%@",snsAccount.userName];
//                   
//
//
////                    Setting * set = [[Setting alloc] init];
////                    set.imageStr = snsAccount.iconURL;
////                    set.nameStr = snsAccount.userName;
////                    set.hidesBottomBarWhenPushed = NO;
////
////
////                    NSNotification *loginNoti = [[NSNotification alloc] initWithName:@"loginNoti" object:self userInfo:@{@"imageStr":snsAccount.iconURL,@"nameStr":snsAccount.userName}];
////
////                    [[NSNotificationCenter defaultCenter] postNotification:loginNoti];
////
////                    [self.navigationController pushViewController:set animated:YES];
////                    //[self.navigationController popToRootViewControllerAnimated:YES];
//
//                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//
//                }});
//        }
//            break;
//        case 3:
//        {
//            UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
//
//            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//
//                if (response.responseCode == UMSResponseCodeSuccess) {
//
//                    UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
//
//                    NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
//
//                }
//
//            });
//        }
//            break;
//        default:
//            break;
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
