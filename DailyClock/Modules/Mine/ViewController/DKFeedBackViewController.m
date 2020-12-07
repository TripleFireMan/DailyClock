//
//  SYFeedBackViewController.m
//  SuoYi
//
//  Created by 成焱 on 2019/8/27.
//  Copyright © 2019 sy. All rights reserved.
//

#import "DKFeedBackViewController.h"
#import "CYEvaluate.h"
#import "DKResultObject.h"

#define BG_GRAY_COLOR RGBColor(249, 249, 249)
#define SY_MAX_INPUT 150

NSString * const k_TextFeedBackKey = @"k_TextFeedBackKey";
NSString * const k_PicUrlFeedBackKey = @"k_PicUrlFeedBackKey";
NSString * const k_MobilePhoneKey = @"k_MobilePhoneKey";

@interface DKFeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *phoneView;
@property (nonatomic, strong) UILabel *phoneLbl;
@property (nonatomic, strong) UIView *phoneTFContent;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UIView *feedBackView;
@property (nonatomic, strong) UILabel *feedBackLbl;
@property (nonatomic, strong) UILabel *feedBackNumberLbl;
@property (nonatomic, strong) UITextView *feedBackTextView;
@property (nonatomic, strong) UIView *feedBackContentView;
@property (nonatomic, strong) UIView *imgContentView;
@property (nonatomic, strong) UILabel *imgLabel;
@property (nonatomic, strong) UIView *imgBGView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UIImage *currentUploadImage;
@property (nonatomic, strong) DKResultObject *uploadImg;

@end

