//
//  TotalWebViewController.m
//  SMBA_EN
//
//  Created by KimYoung-Min on 2016. 5. 16..
//  Copyright © 2016년 youngmin.kim. All rights reserved.
//

#import "TotalWebViewController.h"

@interface TotalWebViewController () <UIWebViewDelegate>
{
    NSInteger nTotalPage;   //pdf 전용
}
@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, weak) IBOutlet UILabel *lb_MainTitle;
@end

@implementation TotalWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.webView.delegate = self;
    
//    [self initNavi];
    
    if( self.str_Title )
    {
        self.screenName = self.lb_MainTitle.text = self.str_Title;
    }
    else
    {
        self.screenName = @"WebView";
    }
    
    //http://ebt.mobileb2bacademy.com/front/board/wvNotice?userIdx=6420&userAuth=9
    NSString *str_Url = [NSString stringWithFormat:@"%@/%@", kBaseWebUrl, self.str_Url];
    NSLog(@"webview url : %@", str_Url);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:str_Url]];
    [self.webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//    
//    if( self.isBackButton )
//    {
//        self.navigationController.navigationBarHidden = NO;
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)initNavi
{
    UILabel *lb_Title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, self.navigationController.navigationBar.frame.size.height)];
    lb_Title.tag = kNaviTitleTag;
    lb_Title.font = [UIFont fontWithName:@"Helvetica" size:18];
    lb_Title.textColor = kMainColor;
    lb_Title.text = self.str_Title;
    [Util getTextWith:lb_Title];
    lb_Title.textAlignment = NSTextAlignmentCenter;

    lb_Title.minimumScaleFactor = 0.5f;
    lb_Title.adjustsFontSizeToFitWidth = YES;

    CGRect frame = lb_Title.frame;
    frame.size.width = [Util getTextWith:lb_Title];
    lb_Title.frame = frame;
    
    
    if( frame.size.width > 280.0f )
    {
        frame = lb_Title.frame;
        frame.size.width = 280.f;
        lb_Title.frame = frame;
        
        lb_Title.minimumScaleFactor = 0.5f;
        lb_Title.adjustsFontSizeToFitWidth = YES;
    }
    
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, self.navigationController.navigationBar.frame.size.height)];
    self.navigationController.navigationBar.opaque = YES;
    [self.navigationItem.titleView addSubview:lb_Title];
    
    if( self.isBackButton )
    {
        self.navigationItem.leftBarButtonItem = [self leftBackMenuBarButtonItem];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [self leftMenuBar];
    }
    
    [self.navigationController.navigationBar hideBottomHairline];
    
    
    
    /*
     self.navigationItem.leftBarButtonItem = [self leftBackMenuBarButtonItem];
     
     [self.navigationController.navigationBar hideBottomHairline];
     
     NSDictionary *titleBarAttributes = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:18],
     NSForegroundColorAttributeName:kMainColor
     };
     self.navigationController.navigationBar.titleTextAttributes = titleBarAttributes;
     
     self.navigationController.navigationItem.title = @"Terms of Use & Privacy Policy";
     */
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if( self.dic_Info && self.str_Idx )
//    {
//        [self updateList];
//    }
}

