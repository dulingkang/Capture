//
//  FilterDetailViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

protocol FilterDetailViewControllerDelegate {
    func filterFinished(image: UIImage)
}
class FilterDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, APCancelConfirmViewDelegate, ParameterAdjustmentDelegate {
    var filterName: String!
    var filter: CIFilter!
    var filteredImageView: APBeautyMainMiddleScrollView!
    var parameterAdjustmentView: ParameterAdjustmentView!
    var delegate: FilterDetailViewControllerDelegate?
    var image: UIImage?
    var inputImage: CIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        addSubviews()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    //MARK: - delegate
    func cancelButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func confirmButtonPressed() {
        ImageModel.sharedInstance.currentImage = self.generateImage()
        let controllers = self.navigationController?.viewControllers
        self.navigationController?.popToViewController(controllers![controllers!.count - 3], animated: true)
    }
    
    func parameterValueDidChange(parameter: ScalarFilterParameter) {
        filter.setValue(parameter.currentValue, forKey: parameter.key)
        self.filteredImageView.imageView.image = self.generateImage()
    }
    
    func filterParameterDescriptors() -> [ScalarFilterParameter] {
        let inputNames = (filter.inputKeys as [String]).filter { (parameterName) -> Bool in
            return (parameterName as String) != "inputImage"
        }

        let attributes = filter.attributes

        return inputNames.map { (inputName: String) -> ScalarFilterParameter in
            let attribute = attributes[inputName] as! [String : AnyObject]
            // strip "input" from the start of the parameter name to make it more presentation-friendly
            let displayName = inputName[inputName.startIndex.advancedBy(5)..<inputName.endIndex]
            let minValue = attribute[kCIAttributeSliderMin] as! Float
            let maxValue = attribute[kCIAttributeSliderMax] as! Float
            let defaultValue = attribute[kCIAttributeDefault] as! Float

            return ScalarFilterParameter(name: displayName, key: inputName,
                                         minimumValue: minValue, maximumValue: maxValue, currentValue: defaultValue)
        }
    }

    func addSubviews() {
        filter = CIFilter(name: filterName)
        
        let topView = APCancelConfirmView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        topView.delegate = self
        topView.title = filter.attributes[kCIAttributeFilterDisplayName] as! String
        self.view.addSubview(topView)
        
        filteredImageView = APBeautyMainMiddleScrollView.init(frame: CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight*0.6))
        if kScreenHeight == kIphone4sHeight {
            filteredImageView.frame = CGRectMake(0, kNavigationHeight, kScreenWidth, kScreenHeight*0.54)
        }
        self.inputImage = CIImage(image: ImageModel.sharedInstance.currentImage!)
        filter.setValue(self.inputImage, forKey: "inputImage")
        filteredImageView.clipsToBounds = true
        filteredImageView.backgroundColor = view.backgroundColor
        view.addSubview(filteredImageView)

        parameterAdjustmentView = ParameterAdjustmentView(frame: CGRectMake(0, filteredImageView.height + kNavigationHeight + 15, kScreenWidth, self.view.height/2), parameters: filterParameterDescriptors())
        if kScreenHeight == kIphone4sHeight {
            parameterAdjustmentView.frame = CGRectMake(0, filteredImageView.height + 5, kScreenWidth, self.view.height/2)
        }
        parameterAdjustmentView.setAdjustmentDelegate(self)
        view.addSubview(parameterAdjustmentView)
    }
    
    func generateImage() -> UIImage? {
        let ciContext = CIContext(options: nil)
        let cgImage = ciContext.createCGImage(filter.outputImage!, fromRect: self.inputImage!.extent)
        let image = UIImage(CGImage: cgImage)
        return image
    }
    
    
}
