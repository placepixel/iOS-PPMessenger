//
//  PPMessengerViewController.m
//  PPChatViewController
//
//  Created by Alex Padalko on 3/22/16.
//  Copyright © 2016 PlacePixel. All rights reserved.
//

#import "PPMessengerViewController.h"
#import "PPMessengerInputAccessoryView.h"
#import "_PPMessengerFakeInputAccessoryView.h"
#import "PPMessengerContentManager.h"
/////


///




////


///

#import "PPMessengerInputAccessoryView.h"


#import "TESTView.h"
////
@interface PPMessengerViewController () <_PPMessengerFakeInputAccessoryViewDelegate,PPMessengerContentManagerDelegate,PPMessengerCollectionViewLayoutDelegate,PPMessengerInputAccessoryViewDelegate>
@property (nonatomic,retain)_PPMessengerFakeInputAccessoryView * _fakeInputView;
@property (nonatomic,retain)NSMutableDictionary * _constructors;


@property (nonatomic,retain)NSMutableDictionary * _registredViews;
@end

@implementation PPMessengerViewController
-(void)viewWDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"?");
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.reversed=YES;
    [self loadCurrentPage];
    
    

//    ////
//    [self ppm_registerContructor:[[PPMOtherUserBubbleConstructor alloc] init]];
//    [self ppm_registerContructor:[[PPMCurrentUserBubbleConstructor alloc] init]];
//    [self ppm_registerContructor:[[PPMSenderProfilePictureConsturctor alloc] init]];
//    [self ppm_registerContructor:[[PPMSenderUsernameConstructor alloc] init]];
//    ////
    
    
    
    
//    [self.contentView registerClass:[PPMessengerBubbleReusableView class] forCellWithReuseIdentifier:@"ppm_bubble"];
//    [self.contentView registerClass:[PPMessengerProfilePictureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ppm_header"];
//    
    
    ////

    // Do any additional setup after loading the view.
}

-(void)loadCurrentPage{
    [self.contentProvider ppm_loadItems:[self.contentManager ppm_currentIndex] limit:self.contentManager.ppm_pageSize fromTopToBot:!self.reversed complitBlock:^(NSArray<PPMessengerContentDisplayObjectProt> *newItems) {
        
//        [self.contentView.collectionViewLayout invalidateLayout];
        [self.contentManager workWithNewItems:newItems complititionBlock:^(NSArray *result) {
            
            
//            [self.contentView.collectionViewLayout invalidateLayout];
//            self.contentManager.ppm_currentPage+=self.ppm_pageSize;
//           [self.contentView.collectionViewLayout invalidateLayout];
            [self.contentView reloadData];
            
        }];
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [self.contentView setFrame:self.view.bounds];
  

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    if (self.keyboardIsVisible) {
        [self.inputAccessoryView setFrame:CGRectMake(0, self._fakeInputView.superview.frame.origin.y-64, self.view.frame.size.width, [self._fakeInputView frame].size.height)];
    }else{
        [self.inputAccessoryView setFrame:CGRectMake(0, self.view.frame.size.height-[self.inputAccessoryView ppm_height], self.view.frame.size.width, [self.inputAccessoryView ppm_height])];
    }
    

    [self.contentView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2)];
    
}

#pragma mark - PPMessengerInputAccessoryViewDelegate


-(void)ppmiav_accessoryView:(PPMessengerInputAccessoryView *)inputAccessoryView wantsToSendText:(NSString *)text shouldClean:(BOOL *)shouldClean shouldResingResponder:(BOOL *)resignResponder{
    
    
    
    
    
  
    
    *resignResponder=YES;
    *shouldClean=YES;
    
    [self.contentConsumer ppm_shoudSendTextMessageWithText:text];
    
}


#pragma mark - UICollectionViewDataSource

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeZero;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self contentManager] ppm_numberItemsInGroupAtIndex:section];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    id<PPMessengerContentDisplayObjectProt> disp = [self.contentManager ppm_displayObjectAtIndexPath:indexPath];
    
     float sc = self.reversed?-1.0:1.0;
    Class cl;
    PPMessengerContentConfigurationBlock configBlock;
    NSString * indif;
    
    [disp ppm_generateDisplayViewClass:&cl andIndifiter:&indif andConfigurateBlock:&configBlock];
    
    if (!cl) {
        if (![self._registredViews valueForKey:kind]) {
             [self.contentView registerClass:[disp ppm_reusableViewClass] forSupplementaryViewOfKind:kind withReuseIdentifier:kind];
        }
        UICollectionReusableView<PPMessengerReusableViewProt> * rv = ( UICollectionReusableView<PPMessengerReusableViewProt> *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kind forIndexPath:indexPath];
        
        
//                 rv.transform=CGAffineTransformMakeScale(1.0, sc);
        return rv;
    }else{
        
        
        BOOL initalAdd=NO;
        if (![self._registredViews valueForKey:indif]) {
            initalAdd=YES;
            
            
            [self.contentView registerClass:[disp ppm_reusableViewClass] forSupplementaryViewOfKind:kind withReuseIdentifier:indif];
            [self._registredViews setValue:@YES forKey:indif];
        }
        
        UICollectionReusableView<PPMessengerReusableViewProt> * rv = ( UICollectionReusableView<PPMessengerReusableViewProt> *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:indif forIndexPath:indexPath];
        
        
        if ( (initalAdd || !rv.displayView )) {
            
            [rv setContentInsets:[disp ppm_contentInsets]];
            [rv setDisplayView:[[cl alloc ] init]];
        }
        
        if (configBlock) {
            configBlock(rv.displayView);
        }
        
          rv.transform=CGAffineTransformMakeScale(1.0, sc);
        return rv;

    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell<PPMessengerReusableViewProt> * cell =  (UICollectionViewCell<PPMessengerReusableViewProt>*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ppm_bubble" forIndexPath:indexPath];
    
    
    
    return cell;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [[self contentManager] ppm_numberOfGroups];
}
#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    
   
    if ([self.contentManager ppm_isLoaderCellSection:indexPath.section]) {
        
        if ([[self.contentManager ppm_loaderObject] ppm_loadState]!=PPMLoaderDisplayObjectStateLoading) {
            
            [[self.contentManager ppm_loaderObject] setPpm_loadState:PPMLoaderDisplayObjectStateLoading];
            [self loadCurrentPage];
            
        }

    }
    
}

