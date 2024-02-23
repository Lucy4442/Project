//
//  FavoriteListCollectionViewCell.swift
//  helpyUser
//
//  Created by mac on 08/01/21.
//

import UIKit

class FavoriteListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblrate: UILabel!
    @IBOutlet weak var btnstar: UIButton!
    @IBOutlet weak var btnlocation: UIButton!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lbllocation: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func draw(_ rect: CGRect) {
        mainView.roundCorners([.allCorners], radius: 20)
        imgTitle.roundCorners([.allCorners], radius: 20)
    }
    
    func configureCell(data: FavoriteData?){
        lblrate.text = String(data?.rating ?? 0)
        lbltitle.text = data?.providerName ?? ""
        lblSubtitle.text = data?.jobName ?? ""
        imgTitle.getImage(url: data?.avatar ?? "", placeholderImage: ImageName.Placeholder)
        btnlocation.isHidden = true
        lbllocation.isHidden = true
    }
}
