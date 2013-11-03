//
//  FLPlaceToGoViewController.m
//  FlickrLand
//
//  Created by 蘇 on 13/11/3.
//  Copyright (c) 2013年 Ntu Med Info Lab. All rights reserved.
//

#import "FLPlaceToGoViewController.h"
#import "FLAppTheme.h"
#import "FLDataSource.h"
#import "FLPlaceCell.h"
#import "FLDistrictData.h"
#import "FLPhotoData.h"
#import "FLCultureData.h"
#import "FLMapAnnotation.h"

@interface FLPlaceToGoViewController ()

@end

@implementation FLPlaceToGoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setHidden:YES];
    
    [FLAppTheme menuButtonForViewController:self];
    
    [_contentTableView setDelegate:self];
    [_contentTableView setDataSource:self];
    
    _popularDataArray = [[FLDataSource sharedDataSource] popularDistrict];
    //_cultureDataArray = @[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0,@0];
    _contentDataArray = _popularDataArray;
    _cultureDataArray = [[FLDataSource sharedDataSource] getAllCulturData];
    
    
    _annotationArray = [NSMutableArray array];
    [_annotationArray removeAllObjects];
    
    for (FLCultureData *data in _cultureDataArray) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([data.latitude doubleValue],[[data longitude] doubleValue]);
        FLMapAnnotation *annotation = [[FLMapAnnotation alloc] initWithCoordinate:coordinate];
        [annotation setTitle:data.placeName];
        [_annotationArray addObject:annotation];
    }
    [_mapView addAnnotations:_annotationArray];
    
    
    
    [_mapView.layer setCornerRadius:6.0f];
    [_mapView.layer setMasksToBounds:YES];
    [_mapView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_contentDataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_popularButton.isSelected) {
        return [FLPlaceCell height];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    [headView setBackgroundColor:[UIColor clearColor]];
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    [footView setBackgroundColor:[UIColor clearColor]];
    return footView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"Cell";
    static NSString *targetCellIdentifier = @"targetCell";
    
    if (_popularButton.isSelected) {
        FLPlaceCell *cell = (FLPlaceCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[FLPlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        FLDistrictData *districtData = _contentDataArray[indexPath.row];
        [cell.placeNameLabel setText:districtData.districtName];
        
        NSArray *photoArray = [districtData.photos allObjects];
        FLPhotoData *photoData = photoArray[0];
        
        NSURL *photoURL = [NSURL URLWithString:photoData.sourceM];
        [cell setPhotoUrl:photoURL];
        [cell.photoNumLabel setText:[NSString stringWithFormat:@"%i Photos", [photoArray count]]];
        
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:targetCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:targetCellIdentifier];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.textLabel setTextColor:[UIColor whiteColor]];
        }
        FLDistrictData *districtData = _contentDataArray[indexPath.row];
        [cell.textLabel setText:districtData.districtName];
        
        return cell;
    }
}


#pragma mark MKMapView Delegate
- (void)finishedLocateUserLocation:(CLLocation *)location {
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.06f, 0.06f);
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, span);
    [_mapView setRegion:region animated:NO];
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.06f, 0.06f);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [_mapView setRegion:region animated:NO];
}
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    if (annotation == mapView.userLocation) return nil;
//    static NSString *friendPinIdentifier = @"MyLocation";
//    static NSString *tagPinIdentifier = @"MyTag";
//    
//    MKAnnotationView *pin = [_mapView dequeueReusableAnnotationViewWithIdentifier:tagPinIdentifier];
//    
//    if (pin == nil) {
//        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:tagPinIdentifier];
//    }
//    [pin setAnnotation:annotation];
//    
//    return pin;
//}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    [self performSegueWithIdentifier:@"Nearby2Detail" sender:view];
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    if (_imagePicker == nil) {
        
        //建立一個ImagePickerController
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        //設定影像來源
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
    }
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


#pragma mark - UIEvents
- (IBAction)popularButton_touchUpInside:(UIButton *)sender {
    
    if (_popularButton.isSelected) return;
    
    [_popularButton setSelected:YES];
    [_targetButton setSelected:NO];
    [_cultureButton setSelected:NO];
    
    [_contentTableView setHidden:NO];
    [_mapView setHidden:YES];
    
    _contentDataArray = _popularDataArray;
    [_contentTableView reloadData];
}
- (IBAction)targetButton_touchUpInside:(UIButton *)sender {
    
    if (_targetButton.isSelected) return;
    
    if (_targetDataArray == nil) {
        _targetDataArray = [[FLDataSource sharedDataSource] emptyDistrict];
    }
    
    [_popularButton setSelected:NO];
    [_targetButton setSelected:YES];
    [_cultureButton setSelected:NO];
    
    [_contentTableView setHidden:NO];
    [_mapView setHidden:YES];
    
    _contentDataArray = _targetDataArray;
    [_contentTableView reloadData];
}
- (IBAction)cultureButton_touchUpInside:(UIButton *)sender {
    
    if (_cultureButton.isSelected) return;
    
    [_popularButton setSelected:NO];
    [_targetButton setSelected:NO];
    [_cultureButton setSelected:YES];
    
    [_contentTableView setHidden:YES];
    [_mapView setHidden:NO];
}


#pragma mark - Image Picker View Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //取得影像
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    //移除Picker
    [picker dismissViewControllerAnimated:YES completion:^{
            
    }];;

    
}

@end
