//
//  HistoryManager.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import CoreData

struct HistoryManager: HistoryServiceProviding {
    
    let persistenceManager: PersistenceManager
    
    func fetch() -> [ChatRoomHistory] {
        let request: NSFetchRequest<HistoryInfo> = HistoryInfo.fetchRequest()
        let result = persistenceManager.fetch(request: request)
        
        return result.map {
            ChatRoomHistory(roomID: Int($0.roomID),
                            code: $0.code ?? "",
                            title: $0.title ?? "",
                            usedNickname: $0.usedNickname ?? "",
                            usedLanguage: Language.codeToLanguage(of: $0.usedLanguage ?? "ko"),
                            usedImage: $0.usedImage ?? "",
                            enterDate: $0.enterDate ?? Date())
        }
    }
    
    func insert(of history: ChatRoomHistory) {
        let nsEntity = NSEntityDescription.entity(forEntityName: "HistoryInfo", in: persistenceManager.context)
        
        guard let entity = nsEntity else {
            return
        }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: persistenceManager.context)
        managedObject.setValue(history.roomID, forKey: "roomID")
        managedObject.setValue(history.code, forKey: "code")
        managedObject.setValue(history.title, forKey: "title")
        managedObject.setValue(history.usedNickname, forKey: "usedNickname")
        managedObject.setValue(history.usedLanguage.code, forKey: "usedLanguage")
        managedObject.setValue(history.usedImage, forKey: "usedImage")
        managedObject.setValue(history.enterDate, forKey: "enterDate")
        
        do {
            try persistenceManager.context.save()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
