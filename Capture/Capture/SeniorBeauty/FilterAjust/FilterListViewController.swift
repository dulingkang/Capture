//
//  FilterListViewController.swift
//  Core Image Explorer
//
//  Created by Warren Moore on 1/6/15.
//  Copyright (c) 2015 objc.io. All rights reserved.
//

import UIKit

class FilterListViewController: UITableViewController{
    let filters: [(filterName: String, filterDisplayName: String)] = [
        ("CIBloom", "Bloom"),
        ("CIColorControls", "Color Controls"),
        ("CIColorInvert", "Color Invert"),
        ("CIColorPosterize", "Color Posterize"),
        ("CIExposureAdjust", "Exposure Adjust"),
        ("CIGammaAdjust", "Gamma Adjust"),
        ("CIGaussianBlur", "Gaussian Blur"),
        ("CIGloom", "Gloom"),
        ("CIHighlightShadowAdjust", "Highlights and Shadows"),
        ("CIHueAdjust", "Hue Adjust"),
        ("CILanczosScaleTransform", "Lanczos Scale Transform"),
        ("CIMaximumComponent", "Maximum Component"),
        ("CIMinimumComponent", "Minimum Component"),
        ("CISepiaTone", "Sepia Tone"),
        ("CISharpenLuminance", "Sharpen Luminance"),
        ("CIStraightenFilter", "Straighten"),
        ("CIUnsharpMask", "Unsharp Mask"),
        ("CIVibrance", "Vibrance"),
        ("CIVignette", "Vignette")
    ]

    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "SystemFilterCell"
        let filterProperties: (filterName: String, filterDisplayName: String) = filters[indexPath.row]
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as UITableViewCell

        cell.textLabel!.text = filterProperties.filterDisplayName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = FilterDetailViewController.init()
        controller.filterName = filters[indexPath.row].filterName
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