//- (void)updateList
//{
//    NSMutableDictionary *dicM_Params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                        [[NSUserDefaults standardUserDefaults] objectForKey:@"UserIdx"], @"userIdx",
//                                        [[NSUserDefaults standardUserDefaults] objectForKey:@"BrandIdx"], @"brandIdx",
//                                        self.str_Idx, @"integrationCourseIdx",
//                                        [NSString stringWithFormat:@"%ld", [[self.dic_Info objectForKey:@"ProcessIdx"] integerValue]], @"processIdx",
//                                        [NSString stringWithFormat:@"%ld", [[self.dic_Info objectForKey:@"SubProcessIdx"] integerValue]], @"subProcessIdx",
//                                        @"pdf", @"contentType",
//                                        nil];
//    //course/getSubProcessImageList
//    [[WebAPI sharedData] callAsyncWebAPIBlock:@"course/inLearningSubProcessInfo"
//                                        param:dicM_Params
//                                    withBlock:^(id resulte, NSError *error) {
//                                        
//                                        [GMDCircleLoader hide];
//                                        
//                                        if( resulte )
//                                        {
//                                            NSLog(@"%@", resulte);
//                                            
//                                            NSDictionary *dic_Data = [resulte objectForKey:@"Data"];
//                                            NSDictionary *dic_Meta = [resulte objectForKey:@"Meta"];
//                                            NSInteger nCode = [[dic_Meta objectForKey_YM:@"ResultCd"] integerValue];
//                                            if( nCode == 1 )
//                                            {
//                                                NSDictionary *dic_SubProcessInfoMap = [dic_Data objectForKey:@"SubProcessInfoMap"];
//                                                nTotalPage = [[dic_SubProcessInfoMap objectForKey:@"ContentQuantity"] integerValue];
//                                                
//                                                [self updateProgress];
//                                            }
//                                            else
//                                            {
////                                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////                                                MsgPopUpViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MsgPopUpViewController"];
////                                                vc.type = kOneButton;
////                                                vc.str_Msg = [dic_Meta objectForKey_YM:@"FailMsg"];
////                                                [vc setCompletionBlock:^ {
////                                                    
////                                                    
////                                                }];
////                                                [self presentViewController:vc animated:YES completion:nil];
//                                            }
//                                        }
//                                    }];
//}

//- (void)updateProgress
//{
//    NSMutableDictionary *dicM_Params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                        [[NSUserDefaults standardUserDefaults] objectForKey:@"UserIdx"], @"userIdx",
//                                        [[NSUserDefaults standardUserDefaults] objectForKey:@"BrandIdx"], @"brandIdx",
//                                        self.str_Idx, @"integrationCourseIdx",
//                                        [NSString stringWithFormat:@"%ld", [[self.dic_Info objectForKey:@"ProcessIdx"] integerValue]], @"processIdx",
//                                        [NSString stringWithFormat:@"%ld", [[self.dic_Info objectForKey:@"SubProcessIdx"] integerValue]], @"subProcessIdx",
//                                        @"583", @"contentType",
//                                        [NSString stringWithFormat:@"%ld", nTotalPage], @"frameProcessingCnt",
//                                        [NSString stringWithFormat:@"%ld", nTotalPage], @"frameTotalCnt",
//                                        nil];
//    
//    [[WebAPI sharedData] callAsyncWebAPIBlock:@"course/updateSubProcessProgressRateFrame"
//                                        param:dicM_Params
//                                     withType:@"POST"
//                                    withBlock:^(id resulte, NSError *error) {
//                                        
//                                        [GMDCircleLoader hide];
//                                        
//                                        if( resulte )
//                                        {
//                                            NSDictionary *dic_Meta = [resulte objectForKey:@"Meta"];
//                                            NSInteger nCode = [[dic_Meta objectForKey_YM:@"ResultCd"] integerValue];
//                                            if( nCode == 1 )
//                                            {
//                                                
//                                            }
//                                            else
//                                            {
////                                                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
////                                                MsgPopUpViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"MsgPopUpViewController"];
////                                                vc.type = kOneButton;
////                                                vc.str_Msg = [dic_Meta objectForKey_YM:@"FailMsg"];
////                                                [vc setCompletionBlock:^ {
////                                                    
////                                                    
////                                                }];
////                                                [self presentViewController:vc animated:YES completion:nil];
//                                            }
//                                        }
//                                    }];
//}



