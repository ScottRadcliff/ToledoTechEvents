//
//  EventsDetailViewController.m
//  Toledo Tech
//
//  Created by Don Miller on 5/16/14.
//  Copyright (c) 2014 GroundSpeed. All rights reserved.
//

#import "EventsDetailViewController.h"
#import "Constants.h"
#import <Parse/Parse.h>

@interface EventsDetailViewController ()

@end

@implementation EventsDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    _lblTitle.text = _event.title;
    _lblStartDate.text = [GlobalFunctions formatDateString:_event.startTime];
    _lblEndDate.text = [GlobalFunctions formatDateString:_event.endTime];
    _txtDescription.text = _event.eventDescription;
    _lblVenue.text = _event.venue.title;
    
    if ([_event.rsvpUrl isEqual: @""])
    {
        _lblRsvpPlaceHolder.hidden = false;
    }
    else
    {
        _lblRsvpPlaceHolder.hidden = true;
        [self createRsvpButton];
    }
}

- (void)createRsvpButton
{
    UIColor *blueColor = kBlueColor;
    UIColor *greenColor = kGreenColor;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(19, 183, 280, 25)];
    [button setTitle:@"RSVP" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [button setBackgroundColor:greenColor];
    [button setTitleColor:blueColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openRsvpUrl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)openRsvpUrl
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_event.rsvpUrl]];
}

- (void)formatDetailView
{
    _vuDetailView.backgroundColor = kBlueColor;
    _lblTitle.backgroundColor = kBlueColor;
    _lblTitle.textColor = kGreenColor;
    _lblHdrStartDate.backgroundColor = kBlueColor;
    _lblHdrStartDate.textColor = [UIColor whiteColor];
    _lblHdrVenue.backgroundColor = kBlueColor;
    _lblHdrVenue.textColor = [UIColor whiteColor];
    _lblVenue.backgroundColor = kBlueColor;
    _lblVenue.textColor = kGreenColor;
    _lblStartDate.backgroundColor = kBlueColor;
    _lblStartDate.textColor = kGreenColor;
    _lblHdrEndDate.backgroundColor = kBlueColor;
    _lblHdrEndDate.textColor = [UIColor whiteColor];
    _lblEndDate.backgroundColor = kBlueColor;
    _lblEndDate.textColor = kGreenColor;
    _lblRsvpPlaceHolder.textColor = [UIColor whiteColor];
    _txtDescription.backgroundColor = kBlueColor;
    _txtDescription.textColor = kGreenColor;
    _btnClose.backgroundColor = kGreenColor;
    _btnClose.tintColor = kBlueColor;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [PFAnalytics trackEvent:@"Read" dimensions:@{@"Category": @"Event Detail"}];
    [self formatDetailView];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnClose:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
