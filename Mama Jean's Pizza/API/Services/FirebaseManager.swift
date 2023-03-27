//
//  FirebaseManager.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 17.02.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import CoreMedia

class FirebaseManager {
    static let shared = FirebaseManager()
    
    private func configureDB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        return db
    }
    
    func getHomepageData(collection: String, completion: @escaping ([HomePageData]) -> Void) {
        let db = configureDB()

        db.collection(collection).getDocuments { homepageData, error in
            DispatchQueue.global(qos: .userInitiated).async {
                guard error == nil else { completion([]); return }
                guard let docs = homepageData?.documents else { completion([]); return }
 
                var homepageDataArray: [HomePageData] = []
                let docsGroup = DispatchGroup()
            
                for doc in docs {
                    docsGroup.enter()
                    guard let docName = doc.get("name") as? String else { continue }
                
                    self.getImage(path: collection, picName: docName) { image in
                        let data = HomePageData(name: docName,
                                                description: doc.get("description") as? String ?? "",
                                                imageData: image)
                        homepageDataArray.append(data)
                        docsGroup.leave()
                    }
                }
            
                docsGroup.notify(queue: .global(qos: .userInitiated)) {
                    completion(homepageDataArray)
                }
            }
        }
    }
    
    func getImage(path: String, picName: String, completionImage: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child(path)
        let fileRef = pathRef.child(picName + ".png")
        var image = UIImage(named: "No_Image")
        
        fileRef.getData(maxSize: 1024*1024) { data, error in
            DispatchQueue.global(qos: .userInitiated).async {
                guard error == nil else { completionImage(image!); return }
                image = UIImage(data: data!)!
                completionImage(image!)
            }
        }
    }
}