#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if( [[[request URL] absoluteString] hasPrefix:@"toapp://"] )
    {
        NSString *jsData = [[request URL] absoluteString];
        NSArray *ar_Cert = [jsData componentsSeparatedByString:@"toapp://cmd?status=certi&"];
        if( ar_Cert.count > 1 )
        {
            NSString *str = [[ar_Cert objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            NSArray *ar_Sep = [str componentsSeparatedByString:@"&"];
            NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithCapacity:ar_Sep.count];
            for( NSString *str in ar_Sep )
            {
                NSArray *ar = [str componentsSeparatedByString:@"="];
                [dicM setValue:[ar objectAtIndex:1] forKey:[ar objectAtIndex:0]];
            }
        }
        
        
        NSArray *jsDataArray = [jsData componentsSeparatedByString:@"toapp://"];
        
        //        //1보다크면 무조건 팝!!
        //        if( [jsDataArray count] > 1 )
        //        {
        //            [self.navigationController popViewControllerAnimated:YES];
        //            return YES;
        //        }
        
        NSString *jsString = [jsDataArray objectAtIndex:1]; //jsString == @"call objective-c from javascript"
        
        NSRange range = [jsString rangeOfString:@"CLOSE"];
        if (range.location != NSNotFound)
        {
            if (self.presentingViewController != nil) {
                
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
            return YES;
        }
        
        range = [jsString rangeOfString:@"LOAD_COMPLETE"];
        if (range.location != NSNotFound)
        {
            NSString *str_SecretKey = [[NSUserDefaults standardUserDefaults] objectForKey:kAuthToken];
            
            NSString *scriptString = @"";
            if( self.dic_Info )
            {
                NSError *error = nil;
                NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self.dic_Info options:0 error:&error];
                NSString * str_Json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                scriptString = [NSString stringWithFormat:@"setToken('%@',%@);", str_SecretKey, str_Json];
            }
            else
            {
                if( self.webViewType == kExam || self.webViewType == kSurvey )
                {
                    scriptString = [NSString stringWithFormat:@"setToken('%@',%@);", str_SecretKey, self.str_TokenId];
                }
                else if( self.webViewType == kClanender ||
                        self.webViewType == kMyInfo ||
                        self.webViewType == kPoin ||
                        self.webViewType == kOneOnOne ||
                        self.webViewType == kPwChange )
                {
                    scriptString = [NSString stringWithFormat:@"setToken('%@');", str_SecretKey];
                }

            }
            
            [self.webView stringByEvaluatingJavaScriptFromString:scriptString];
        }
        
        range = [jsString rangeOfString:@"NO_AUTH"];
        if( range.location != NSNotFound )
        {
            [UIAlertController showAlertInViewController:self
                                               withTitle:@""
                                                 message:@"인증 제한시간이 경과하였거나 다른 기기에서 로그인 되어 인증정보가 유효하지 않습니다. 앱을 종료합니다"
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:@[@"확인"]
                                                tapBlock:^(UIAlertController *controller, UIAlertAction *action, NSInteger buttonIndex){
                                                    
                                                    if (buttonIndex == controller.cancelButtonIndex)
                                                    {
                                                        NSLog(@"Cancel Tapped");
                                                    }
                                                    else if (buttonIndex == controller.destructiveButtonIndex)
                                                    {
                                                        NSLog(@"Delete Tapped");
                                                    }
                                                    else if (buttonIndex >= controller.firstOtherButtonIndex)
                                                    {
                                                        [Common logOut:NO];
                                                    }
                                                }];
            
        }
        
        range = [jsString rangeOfString:@"DOWNLOAD"];
        if (range.location != NSNotFound)
        {
            //	4	DOWNLOAD	download	url(string)		다운로드 대상 URL(ex: http://example.com/asdf.pdf)	전달된 URL 의 파일을 다운로드 한다.
        }
        
        range = [jsString rangeOfString:@"UPLOAD_IMAGES"];
        if (range.location != NSNotFound)
        {
            //	5	UPLOAD_IMAGES	uploadImages	count(number)		최대 선택 가능한 이미지 갯수	갤러리에서 선택한 이미지들을 서버에 업로드하고 response 를 웹뷰에 전달한다.
        }
        
        NSLog(@"%@", jsString);
        
    }
    
    return YES;
}



@end
