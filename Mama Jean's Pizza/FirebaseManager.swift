//
//  FirebaseManager.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 17.02.2023.
//

import Foundation
import UIKit
import Firebase
//import FirebaseDatabase
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
    
    func getDeals(collection: String, completion: @escaping ([Deal]) -> Void) {
        let db = configureDB()
        db.collection(collection).getDocuments { deals, error in
            guard error == nil else { completion([]); return }
            guard let docs = deals?.documents else { completion([]); return }
            
            var dealsArray: [Deal] = []
            for doc in docs {
                guard let docName = doc.get("name") as? String else { continue }
                
                self.getDealImage(path: collection, picName: docName) { image in
                    let deal = Deal(name: docName,
                                    dealDescription: doc.get("description") as? String ?? "",
                                    image: image)
                    dealsArray.append(deal)
                    
                    completion(dealsArray)
                }
            }
            
        }
    }
    
    func getDealImage(path: String, picName: String, completion: @escaping (UIImage) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child(path)
        
        var image = UIImage(named: "No_Image")
        
        let fileRef = pathRef.child(picName + ".png")
        fileRef.getData(maxSize: 1024*1024) { data, error in
            guard error == nil else { completion(image!); return }
            image = UIImage(data: data!)!
            completion(image!)
        }
    }
    
//    func getOneExactDeal(collection: String, docName: String, completion: @escaping (Deal?) -> Void) {
//        let db = configureDB()
//        db.collection(collection).document(docName).getDocument { deal, error in
//            guard error == nil else { completion(nil); return }
//            self.getDealImage(path: collection, picName: docName) { image in
//                let finalDeal = Deal(name: deal?.get("name") as! String,
//                                     dealDescription: deal?.get("description") as! String,
//                                     image: image)
//                completion(finalDeal)
//            }
//        }
//    }
}
