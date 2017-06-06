//
//  CameraView.swift
//  fp_ios
//
//  Created by wss on 15/8/25.
//  Copyright (c) 2015年 yushuhui. All rights reserved.
//用法
/*

1、init
2、 func showCamera(selectImg:SelectedImageBlock)
*/


import UIKit

typealias SelectedImageBlock = (_ selectImg:UIImage,_ imgName:String,_ imgPath:String)->Void

class CameraView: UIView,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var selectedImage:SelectedImageBlock!
    var picker:UIImagePickerController!
    var pickerCameraView:UITableView!
    var window1:UIWindow!
    var titleArr:Array<String>!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2);

        
        //
        pickerCameraView = UITableView(frame: CGRect(x: 0, y: SRC_HEIGHT, width: SRC_WIDTH, height: 40*3))
        pickerCameraView.delegate = self
        pickerCameraView.dataSource = self
        pickerCameraView.register(UITableViewCell.self , forCellReuseIdentifier: "cameraCell")
        self.addSubview(pickerCameraView)
        pickerCameraView.isScrollEnabled = false
        window1 = UIApplication.shared.delegate?.window!
        titleArr = ["拍照","从手机相册选择","取消"]
        
    }

    //图片地址
    func imageBasePath(_ imageName:String!) -> String {
        
        //图片路径
        let documentPath:String = (NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true).first as String?)!
        let imageDocPath:String = documentPath + "/userImg";
        
        do {
            try FileManager.default.createDirectory(atPath: imageDocPath, withIntermediateDirectories: true, attributes: nil)
            
        } catch {
            print("error")
        }
        
        
        
        let imageBasePath:String = imageDocPath + "/" + imageName
        return imageBasePath;
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cameraCell", for: indexPath)
        for subV in cell.contentView.subviews{
            subV.removeFromSuperview()
        }
        
        //title
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: SRC_WIDTH, height: cell.contentView.height))
        label.textAlignment = NSTextAlignment.center
        label.text = titleArr[indexPath.row]
        cell.contentView.addSubview(label)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch (indexPath.row){
        case 0://拍照
            cameraBtnClick()
            break
        case 1: pictureBtnClick()
            break
        case 2:
            self.removeFromSuperview()
            pickerCameraView.transform = CGAffineTransform.identity
            
            break
        default: break
            
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //TODO:弹出
//    func showCamera(_ selectImg:SelectedImageBlock){
//        self.selectedImage = selectImg
//        
//        UIView.animate(withDuration: 0.3, animations: { () -> Void in
//           self.window1.addSubview(self)
//           self.pickerCameraView.transform = CGAffineTransform(translationX: 0, y: -self.pickerCameraView.height)
//            
//        })
//        
//    }
    
    //消失
    #if __CC_PLATFORM_IOS
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
    self.removeFromSuperview()
    pickerCameraView.transform = CGAffineTransformIdentity
    
    }
    #endif
    
    
    
    //相册
    func  pictureBtnClick(){
        self.isHidden = true
        picker = UIImagePickerController()
        picker.delegate = self
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
              let rootVC:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
              rootVC.present(picker, animated: true, completion: { () -> Void in
            
              })
        }
        
    }
    //相机
    func cameraBtnClick(){
        self.isHidden = true

        picker = UIImagePickerController()
        picker.delegate = self
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker.sourceType = UIImagePickerControllerSourceType.camera

            let rootVC:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            rootVC.present(picker, animated: true, completion: { () -> Void in
                
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        if(image != nil){
            //写入
            let arr:Array<String> = saveImgToImagePath(image)
            self.selectedImage(image,arr.last!,arr.first!)
            

        }
        
        //消失
        self.removeFromSuperview()
        picker.dismiss(animated: true, completion: nil)
    }
    
    //存储图片
    func saveImgToImagePath(_ img:UIImage) -> Array<String>{
        //MARK: 上传头像
        var imgData:Data! = Data()
        if ((UIImagePNGRepresentation(img)) != nil) {
            //返回为png图像。
            imgData = UIImagePNGRepresentation(img);
        }else {
            //返回为JPEG图像。
            imgData = UIImageJPEGRepresentation(img, 1.0);
        }
        
        //压缩
        let size:CGFloat = 1024 * 200;
        var current_size:CGFloat = 0;
        var actual_size:CGFloat = 0;
        current_size = CGFloat(imgData.count);
        if (current_size > size)
        {
            actual_size = size / current_size;
            imgData = UIImageJPEGRepresentation(img, actual_size)
        }
        //图片名
        let date:Date = Date(timeIntervalSinceNow: 0)
        let format:DateFormatter = DateFormatter()
        format.dateFormat = "YYYYMMDDHHmmss"
        let dateStr:String = format.string(from: date)
        let imgName:String = "image" + dateStr + ".png"
//        imgData.write(to: <#T##URL#>, options: <#T##Data.WritingOptions#>)
//        imgData.write(toFile: imageBasePath(imgName), atomically: true)
        
        var arr:Array<String> = Array()
        arr.append(imageBasePath(imgName))
        arr.append(imgName)
        return arr
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFromSuperview()
    }
    
}
