//
//  main.m
//  Files
//
//  Created by Gal Cohen on 9/17/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSString *testerfile = @"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/testerfile";
        NSString *newfile = @"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newfile";
        
        
        //create the handle
        NSFileManager *manager;
        manager = [NSFileManager defaultManager];
        
        
        //check if the file exists
        if ([manager fileExistsAtPath:testerfile] == NO){
            NSLog(@"File does NOT exist");
            return 1;
        }
        
        
        ///copy the file
        if ([manager copyItemAtPath:testerfile toPath:newfile error:NULL]== NO){
            NSLog(@"can not copy the file");
            return 2;
        }
        
        
        //rename file by moving it to the same place with anotehr name
        if ([manager moveItemAtPath:@"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newfile" toPath:@"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newfile2" error:NULL]) {
            NSLog(@"Cannot rename the file");
            return 3;
        }
        
        
        
        
        //get size of file
        NSDictionary *dic;
        if ((dic = [manager attributesOfItemAtPath:@"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newfile2" error:NULL]) == nil){
            
            NSLog(@"could not get file attributes");
            return 4;
        }else{
            NSLog(@"file is %i bytes", [[dic objectForKey:NSFileSize ] intValue]);
        }
        
        
        
        
        //delete file
        [manager removeItemAtPath:@"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newfile" error:NULL];
         [manager removeItemAtPath:@"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newfile2" error:NULL];
        NSLog(@"%@", [NSString stringWithContentsOfFile:testerfile encoding:NSUTF8StringEncoding error:NULL]);
        
        
        
        
        //------------------------------------------------------------------------------------------------------------------
        
        
        NSFileManager *manager2 = [NSFileManager defaultManager];
        NSString *path;
        
        //get current directory
        path = [manager2 currentDirectoryPath];
        NSLog(@"%@", path);
        
        //create a new directory
        if ([manager2 createDirectoryAtPath:@"/Users/galchook26/Desktop/Projects/Tutorials/iPhone Tutorials/Tutorials_New/Files/Files/newdir" withIntermediateDirectories:NO attributes:nil error:nil]) {
            NSLog(@"could not create new directory");
        }
        
        
        
        //-----------------------------------------------------------------------------------------------------------------------
        
        
        
        NSFileHandle *fin, *fout;
        NSData *buffer;
        
        fin = [NSFileHandle fileHandleForReadingAtPath:testerfile];
        
        [[NSFileManager defaultManager] createFileAtPath:newfile contents:nil attributes:nil];
        fout = [ NSFileHandle fileHandleForWritingAtPath:newfile];
        
        //truncate file
        [fout truncateFileAtOffset:0];
        
        buffer = [fin readDataToEndOfFile];
        [fout writeData:buffer];
        
        
        [fin closeFile];
        [fout closeFile];
        
        
    }
    return 0;
}

