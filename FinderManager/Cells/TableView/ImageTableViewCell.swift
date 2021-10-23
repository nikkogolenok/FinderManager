//
//  ImageTableViewCell.swift
//  FinderManager
//
//  Created by Никита Коголенок on 15.09.21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    // MARK: - Variables
    static let id: String = "image"
    var imagePath: URL? {
        didSet {
            setUpCell()
        }
    }
    
    // MARK: - Outlet
    @IBOutlet weak var imagePreviewView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    
    // MARK: AwakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        
        backgroundColor = selected ? .gray : .clear
    }
    
    // MARK: - Method
    private func setUpCell() {
        guard let imagePath = self.imagePath else { return }
        
        imagePreviewView.image = UIImage(contentsOfFile: imagePath.path)
        imageNameLabel.text = imagePath.lastPathComponent
    }
}
