//
//  ViewController+Extension.swift
//  FinderManager
//
//  Created by Никита Коголенок on 29.09.21.
//

import UIKit

// MARK: - ViewController: UITableViewDelegate
//extension ViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let element = fileSystemElements[indexPath.row]
//
//        switch element.type {
//        case .directory:
//            return 50
//        case.image:
//            return 100
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        handleItemSelect(indexPath: indexPath)
//    }
//
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let movedFileSystemElements = fileSystemElements.remove(at: sourceIndexPath.row)
//        fileSystemElements.insert(movedFileSystemElements, at: destinationIndexPath.row)
//    }
//
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            fileSystemElements.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//}

//// MARK: - ViewController: UITableViewDataSource
//extension ViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        fileSystemElements.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let element = fileSystemElements[indexPath.row]
//        let cell: UITableViewCell
//
//        switch element.type {
//
//        case .directory:
//            guard let directoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: DirectoryTableViewCell.id,
//                                                                             for: indexPath) as? DirectoryTableViewCell
//            else { return UITableViewCell() }
//            directoryTableViewCell.finderName = element.url.lastPathComponent
//
//            cell = directoryTableViewCell
//
//        case .image:
//            guard let imageTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.id,
//                                                                         for: indexPath) as? ImageTableViewCell
//            else { return UITableViewCell() }
//            imageTableViewCell.imagePath = element.url
//
//            cell = imageTableViewCell
//        }
//
//        cell.setSelected(tableView.indexPathsForSelectedRows?.contains(indexPath) == true, animated: true)
//
//        return cell
//    }
//}
