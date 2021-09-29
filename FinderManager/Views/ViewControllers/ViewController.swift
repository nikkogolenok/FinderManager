//
//  ViewController.swift
//  FinderManager
//
//  Created by Никита Коголенок on 14.09.21.
//

import UIKit



enum PresentationMode: String {
    case tableView
    case collectionView
    
    var imageName: String {
        switch self {
        case .tableView:
            return "list.dash"
        case .collectionView:
            return "tablecells"
        }
    }
}

class ViewController: UIViewController {
    
    // MARK: - Variables
    private var fileSystemElements: [FileSystemElement] = []
    private var selectedElements: [FileSystemElement] = []
    private var editModeButton: UIBarButtonItem?
    private var modeButton: UIBarButtonItem?
    
    var url: URL?
    var isEditMode = false
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpCollectionView()
        addRightButtons()
        
        updateFileSystemElements()
        upDateViewMode()
    }
    
    // MARK: - Methods
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        tableView.register(UINib(nibName: "DirectoryTableViewCell", bundle: nil), forCellReuseIdentifier: DirectoryTableViewCell.id)
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: ImageTableViewCell.id)
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "DirectoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: DirectoryCollectionViewCell.id)
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ImageCollectionViewCell.id)
    }
    
    private func menuItems() -> UIMenu {
        
        let menu = UIMenu(title: "Menu",
                          options: .displayInline,
                          children: [
                            UIAction(title: "Add",
                                     image: UIImage(systemName: "folder.fill.badge.plus"),
                                     handler: { _ in
                                         //self.tapToPlus()
                                     })
                          ])
        
        
        return menu
    }
    
    private func addRightButtons() {
        let selectButton = UIBarButtonItem(title: isEditMode ? "Cancel" : "Select",
                                           style: .plain,
                                           target: self,
                                           action: #selector(changeEditMode))
        
        self.editModeButton = selectButton
        
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(tapToPlus))
        
        let modeButtonImage = UIImage(systemName: UserDefaultsManager.shared.presentationMode.imageName)
        let modeButton = UIBarButtonItem(image: modeButtonImage,
                                         style: .done,
                                         target: self,
                                         action: #selector(changeViewMode))
                                         
                                         
        modeButton.image = UIImage(systemName: UserDefaultsManager.shared.presentationMode.imageName)
        self.modeButton = modeButton
        
        navigationItem.rightBarButtonItems = [selectButton, plusButton, modeButton]
    }
    
    private func createFinder() {
        let alertController = UIAlertController(title: "Add new finder",
                                                message: "Don't forget the name",
                                                preferredStyle: .alert)
        
        let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            guard let finderName = alertController.textFields?.first?.text else { return }
            
            self?.createDirectory(name: finderName)
            self?.updateFileSystemElements()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Finder name"
        }
        
        alertController.addAction(createAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    private func createDirectory(name: String) {
        guard let folderParentDirectory = url ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let newDirectoryPath = folderParentDirectory.appendingPathComponent(name)
        
        try? FileManager.default.createDirectory(at: newDirectoryPath, withIntermediateDirectories: false, attributes: nil)
    }
    
    private func updateFileSystemElements() {
        guard let currentDirectory = url ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
     
        fileSystemElements.removeAll()
        
        try? FileManager.default.contentsOfDirectory(at: currentDirectory,
                                                     includingPropertiesForKeys: nil,
                                                     options: [])
            .forEach {
                
                let elementType: FileSystemElementType =
                    $0.lastPathComponent.contains(".jpeg") || $0.lastPathComponent.contains(".png") ? .image : .directory
                
                let fileSystemElement = FileSystemElement(type: elementType, url: $0)
                
                fileSystemElements.append(fileSystemElement)
            }
        
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    private func handleItemSelect(indexPath: IndexPath) {
        let element = fileSystemElements[indexPath.row]
        
        guard !isEditMode
        else { handleItemSelect(element: element)
            return }
        
        switch element.type {
        case .directory:
            navigateToFolder(url: element.url)
        case .image:
            openImage(url: element.url)
        }
    }
    
    private func handleItemSelect(element: FileSystemElement) {
        if let index = selectedElements.firstIndex(of: element) {
            selectedElements.remove(at: index)
        } else {
            selectedElements.append(element)
        }
        
        //tableView.reloadData()
        //collectionView.reloadData()
    }
    
    private func navigateToFolder(url: URL) {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        viewController.url = url
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func openImage(url: URL) {
        guard let imageView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ImageVC") as? ImageViewController else { return }
        
        imageView.imagePath = url
        
        navigationController?.pushViewController(imageView, animated: true)
    }
    
    private func createImage() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        
        imagePickerController.delegate = self
        
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func openCamera() {
        let cameraPickerController = UIImagePickerController()
        cameraPickerController.sourceType = .camera
        cameraPickerController.delegate = self
        
        present(cameraPickerController, animated: true, completion: nil)
    }
    
    private func saveImage(image: UIImage, name: String) {
        guard let parentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return}
        
        let newPathImage = parentDirectory.appendingPathComponent(name)
        
        try? image.jpegData(compressionQuality: 1.0)?.write(to: newPathImage)
        
        updateFileSystemElements()
    }
    
    private func upDateViewMode() {
        switch UserDefaultsManager.shared.presentationMode {
        case .tableView:
            tableView.isHidden = false
            collectionView.isHidden = true
        case .collectionView:
            tableView.isHidden = true
            collectionView.isHidden = false
        }
    }
    
    // MARK: - Actions
    @objc private func tapToPlus() {
        let alertController = UIAlertController(title: "Choose Action",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        let createFinderAction = UIAlertAction(title: "Create Finder", style: .default) { [weak self] _ in
            self?.createFinder()
        }
        
        let createImageAction = UIAlertAction(title: "Create Image", style: .default) { [weak self] _ in
            self?.createImage()
        }
        
        let openCameraAction = UIAlertAction(title: "Open camera", style: .default) { [weak self] _ in
            self?.openCamera()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(createFinderAction)
        alertController.addAction(createImageAction)
        alertController.addAction(openCameraAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
    
    @objc private func changeViewMode() {
        let selectedMode = UserDefaultsManager.shared.presentationMode
        let newMode: PresentationMode = selectedMode == .tableView ? .collectionView : .tableView
        
        UserDefaultsManager.shared.presentationMode = newMode
        
        modeButton?.image = UIImage(systemName: newMode.imageName)
        
        upDateViewMode()
    }
    
    @objc private func changeEditMode() {
        isEditMode.toggle()
        editModeButton?.title = isEditMode ? "Cansel" : "Select"
        
        if !isEditMode {
            selectedElements.removeAll()
            
            tableView.reloadData()
            collectionView.reloadData()
        }
    }
}

// MARK: - ViewController: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let element = fileSystemElements[indexPath.row]
        
        switch element.type {
        case .directory:
            return 50
        case.image:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleItemSelect(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedFileSystemElements = fileSystemElements.remove(at: sourceIndexPath.row)
        fileSystemElements.insert(movedFileSystemElements, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fileSystemElements.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - ViewController: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fileSystemElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = fileSystemElements[indexPath.row]
        let cell: UITableViewCell
        
        switch element.type {
        
        case .directory:
            guard let directoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: DirectoryTableViewCell.id,
                                                                             for: indexPath) as? DirectoryTableViewCell
            else { return UITableViewCell() }
            directoryTableViewCell.finderName = element.url.lastPathComponent
            
            cell = directoryTableViewCell
            
        case .image:
            guard let imageTableViewCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.id,
                                                                         for: indexPath) as? ImageTableViewCell
            else { return UITableViewCell() }
            imageTableViewCell.imagePath = element.url
            
            cell = imageTableViewCell
        }
        
        cell.setSelected(tableView.indexPathsForSelectedRows?.contains(indexPath) == true, animated: true)
        
        return cell
    }
}

// MARK: - ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage,
              let imageURL = info[.imageURL] as? URL
        else { return }
        
        saveImage(image: image, name: imageURL.lastPathComponent)

        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - ViewController: UICollectionViewDelegate
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20,
                            left: 0,
                            bottom: 0,
                            right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleItemSelect(indexPath: indexPath)
    }
}

// MARK: - ViewController: UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fileSystemElements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let element = fileSystemElements[indexPath.row]
        
        let cell: UICollectionViewCell
        switch element.type {
        
        case .directory:
            guard let directoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DirectoryCollectionViewCell.id, for: indexPath) as? DirectoryCollectionViewCell else { return UICollectionViewCell() }
            
            directoryCollectionViewCell.directoryName = element.url.lastPathComponent
            
            cell = directoryCollectionViewCell
        
        case .image:
            guard let imageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.id, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
            
            imageCollectionViewCell.imagePath = element.url
            
            cell = imageCollectionViewCell
        }
        cell.isSelected = selectedElements.contains(where: {$0 == element })
        
        return cell
    }
}
