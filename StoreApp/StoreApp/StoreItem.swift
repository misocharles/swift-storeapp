//
//  StoreItem.swift
//  StoreApp
//
//  Created by 백인철 on 2018. 7. 8..
//  Copyright © 2018년 Incheol. All rights reserved.
//

import Foundation

struct Store {
    var storeInfoArray: [StoreInfo]
    var count: Int {
        return self.storeInfoArray.count
    }
    
    subscript(index: Int) -> StoreInfo {
        return self.storeInfoArray[index]
    }

    init() {
        storeInfoArray = [StoreInfo]()
        storeInfoArray.append(StoreInfo(id: "main", title: "메인반찬", description: "한그릇 뚝딱 메인 요리"))
        storeInfoArray.append(StoreInfo(id: "soup", title: "국.찌게", description: "김이 모락모락 국.찌게"))
        storeInfoArray.append(StoreInfo(id: "side", title: "밑반찬", description: "언제 먹어도 든든한 밑반찬"))
    }
}

struct StoreInfo {
    var id: String?
    var title: String?
    var description: String?
    private var items: [StoreItem]
    
    init(id: String, title: String, description: String) {
        self.id = id
        self.title = title
        self.description = description
        guard let mainJsonFilePath = Bundle.main.path(forResource: id, ofType: "json") else {
            items = []
            return
        }
        do {
            let data = try Data.init(contentsOf: URL.init(fileURLWithPath: mainJsonFilePath))
            let json = try JSONDecoder().decode([StoreItem].self, from: data)
            self.items = json
        } catch {
            // error
            items = []
        }
    }
    
    subscript(index: Int) -> StoreItem {
        return self.items[index]
    }
    
    var count: Int {
        return self.items.count
    }
}

struct StoreItem: Decodable {
    var title: String?
    var description: String?
    var n_price: String?
    var s_price: String?
    var badge: [String]?
    var image: String?
    
    var badge1: String? {
        return badge?.first
    }
    var badge2: String? {
        guard let count = badge?.count else {
            return nil
        }
        if count > 1 {
            return badge?[1]
        }
        return nil
    }
}
