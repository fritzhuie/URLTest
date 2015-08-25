//
//  ViewController.m
//  Ad Tracking URL Test
//
//  Created by Fritz Huie on 8/20/15.
//  Copyright (c) 2015 Unity. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    NSString* url;
    NSString* message;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    textLog.text = @"Waiting to test...";
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printToLog:(NSString*) output{

}

- (void)appendText:(NSString*) str{
    
    NSString* line = [@"\nl " stringByAppendingString:str];
    textLog.text = [textLog.text stringByAppendingString:line];
    NSRange range = NSMakeRange(textLog.text.length - 1, 1);
    [textLog scrollRangeToVisible:range];
}

- (IBAction)testAdNetworkURLRequest:(id)sender {
    
    NSLog(@"URL Test button pressed");
    
    
    url = @"https://adtrack.king.com/click?type=ad&idfa_raw=B40B1B56-0AC5-412C-9784-FBBDCF2A7320&idfa_md5=d23a7fb60ec3d6f3800c587e6dce3b85&network=applifier&countrycode=us&os=ios&targetAppId=33&publisher=99999998765&site=99999998765&campaignName=Install_tracking_test&creativeName=CCSSoda_TV_gb_20seconds&creativeSize=&gamerId=53860b76920acd1a2301848b&subType5=9876543&noRedirect=true";
    
    url = @"https://track.volo-mobile.com/5dd6f2fe-5bd9-49bb-91fa-a793ac7a7f07?source_game_id=99999998765&ip=23.21.107.98&google_aid=0cbcf778-15b6-45d5-ba6a-60f02d7ec07f&android_id_md5=cff0faa10e6a8eb758b506f668fc8176&game_id=9876543";

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLConnection* connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

    NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                               
    message = [NSString stringWithFormat:@"\n response status code: %ld", (long)[httpResponse statusCode]];
    [self appendText:message];
        // do stuff
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"didReceiveResponse");
    [self appendText:@"\n didReceiveResponse"];
    _responseData = [[NSMutableData alloc] init];
    NSDictionary* headers = [(NSHTTPURLResponse *)response allHeaderFields];
    for(NSString *key in [headers allKeys]) {
        NSLog(@"%@",[headers objectForKey:key]);
        message = [NSString stringWithFormat:@"%@",[headers objectForKey:key]];
        [self appendText:message];
    }
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData");
    [self appendText:@"\n didReceiveData"];
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    message = [NSString stringWithFormat:@"\n Connection failed! Error - %@ %@",
               [error localizedDescription],
               [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]];
    [self appendText:message];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"Succeeded - Received %d bytes of data",[_responseData length]);
    message = [NSString stringWithFormat:@"\n Succeeded - Received %d bytes of data",[_responseData length]];
    [self appendText:message];
    
    // Release the connection and the data object
    // by setting the properties (declared elsewhere)
    // to nil.  Note that a real-world app usually
    // requires the delegate to manage more than one
    // connection at a time, so these lines would
    // typically be replaced by code to iterate through
    // whatever data structures you are using.
    _responseData = nil;
}

@end
