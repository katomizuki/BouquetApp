//
//  Flowers.swift
//  BouquetApp
//
//  Created by ミズキ on 2022/09/22.
//

struct Flowers {
    let list = [
        Flower(name: "satsuki", description: "アイウエオ", id: 0),
        Flower(name: "umanoashigata", description: "アイウエオ", id: 1),
        Flower(name: "tsukushibara", description: "アイウエオ", id: 2),
        Flower(name: "hamaboh", description: "アイウエオ", id: 3),
        Flower(name: "hanamasu", description: "アイウエオ", id: 4),
        Flower(name: "higanbana", description: "アイウエオ", id: 5),
        Flower(name: "ezokisuge", description: "アイウエオ", id: 6),
        Flower(name: "kusaichigo", description: "アイウエオ", id: 7),
        Flower(name: "oniyuri", description: "アイウエオ", id: 8),
        Flower(name: "isotutudi", description: "アイウエオ", id: 9),
        Flower(name: "ezoshikashiyuri", description: "アイウエオ", id: 10),
        Flower(name: "yabukanzo", description: "アイウエオ", id: 11),
        Flower(name: "yamatutudi", description: "アイウエオ", id: 12)
    ]
}

extension Flowers:  Collection {
    typealias Element = Flower
    typealias Index = Int

    var startIndex: Int { return 0 }
    var endIndex: Int { return list.count }

    subscript(position: Int) -> Flower {
        return list[position]
    }
    
    func index(after i: Int) -> Int {
        return i + 1
    }
  
}
