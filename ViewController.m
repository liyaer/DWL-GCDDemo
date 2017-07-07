//
//  ViewController.m
//  GCDDemo
//
//  Created by 杜文亮 on 17/6/22.
//  Copyright © 2017年 Companyxiix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/*
                                多任务时（多线程编程）
 
    sync+串/并：不新建线程，运行在主线程，任务顺序执行。阻塞当前线程（该部分代码下面的代码必须等该部分代码执行完毕才开始执行）
 
    async+串：新建一条子线程（串行队列为mian的话不新建线程，运行在主线程），任务顺序执行。不阻塞当前线程
 
    async+并：新建多条子线程，任务无序执行。不阻塞当前线程
 
    总结：
        1，sync和async的区别：是否阻塞当前线程。（sync：任务立即执行，抢占资源。async：CPU闲暇时执行，不抢占资源）
        2，向主队列添加任务时，只能指定异步执行，同步会造成死锁
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //异步+并行队列
    [self asyncGlobalQueue];
    NSLog(@"============看看主线程ID号1===============");
    

    //异步+串行队列
//    [self asyncSerialQueue];
    NSLog(@"============看看主线程ID号2===============");

    
    //同步+并行队列
//    [self syncGlobalQueue];
    NSLog(@"============看看主线程ID号3===============");

    
    //同步+串行队列
//    [self syncSerialQueue];
    NSLog(@"============看看主线程ID号4===============");
    
}

- (void)asyncGlobalQueue
{
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加 全局队列 中去 异步 执行(5条子线程，任务无序执行，不阻塞当前线程)
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5.0];//模拟耗时操作
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}

- (void)asyncSerialQueue
{
    // 1.创建一个串行队列
    dispatch_queue_t queue = dispatch_get_main_queue()/*dispatch_queue_create("cn.heima.queue", NULL)*/;
    
    // 2.将任务添加到串行队列中 异步 执行（一条子线程(mian的话不新建线程，运行在主线程)，任务顺序执行，不阻塞当前线程）
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片111---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片222---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:5.0];//模拟耗时操作
        NSLog(@"-----下载图片333---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片444---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"-----下载图片555---%@", [NSThread currentThread]);
    });
}

-(void)syncGlobalQueue
{
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加 全局队列 中去 同步 执行(不新建线程，运行在主线程，任务顺序执行，阻塞当前线程)
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:5.0];//模拟耗时操作
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}

-(void)syncSerialQueue
{
    // 1.创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("cn.heima.queue", NULL);
//    dispatch_queue_t queue = dispatch_get_main_queue();//造成死锁
    
    // 2.将任务添加到串行队列中 同步 执行（不新建线程，运行在主线程，任务顺序执行，阻塞当前线程）
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        [NSThread sleepForTimeInterval:5.0];//模拟耗时操作
        NSLog(@"-----下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"-----下载图片5---%@", [NSThread currentThread]);
    });
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
