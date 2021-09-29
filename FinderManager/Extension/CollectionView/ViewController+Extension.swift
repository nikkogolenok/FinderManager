//
//  ViewController+Extension.swift
//  FinderManager
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit

// MARK: - ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
//extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController,
//                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        guard let image = info[.originalImage] as? UIImage,
//              let imageURL = info[.imageURL] as? URL
//        else { return }
//
//        saveImage(image: image, name: imageURL.lastPathComponent)
//
//        picker.dismiss(animated: true, completion: nil)
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
//}
//
//// MARK: - ViewController: UICollectionViewDelegate
//extension ViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 20,
//                            left: 0,
//                            bottom: 0,
//                            right: 20)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        handleItemSelect(indexPath: indexPath)
//    }
//}
//
//// MARK: - ViewController: UICollectionViewDataSource
//extension ViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        fileSystemElements.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let element = fileSystemElements[indexPath.row]
//
//        let cell: UICollectionViewCell
//        switch element.type {
//
//        case .directory:
//            guard let directoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectoryCollectionViewCell.id, for: indexPath) as? DirectoryCollectionViewCell else { return UICollectionViewCell() }
//
//            directoryCollectionViewCell.directoryName = element.url.lastPathComponent
//
//            cell = directoryCollectionViewCell
//
//        case .image:
//            guard let imageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
//
//            imageCollectionViewCell.imagePath = element.url
//
//            cell = imageCollectionViewCell
//        }
//        cell.isSelected = selectedElements.contains(where: {$0 == element })
//
//        return cell
//    }
//}
