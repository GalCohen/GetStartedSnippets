//
//  ViewController.m
//  CoreImageFun
//
//  Created by Gal Cohen on 3/3/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()  <UIImagePickerControllerDelegate, UINavigationBarDelegate>

@end

@implementation ViewController {
    CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;
    UIImageOrientation orientation;
}

-(void)logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:
                           kCICategoryBuiltIn];
    NSLog(@"%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%@", [fltr attributes]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//   The first two lines create an NSURL object that holds the path to your image file
    NSString *filePath =
    [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    /*
     //  -------------- Load image with sepia filter without using CIContext ---------------------
    
//   create your CIImage with the imageWithContentsOfURL method.
    CIImage *beginImage =
    [CIImage imageWithContentsOfURL:fileNameAndPath];
    
//   create your CIFilter object. A CIFilter constructor takes the name of the filter, and a dictionary that specifies the keys and
//   values for that filter. Each filter will have its own unique keys and set of valid values.
//   The CISepiaTone filter takes only two values, the KCIInputImageKey (a CIImage) and the @”inputIntensity”, a float value, wrapped
//   in an NSNumber (using the new   literal syntax), between 0 and 1. Here you give that value 0.8. Most of the filters have default values
//   that will be used if no values are supplied. One exception is the
//   CIImage, this must be provided as there is no default.
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", @0.8, nil];
    CIImage *outputImage = [filter outputImage];
    
//   Once you have an output CIImage, you will need to convert it into a UIImage. New in iOS 6 is the UIImage method +imageWithCIImage: method.
//   This method creates a UIImage from a CIImage. Once we’ve converted it to a UIImage, you just display it in the image view you added earlier.
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.imageView.image = newImage;
     */
    
    
    
    //  -------------- Load image with sepia filter using CIContext ---------------------
    beginImage =
    [CIImage imageWithContentsOfURL:fileNameAndPath];
    
//  set up the CIContext object. The CIContext constructor takes an NSDictionary that specifies options including the color format and whether
//  the context should run on the CPU or GPU. For this app, the default values are fine and so you pass in nil for that argument.
    context = [CIContext contextWithOptions:nil];
    
    filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues: kCIInputImageKey, beginImage,
                        @"inputIntensity", @0.8, nil];
    CIImage *outputImage = [filter outputImage];
    
//  Here you use a method on the context object to draw a CGImage. Calling the createCGImage:fromRect: on the context with the supplied CIImage
//  will produce a CGImageRef.
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    
//  use UIImage +imageWithCGImage to create a UIImage from the CGImage.
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    self.imageView.image = newImage;
    
//  release the CGImageRef. CGImage is a C API that requires that you do your own memory management, even with ARC.
    CGImageRelease(cgimg);
    
    [self logAllFilters];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)amountSliderValueChanged:(UISlider *)slider {
    float slideValue = slider.value;
    
//    [filter setValue:@(slideValue) forKey:@"inputIntensity"];
//    CIImage *outputImage = [filter outputImage];
    
    CIImage *outputImage = [self oldPhoto:beginImage withAmount:slideValue];
    
    CGImageRef cgimg = [context createCGImage:outputImage
                                     fromRect:[outputImage extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:orientation];
    self.imageView.image = newImage;
    
    CGImageRelease(cgimg);
}


- (IBAction)savePhoto:(id)sender {
    // Get the CIImage output from the filter.
    CIImage *saveToSave = [filter outputImage];
    // Create a new, software based CIContext
    CIContext *softwareContext = [CIContext
                                  contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    // Generate the CGImageRef.
    CGImageRef cgImg = [softwareContext createCGImage:saveToSave
                                             fromRect:[saveToSave extent]];
    // Save the CGImageRef to the photo library.
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg
                                 metadata:[saveToSave properties]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              // Release the CGImage. This last step happens in a callback block so that it only fires after you’re done using it.
                              CGImageRelease(cgImg);
                          }];
}

- (IBAction)loadPhoto:(id)sender {
    UIImagePickerController *pickerC =
    [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *gotImage =
    [info objectForKey:UIImagePickerControllerOriginalImage];
    orientation = gotImage.imageOrientation;
    beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [self amountSliderValueChanged:self.amountSlider];
    NSLog(@"%@", info);
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(CIImage *)oldPhoto:(CIImage *)img withAmount:(float)intensity {
    
    // set up the sepia filter, passing in the intensity of the sepia filter
    CIFilter *sepia = [CIFilter filterWithName:@"CISepiaTone"];
    [sepia setValue:img forKey:kCIInputImageKey];
    [sepia setValue:@(intensity) forKey:@"inputIntensity"];
    
    // creates a random noise pattern
    CIFilter *random = [CIFilter filterWithName:@"CIRandomGenerator"];
    
    // altering the noise effect to be elss dramatic
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:random.outputImage forKey:kCIInputImageKey];
    [lighten setValue:@(1 - intensity) forKey:@"inputBrightness"];
    [lighten setValue:@0.0 forKey:@"inputSaturation"];
    
    // takes an output CIImage and crops it to the provided rect. The random filter needs to be cropped because it is
    // infinitely large. As a generated CIImage, goes on infinitely. If you don’t crop it at some point, you’ll get an error saying
    // that the filters have ‘an infinte extent’. CIImages don’t actually contain data, they describe it. It’s not until you call a
    // method on the CIContext that data is actually processed.
    CIImage *croppedImage = [lighten.outputImage imageByCroppingToRect:[beginImage extent]];
    
    // combining the output of the sepia filter with the output of the alter CIRandom filter.
    CIFilter *composite = [CIFilter filterWithName:@"CIHardLightBlendMode"];
    [composite setValue:sepia.outputImage forKey:kCIInputImageKey];
    [composite setValue:croppedImage forKey:kCIInputBackgroundImageKey];
    
    // run a vignette filter on this composited output that darkens the edges of the photo. You’re using the value from the slider
    // to set the radius and intensity of this effect.
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    [vignette setValue:composite.outputImage forKey:kCIInputImageKey];
    [vignette setValue:@(intensity * 2) forKey:@"inputIntensity"];
    [vignette setValue:@(intensity * 30) forKey:@"inputRadius"];
    
    // you return the output of the last filter.
    return vignette.outputImage;
}

@end