@implementation DKFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"问题反馈"];
    [self setupSubview];
    [self addConstraints];
    [self bindViews];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void) setupSubview
{
    @weakify(self);
    self.scrollView = [UIScrollView new];
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.delaysContentTouches = NO;
    [self.view addSubview:self.scrollView];
    
    self.phoneView = [UIView new];
    [self.scrollView addSubview:self.phoneView];
    
    self.phoneLbl = [UILabel new];
    self.phoneLbl.text = @"请输入手机号码";
    self.phoneLbl.font = DKBoldFont(16);
    
    [self.phoneView addSubview:self.phoneLbl];
    
    self.phoneTFContent = [UIView new];

    self.phoneTFContent.layer.cornerRadius = 5.f;
    [self.phoneView addSubview:self.phoneTFContent];
    
    
    self.phoneTF = [UITextField new];
//    self.phoneTF.backgroundColor = BG_GRAY_COLOR;
//    self.phoneTF.layer.cornerRadius = 5.f;
//    self.phoneTF.layer.masksToBounds = YES;
    self.phoneTF.keyboardType = UIKeyboardTypeNamePhonePad;
    self.phoneTF.placeholder = @"请输入手机号码，仅用于我们向您核实问题";
    self.phoneTF.font = DKFont(15);
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
    [self.phoneTFContent addSubview:self.phoneTF];
    
    self.feedBackView = [UIView new];
    [self.scrollView addSubview:self.feedBackView];
    
    self.feedBackLbl = [UILabel new];
    self.feedBackLbl.text = @"请输入反馈内容";
    self.feedBackLbl.font = DKBoldFont(16);
    
    [self.feedBackView addSubview:self.feedBackLbl];
    
    self.feedBackContentView = [UIView new];



    
    
    
    self.feedBackContentView.layer.cornerRadius = 5.f;
    [self.feedBackView addSubview:self.feedBackContentView];
    
    self.feedBackTextView = [UITextView new];
    //    self.textView.text = @"请输入您申请换卡的理由";
    
    self.feedBackTextView.delegate = self;
    self.feedBackTextView.layer.cornerRadius = 5.0f;
    
    [self.feedBackContentView addSubview:self.feedBackTextView];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"在此输入您遇到的问题，很抱歉给您带来不好的体验，我们会尽快和您联系";
    placeHolderLabel.numberOfLines = 0;
    
    [placeHolderLabel sizeToFit];
    [self.feedBackTextView addSubview:placeHolderLabel];
    
    // same font
    self.feedBackTextView.font = DKFont(15);
    placeHolderLabel.font = DKFont(15);
    [self.feedBackTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    
    self.feedBackNumberLbl = [UILabel new];
    
    self.feedBackNumberLbl.text = @"0/150";
    self.feedBackNumberLbl.textAlignment = NSTextAlignmentRight;
    self.feedBackNumberLbl.font = CYBebas(15);
    [self.feedBackView addSubview:self.feedBackNumberLbl];
    
    self.imgContentView = [UIView new];
    [self.scrollView addSubview:self.imgContentView];
    
    self.imgBGView = [UIView new];
    
    [self.imgContentView addSubview:self.imgBGView];
    
    
    self.feedBackContentView.backgroundColor = DKIOS13ContainerColor();
    self.imgBGView.backgroundColor = DKIOS13ContainerColor();
    self.phoneTFContent.backgroundColor = DKIOS13ContainerColor();
    
    self.phoneTF.textColor = DKIOS13LabelColor();
    self.feedBackNumberLbl.textColor = DKIOS13LabelColor();
    placeHolderLabel.textColor = DKIOS13PlaceholderTextColor();
    self.feedBackTextView.textColor = DKIOS13PlaceholderTextColor();
    self.feedBackLbl.textColor = DKIOS13LabelColor();
    self.phoneLbl.textColor = DKIOS13LabelColor();
    self.feedBackTextView.backgroundColor = DKIOS13ContainerColor();
    
    
    
    self.imageView = [UIImageView new];
    self.imageView.layer.cornerRadius = 5.0f;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.image = [UIImage imageNamed:@"sy_mine_camera"];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self.imgBGView addSubview:self.imageView];
    
    self.imgLabel = [UILabel new];
    self.imgLabel.text = @"非必填项";
    self.imgLabel.textColor = RGBColor(120, 120, 120);
    self.imgLabel.font = DKFont(15);
    [self.imgContentView addSubview:self.imgLabel];
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.confirmBtn.titleLabel.font = DKFont(15);
    [self.confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundImage:[UIImage imageWithColor:kMainColor] forState:UIControlStateNormal];
    [self.confirmBtn setBackgroundImage:[UIImage imageWithColor:[kMainColor colorWithAlphaComponent:0.8f]] forState:UIControlStateHighlighted];
    self.confirmBtn.layer.cornerRadius = 22;
    self.confirmBtn.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.confirmBtn];
    
    [[self.confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        vibrate();
        NSString *phone = self.phoneTF.text;
        NSString *content = self.feedBackTextView.text;
        NSString *title = @"极简打卡APP问题反馈";
        NSString *img = self.uploadImg.data;
        NSMutableDictionary *dic = @{}.mutableCopy;
        dic[@"phone"] = phone;
        dic[@"content"] = content;
        dic[@"title"] = title;
        if (!CYStringIsEmpty(img)) {
            dic[@"imgs"] = img;
        }
        if ([content length] == 0) {
            MBProgressShowWithText(@"反馈内容不能为空");
            return;
        }

        if ([CYEvaluate validateMobile:self.phoneTF.text] == NO) {
            MBProgressShowWithText(@"请输入正确的手机号");
            return;
        }
        
        [HttpTool POST:FeedBack parameters:dic HUD:YES success:^(id responseObject) {
            MBProgressShowWithText(@"您的反馈已提交，谢谢合作");
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            MBProgressShowWithText(error.localizedDescription);
        }];
    }];
    
}

