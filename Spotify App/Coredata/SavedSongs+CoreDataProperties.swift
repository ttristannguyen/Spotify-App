//
//  SavedSongs+CoreDataProperties.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 9/6/2022.
//
//

import Foundation
import CoreData


extension SavedSongs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedSongs> {
        return NSFetchRequest<SavedSongs>(entityName: "SavedSongs")
    }

    @NSManaged public var songName: String?
    @NSManaged public var artistName: String?
    @NSManaged public var imageString: String?
    @NSManaged public var previewString: String?
    
    
}

extension SavedSongs : Identifiable {

}
