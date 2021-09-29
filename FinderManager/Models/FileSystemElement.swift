//
//  FileSystemElement.swift
//  FinderManager
//
//  Created by Никита Коголенок on 14.09.21.
//

import Foundation

enum FileSystemElementType {
    case directory
    case image
}

struct FileSystemElement: Equatable {
    let type: FileSystemElementType
    let url: URL
}
