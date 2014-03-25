//
//  ViewController.m
//  FileManagementDemo
//
//  Created by Gal Cohen on 3/25/14.
//  Copyright (c) 2014 Gal Cohen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (IBAction)createFile:(id)sender;
- (IBAction)deleteFile:(id)sender;
- (IBAction)listFile:(id)sender;
- (IBAction)readFile:(id)sender;

@property (nonatomic, strong) NSFileManager *fileManager;
@property (nonatomic, strong) NSString *tmpDir;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.fileManager = [[NSFileManager alloc] init];
    
    // tmp Directory
    self.tmpDir = NSTemporaryDirectory();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)enumerateDirectory
{
    NSArray *filesInDirectory = [self.fileManager contentsOfDirectoryAtPath:self.tmpDir error:nil];
    if ([filesInDirectory count] > 0)
    {
        for (NSString *fileName in filesInDirectory)
        {
            if ([fileName isEqualToString:@"sample.txt"])
            {
                return fileName;
            }
        }
    }
    else
    {
        NSLog(@"no file created yet.");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"iOS File Management" message:@"No File Created Yet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return nil; 
    }
    return nil; 
}



#pragma mark - Create File

- (IBAction)createFile:(id)sender
{
    NSString *fileName = @"sample.txt";
    NSString *path = [self.tmpDir stringByAppendingPathComponent:fileName];
    NSString *contentsOfFile = @"Sample text.";
    
    [contentsOfFile writeToFile:path atomically:YES  encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"File sample.txt created at tmp directory");
}

#pragma mark - Delete File

- (IBAction)deleteFile:(id)sender
{
    NSString *path = [self.tmpDir stringByAppendingPathComponent: [self enumerateDirectory]];
    
    // Delete File
    [self.fileManager removeItemAtPath:path error:nil];
}

#pragma mark - List File

- (IBAction)listFile:(id)sender
{
    // List Contents of Path
    NSLog(@"contents of path %@ = \n%@", self.tmpDir, [self enumerateDirectory]);
}

#pragma mark - Read File

- (IBAction)readFile:(id)sender
{
    NSString *path = [self.tmpDir stringByAppendingPathComponent: [self enumerateDirectory]];
    NSString *contentsOfFile = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // List Contents of File
    NSLog(@"Contents of file = %@", contentsOfFile);
}

@end
