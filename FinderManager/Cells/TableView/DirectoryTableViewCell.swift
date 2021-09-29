//
//  DirectoryTableViewCell.swift
//  FinderManager
//
//  Created by Никита Коголенок on 14.09.21.
//

import UIKit

class DirectoryTableViewCell: UITableViewCell {
    
    // MARK: - Variables
    static let id: String = "directory"
    var finderName: String? {
        didSet {
            finderNameLabel.text = finderName
        }
    }
    
    // MARK: - Outlet
    @IBOutlet weak var finderNameLabel: UILabel!
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        
        backgroundColor = selected ? .yellow : .clear
    }
}
