//
//  ImageCollectionViewCell.swift
//  FinderManager
//
//  Created by Никита Коголенок on 20.09.21.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

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
        
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .yellow : .clear
        }
    }
    
    // MARK: - Method
    private func setUpCell() {
        guard let imagePath = self.imagePath else { return }
        
        imagePreviewView.image = UIImage(contentsOfFile: imagePath.path)
        imageNameLabel.text = imagePath.lastPathComponent
    }

}
