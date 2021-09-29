//
//  ImageViewController.swift
//  FinderManager
//
//  Created by Никита Коголенок on 16.09.21.
//

import UIKit

class ImageViewController: UIViewController {
    
    // MARK: - Variables
    var image: UIImage?
    var imagePath: URL?
    
    // MARK: - Outlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        scrollView.delegate = self
        setUpImageView()
    }
    
    // MARK: - Method
    private func setUpImageView() {
        guard let imagePath = self.imagePath else { return }
        
        let image = UIImage(contentsOfFile: imagePath.path)
        self.image = image
        self.imageView.image = image
    }
    
    // MARK: - Actions
    @IBAction func shareAction(_ sender: Any) {
        
        guard let image = self.image else { return }
        let shareControlle = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        shareControlle.completionWithItemsHandler = { _, bool, _, _ in
            if bool {
                print("All good")
            }
        }
        present(shareControlle, animated: true, completion: nil)
    }
}

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