#pragma mark - PPMessengerCollectionViewLayoutDelegate
-(CGSize)ppml_getContentSize{
    return CGSizeMake(self.view.frame.size.width, [self.contentManager ppm_totalH]);
}
-(NSArray<PPMessengerContentDisplayGroupProt> *)ppml_getAllGroups{
    return (NSArray<PPMessengerContentDisplayGroupProt>*)[self.contentManager ppm_items];
}
-(id<PPMessengerContentDisplayGroupProt>)ppml_getGropForSection:(NSInteger)section{
    
   return  [self.contentManager ppm_groupAtIndex:section];
    
}
-(id<PPMessengerConstructionProt>)ppml_getConstructorForType:(NSString *)type{
    return [self._constructors objectForKey:type];
}

#pragma mark - PPMessengerContentManagerDelegate


-(CGSize)ppmcm_getSize{
   return  self.view.frame.size;
}
-(id<PPMessengerConstructionProt>)ppmcm_getConstructorForType:(NSString*)type{
       id<PPMessengerConstructionProt> constructor = [self._constructors objectForKey:type];
    return constructor;
}

-(CGSize)ppmcm_getContentAvailableSizeForType:(NSString *)type{
    
    id<PPMessengerConstructionProt> constructor = [self._constructors objectForKey:type];
    CGSize s = [constructor getAvailableContentSizeOnGlobalSize:self.view.frame.size];
    return s;
}

