//
//  DirectoryCollectionViewCell.swift
//  FinderManager
//
//  Created by Никита Коголенок on 16.09.21.
//

import UIKit

class DirectoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Varaible
    static let id: String = "directory"
    var directoryName: String? {
        didSet {
            directoryNameLabel.text = directoryName
        }
    }
    
    // MARK: - Outlet
    @IBOutlet weak var directoryNameLabel: UILabel!
    
    // MARK: - AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .yellow : .clear
        }
    }
}
