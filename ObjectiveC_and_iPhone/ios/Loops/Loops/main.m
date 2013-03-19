//
//  main.m
//  Loops
//
//  Created by Gal Cohen on 9/12/12.
//  Copyright (c) 2012 Gal Cohen. All rights reserved.
//

//intro to loops
// while loop, nested loops, scanf, while loops, do while loops
// intro to if statements, else if, nested ifs
// switch statements
// conditional operator




#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        for (int x = 0; x < 10; x++) {
            NSLog(@"x:%i", x);
        }
        
        
        
        
        
        int userNum;
        for (int i = 1; i <= 3; i++) {
            
            NSLog(@"Enter a number and we will print it that number of times!");
            
            scanf("%i", &userNum);
            for (int b = 1; b <= userNum; b++) {
                NSLog(@"%i", userNum);
            }
        }
        
        
        
        
        
        
        int number = 1;
        while (number <= 6) {
            NSLog(@"%i", number);
            number++;
        }
        
        
        
        
        
        number = 1;
        int gal;
        
        scanf("%i", &gal);
        
        while (number <= 10) {
            NSLog(@"%i, times  %i = %i", number, gal , number * gal);
            number++;
        }
        
        
        
        
        
        
        int n = 1;
        do {
            NSLog(@"%i squared is %i", n, n*n);
            n++;
        } while ( n <= 12);
        



        int num1, num2;
        NSLog(@"Enter a number you idiot!");
        scanf("%i", &num1);
        num2 = num1 % 2;

        if (num2 == 0){
            NSLog(@"even");
        }else{
            NSLog(@"odd");
        }
        



        
        int age, sex;
        NSLog(@"Enter age:");
        scanf("%i", &age);
        NSLog(@"Enter sex: (1 = boy, 2 = girl)");
        scanf("%i", &sex);


        if (age < 18 || age > 80) {
            NSLog(@"Go to another website!");
    
        }else{
            if (sex == 1){
                NSLog(@"Welcome man!");
            }else{
                NSLog(@"Welcome girl!");
            }
        }


        
        
        
        
        int time;
        NSLog(@"ENter the fn time!");
        scanf("%i", &time);
        
        if (time < 11) {
            NSLog(@"Good morning to ya");
        }else if (time < 16){
            NSLog(@"Good aternoon");
        }else if (time < 24){
            NSLog(@"Good night hoss!");
            
        }else{
            NSLog(@"what hte f did u even enteR?!");
        }
        
        
        
        
        
        int numbers;
        NSLog(@"ENter 1 2 or 3!");
        scanf("%i", &numbers);
        
        switch (time) {
            case 1:
                 NSLog(@"First!");
                break;
            case 2:
                NSLog(@"Second!");
                break;
            case 3:
                NSLog(@"Third!");
                break;
                
            default:
                NSLog(@"Not one of the three numbers :( ");
                break;
        }
        
        
        
        
        int a = 2;
        int b = 2;
        int c = 0; // zero can be false, every other number can be ttrue
        
        a == b ? NSLog(@"they are equal") : NSLog(@"different");
        c ? NSLog(@"TRUE") : NSLog(@"FALSE");
        
        
        
    }
    return 0;
}

