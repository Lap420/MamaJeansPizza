import Firebase
import FirebaseStorage

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
                let docsDispatchGroup = DispatchGroup()
            
                for doc in docs {
                    docsDispatchGroup.enter()
                    guard let docName = doc.get("name") as? String else { continue }
                    let docDescription = doc.get("description") as? String ?? ""
                    
                    self.getImage(path: collection, picName: docName) { imageData in
                        let data = HomePageData(name: docName,
                                                description: docDescription,
                                                imageData: imageData)
                        homepageDataArray.append(data)
                        docsDispatchGroup.leave()
                    }
                }
            
                docsDispatchGroup.notify(queue: .global(qos: .userInitiated)) {
                    completion(homepageDataArray)
                }
            }
        }
    }
    
    func getImage(path: String, picName: String, completionImage: @escaping (Data?) -> Void) {
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child(path)
        let fileRef = pathRef.child(picName + ".png")
        
        fileRef.getData(maxSize: 1024*1024) { imageData, error in
            DispatchQueue.global(qos: .userInitiated).async {
                completionImage(imageData)
            }
        }
    }
}
