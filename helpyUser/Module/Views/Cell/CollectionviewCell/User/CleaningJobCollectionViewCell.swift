//
//  CleaningJobCollectionViewCell.swift
//  Helpy
//
//  Created by mac on 10/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SDWebImage

//MARK: ==========CleaningJobCollectionViewCell==========
class CleaningJobCollectionViewCell: UICollectionViewCell {
    
    
//    @IBOutlet weak var imageWidth: NSLayoutConstraint!
//    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    //MARK: ==========Outlet==========
    @IBOutlet weak var CleaningJobView: UIView!
    @IBOutlet weak var ImgCleaningJob: UIImageView!
    @IBOutlet weak var CleaningJobTitle: UILabel!
    @IBOutlet weak var CleaningJobTime: UILabel!
    
    //MARK: ==========Variable==========
    var job = CleaningJob() {
        didSet {
            CleaningJobTitle.text = job.name!
            ImgCleaningJob.image = UIImage(named: job.image ?? "")
            CleaningJobTime.text = job.time!
            CleaningJobView.backgroundColor = job.isselected ? UIColor(named: "App_LightBlue_Color") : UIColor(named: "App_SemiBackground_Color")
            CleaningJobTitle.textColor = job.isselected ? UIColor(named: "App_White_Color") : UIColor(named: "App_Navyblue_Color")
            CleaningJobTime.textColor = job.isselected ? UIColor(named: "App_White_Color") : UIColor(named: "App_Navyblue_Color")
        }
    }
    //MARK: ==========awakeFromNib==========
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: ==========layoutSubviews==========
    override func layoutSubviews() {
        CleaningJobView.roundCorners([.allCorners], radius: 20)
        ImgCleaningJob.roundCorners([.allCorners], radius: 20)
        CleaningJobTitle.font = UIFont.AppFont(Name: FontName.Poppins_Medium, size: 30)
        CleaningJobTitle.textColor = UIColor.App_NavyBlue
        CleaningJobTitle.numberOfLines = 0
    }
//    override func draw(_ rect: CGRect) {
//        imageHeight = self.contentView.height * 812 /
//    }
    func ConfigureCell(data: ServiceDetail?){
        CleaningJobTitle.text = data?.name ?? ""
        ImgCleaningJob.getImage(url: data?.image ?? "", placeholderImage: ImageName.Cleaning)
    }
}
