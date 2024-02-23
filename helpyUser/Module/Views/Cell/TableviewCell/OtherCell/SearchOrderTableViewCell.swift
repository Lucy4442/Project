//
//  SearchOrderTableViewCell.swift
//  Helpy
//
//  Created by mac on 17/12/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol SearchDelegate {
    func SearchCategory(text: String)
}

class SearchOrderTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var SearchView: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var delegate : SearchDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        txtSearch.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        SearchView.roundCorners([.allCorners], radius: 17)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        textField.resignFirstResponder()
        if let text = textField.text,let textRange = Range(range, in: text) {
            var updatedText = text.replacingCharacters(in: textRange,with: string)
            updatedText = updatedText.replacingOccurrences(of: "\n", with: "")
                delegate?.SearchCategory(text: updatedText)
        }
        return true
    }
}
