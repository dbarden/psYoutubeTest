//
//  ViewController.m
//  psYoutubeTest
//
//  Created by Daniel Barden on 27/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "PSYouTubeExtractor.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController () {
	PSYouTubeExtractor *_extractor;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = [NSString stringWithFormat:@"reuseId"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
	}
	cell.textLabel.text = @"test";
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=Vo0Cazxj_yc"];
	_extractor = [PSYouTubeExtractor extractorForYouTubeURL:youTubeURL success:^(NSURL *URL) {
		NSLog(@"Finished extracting: %@", URL);
		MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:URL];
		[self presentModalViewController:moviePlayer animated:YES];
	} failure:^(NSError *error) {
		NSLog(@"Failed to query mp4: %@", error);
	}];

}
@end
