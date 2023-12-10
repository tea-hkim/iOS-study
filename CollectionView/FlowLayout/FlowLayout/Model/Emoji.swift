//
//  Emoji.swift
//  FlowLayout
//
//  Created by 김태호 on 12/8/23.
//

import Foundation

final class Emoji {
    
    static let shared = Emoji()
    private init() {} 
    
    enum Section: String, CaseIterable {
      case smileysAndPeople = "Smileys & People"
      case animalsAndNature = "Animals & Nature"
      case foodAndDrink = "Food & Drink"
      case activity = "Activity"
      case travelAndPlaces = "Travel & Places"
      case objects = "Objects"
      case symbols = "Symbols"
      case flags = "Flags"
    }
    
    var sections = Section.allCases
    
    var items: [Section: [String]] = [
      .smileysAndPeople: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "☺️", "😊", "🤯", "😇", "🙂", "😎", "🤩", "😴", "😬", "🥵"],
      .animalsAndNature: ["🐶", "🐱", "🦊", "🐻", "🦁", "🐮", "🐸", "🐵", "🐔", "🐧", "🦉", "🐴", "🦋", "🐙", "🐬", "🐈", "🌲", "🌍"],
      .foodAndDrink:     ["🍏", "🍇", "🍓", "🥝", "🍅", "🌽", "🥕", "🥨", "🧀", "🍖", "🦴", "🌮", "🍣", "🥤", "🥃", "🥟", "🍺", "🍪"],
      .activity:         ["⚽️", "🏉", "🥏", "🏏", "🥅", "🛹", "🛷", "🏋️‍♂️", "🏅", "🎪", "🎬", "🎼", "🎲", "🎳", "🎮", "🎸", "🧩", "🏆"],
      .travelAndPlaces:  ["🚗", "🚑", "🚨", "🚠", "🚟", "🚄", "✈️", "🚤", "🚧", "🏠", "⛱", "🌋", "⛩", "🕋", "⛪️", "🌠", "🌇", "🗽"],
      .objects:          ["⌚️", "🖱", "🖲", "💾", "☎️", "📺", "💴", "🔨", "🧰", "🧲", "🎁", "🎊", "✉️", "🗳", "📌", "🔍", "🔐", "💰"],
      .symbols:          ["❤️", "💔", "☮️", "☯️", "☢️", "🆚", "🉐", "🆘", "❌", "💯", "‼️", "🚸", "⚜️", "♿️", "🔈", "🔔", "♣️", "🚸"],
      .flags:            ["🏳️", "🇺🇸", "🇯🇵", "🇩🇪", "🇨🇦", "🇲🇽", "🇧🇷", "🇰🇪", "🇳🇬", "🇮🇳", "🇷🇺", "🇦🇺", "🇫🇷", "🇵🇱", "🇻🇳", "🇱🇹", "🇱🇰", "🇪🇪"]
    ]
        
}

extension Emoji {
    
    // TODO: - How can i test this method?
    public func addRandomEmoji(at section: Section) {
        let extraEmojiList = ["💀", "🤖", "👍", "🤘🏾", "🖐🏼", "👇🏽", "🙏🏾", "👀", "👩🏽‍🦱", "👩🏿", "🧕🏽", "🕵🏻‍♂️", "👨🏼‍💻", "👭", "🧚🏾‍♂️", "💍"]
        let randomIndex = Int.random(in: 0..<extraEmojiList.count)
        let randomEmoji = extraEmojiList[randomIndex]
        
        guard var newItems = items[section] else { return }
        newItems.append(randomEmoji)
        
        items.updateValue(newItems, forKey: section)
    }
    
}
