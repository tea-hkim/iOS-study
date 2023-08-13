import UIKit

class Music {
  let notes: [String]

  init(notes: [String]) {
    self.notes = notes
  }

  func prepared() -> String {
    return notes.joined(separator: " ")
  }
}



class Instrument {
    let brand: String
    
    init(brand: String) {
        self.brand = brand
    }
    
    /// 이 클래스는 추상 클래스이기 때문에 직접적으로 사용되어서는 안된다
    /// 따라서 fatal Error를 통해 재정의를 해야한다는 것을 알려준다
    func tune() -> String {
        fatalError("Implement this method for \(brand)")
    }
    
    func play(_ music: Music) -> String {
      return music.prepared()
    }
    
    func perform(_ music: Music) {
      print(tune())
      print(play(music))
    }

}