- (void) addConstraints
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(CY_Height_NavBar);
        make.left.right.offset(0);
        make.bottom.offset(-CY_Height_Bottom_SafeArea);
    }];
    
    [self.phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.left.offset(15);
        make.top.offset(15);
    }];
    
    [self.phoneLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(0);
        make.height.offset(50);
    }];
    
    [self.phoneTFContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.phoneLbl.mas_bottom).offset(0);
        make.height.offset(50);
        make.bottom.offset(-10);
    }];

    [self.phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(-10);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    [self.feedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(self.phoneView.mas_bottom);
    }];
    
    [self.feedBackLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(50);
    }];
    
    [self.feedBackContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.mas_equalTo(self.feedBackLbl.mas_bottom);
        make.height.offset(135);
    }];
    
    [self.feedBackTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 8, 0, 8));
    }];
    
    [self.feedBackNumberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.top.mas_equalTo(self.feedBackTextView.mas_bottom).offset(5);
        make.bottom.offset(-5);
    }];
    
    [self.imgContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.top.mas_equalTo(self.feedBackView.mas_bottom);
    }];
    
    [self.imgBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(0);
        make.height.width.offset(70);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
    }];
    
    
    
    [self.imgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.imageView);
        make.bottom.offset(-5);
    }];
    
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.right.offset(-15);
        make.centerX.offset(0);
        make.height.offset(44);
        make.top.mas_equalTo(self.imgContentView.mas_bottom).offset(50);
        make.bottom.mas_lessThanOrEqualTo(-100);
    }];
    
}

- (void) bindViews
{
    @weakify(self);
    
    [[self.feedBackTextView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        NSInteger length = [x length];
        if (length < SY_MAX_INPUT) {
            self.feedBackNumberLbl.text = [NSString stringWithFormat:@"%@/%@",@(length),@(SY_MAX_INPUT)];
        }
        else{
            self.feedBackTextView.text = [[self.feedBackTextView text] substringToIndex:SY_MAX_INPUT];
            self.feedBackNumberLbl.text = [NSString stringWithFormat:@"%@/%@",@(self.feedBackTextView.text.length),@(SY_MAX_INPUT)];
        }
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self uploadImage];
    }];
    tap.numberOfTapsRequired = 1;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:tap];
    
    
    [[self.phoneTF rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if ([x length] >= 11) {
            self.phoneTF.text = [[self.phoneTF text] substringToIndex:11];
        }
    }];
    
    
}



- (void) uploadImage
{
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushToCamera];
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushToAlbum];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertCtl addAction:camera];
    [alertCtl addAction:album];
    [alertCtl addAction:cancel];
    [self presentViewController:alertCtl animated:YES completion:nil];
    
}

- (void) pushToCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        MBProgressShowWithText(@"相机不可用");
    } else {
        UIImagePickerController * vc = [[UIImagePickerController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.allowsEditing = YES;
        vc.delegate = self;
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:vc animated:YES completion:^{
            vc.navigationBar.translucent = YES;
        }];
    }
}

- (void)pushToAlbum {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        MBProgressShowWithText(@"相机不可用");
    } else {
        UIImagePickerController * vc = [[UIImagePickerController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        vc.allowsEditing = YES;
        vc.delegate = self;
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:vc animated:YES completion:^{
            vc.navigationBar.translucent = YES;
        }];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    self.currentUploadImage = img;
    NSData *imgData = UIImageJPEGRepresentation(img, 0.6);
    double fileLength = [imgData length];
    NSLog(@"filelength == %@MB",@(fileLength / (1024.f * 1024.f)));
    if (fileLength > 3 * 1024.f * 1024.f) {
        MBProgressShowWithText(@"文件太大，允许上传最大图片为3MB");
        return;
    }
    [HttpTool UPLOAD:UploadImge parameters:@{@"picture":imgData} HUD:YES success:^(id responseObject) {
        DKResultObject *obj = [DKResultObject modelWithJSON:responseObject];
        if (obj.status == 0) {
            self.imageView.image = self.currentUploadImage;
            MBProgressShowWithText(@"上传图片成功");
            self.uploadImg = obj;
        }
        else{
            MBProgressShowWithText(obj.message);
        }
    } failure:^(NSError *error) {
        MBProgressShowWithText(@"上传图片失败");
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)modefileAvtor
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.image = self.currentUploadImage;
}





@end