#pragma mark - PPMessengerInputAccessoryViewObserver
-(void)ppm_inputAccesoryView:(UIView<PPMessengerInputAccessoryViewProt> *)inputAccessoryView didChangeHeight:(float)height{
    NSLog(@"FH:%f",[self._fakeInputView frame].size.height);
    [self._fakeInputView setFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    [self.view setNeedsLayout];
    NSLog(@"FH:%f",[self._fakeInputView frame].size.height);
}
#pragma mark - _PPMessengerFakeInputAccessoryViewDelegate
-(void)_ppm_fakeInput:(_PPMessengerFakeInputAccessoryView *)fakeInput superViewDidChangeFrame:(CGRect)newFrame{
    
    NSLog(@"%@",NSStringFromCGRect (newFrame));
    
    [self.inputAccessoryView setCenter:CGPointMake(self.view.frame.size.width/2, MIN(self.view.frame.size.height-[self.inputAccessoryView ppm_height]/2,  newFrame.origin.y+[self.inputAccessoryView ppm_height]/2-64))];
  CGRect realRect =  [self.view convertRect:newFrame fromView:fakeInput.superview];
        NSLog(@"%@",NSStringFromCGRect (realRect));

//    [self.view setNeedsLayout];
    
}

#pragma mark - setters

-(void)setReversed:(BOOL)reversed{
    if (reversed==_reversed) {
        return;
    }
    _reversed=reversed;
    [self.contentViewLayout setReversed:reversed];
    float sc = _reversed?-1.0:1.0;
    [self.contentManager setPpm_reversed:reversed];
    [self.contentView.collectionViewLayout invalidateLayout];
    [self.contentView reloadData];
    self.contentView.transform=CGAffineTransformMakeScale(1.0, sc);
    
    [self loadCurrentPage];
}
#pragma mark - kb relativ
-(void)setKeyboardIsVisible:(BOOL)keyboardIsVisible{
    _keyboardIsVisible=keyboardIsVisible;
    if (!self.reversed&&keyboardIsVisible  ) {
        self.reversed=YES;
    }

    
}
#pragma makr - keyboard observing

-(void)keyBoardWillShow:(NSNotification*)notification{
    NSLog(@"keyBoardWillShow");
  
}
-(void)keyBoardDidShow:(NSNotification*)notification{
    NSLog(@"keyBoardDidShow");
      self.keyboardIsVisible=YES;
}
-(void)keyBoardWillHide:(NSNotification*)notification{
      NSLog(@"keyBoardWillHide");
}
-(void)keyBoardDidHide:(NSNotification*)notification{
        NSLog(@"keyBoardDidHide");
      self.keyboardIsVisible=NO;
}

#pragma mark - registration


-(void)ppm_registerContructor:(id<PPMessengerConstructionProt>)construcor{
    [self._constructors setValue:construcor forKey:[construcor ppm_type]];
}
#pragma mark - lazy init
-(NSMutableDictionary *)_registredViews{
    if (!__registredViews) {
        __registredViews=[[NSMutableDictionary alloc] init];
    }
    return __registredViews;
}
-(NSMutableDictionary *)_constructors{
    if (!__constructors) {
        __constructors=[[NSMutableDictionary alloc] init];
    }
    return __constructors;
    
    
}

-(id<PPMessengerContentManagerProt>)contentManager{
    if (!_contentManager) {
        _contentManager=[[[self ppm_classForContentManager] alloc] init];
        [_contentManager setDelegate:self];
    }
    return _contentManager;
}

#pragma mark views

-(PPMessengerCollectionViewLayout *)contentViewLayout{
    if (!_contentViewLayout) {
        _contentViewLayout=[[PPMessengerCollectionViewLayout alloc] init];
        [_contentViewLayout setDelegate:self];
    }
    return _contentViewLayout;
}
-(PPMessengerCollectionView *)contentView{
    if (!_contentView) {
        _contentView=[[PPMessengerCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.contentViewLayout];
        [_contentView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];
        [_contentView setDelegate:self];
        [_contentView setDataSource:self];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [self.view insertSubview:_contentView atIndex:0];
        
        
    }
    return _contentView;
}
-(UIView<PPMessengerInputAccessoryViewProt> *)inputAccessoryView{
    
    if (!_inputAccessoryView) {
        _inputAccessoryView=[[[self ppm_classForInputAccesoryView] alloc] initWithHeight:50 andObserver:self];
        [[_inputAccessoryView ppm_inputTextView] setInputAccessoryView:self._fakeInputView];
        
        if ([_inputAccessoryView isKindOfClass:[PPMessengerInputAccessoryView class]]) {
            [(PPMessengerInputAccessoryView*)_inputAccessoryView setDelegate:self];
        }
        
        [self.view insertSubview:_inputAccessoryView aboveSubview:self.contentView];
    }
    return _inputAccessoryView;
    
}
-(_PPMessengerFakeInputAccessoryView *)_fakeInputView{
    if (!__fakeInputView) {
        __fakeInputView=[[_PPMessengerFakeInputAccessoryView alloc] init];
        [__fakeInputView setDelegate:self];
        [__fakeInputView setRealInputView:self.inputAccessoryView];
    }
    return __fakeInputView;
    
}



#pragma mark - setup methods
-(Class)ppm_classForInputAccesoryView{
    return [PPMessengerInputAccessoryView class];
}
-(Class)ppm_classForContentManager{
    return [PPMessengerContentManager class];
}
@end
