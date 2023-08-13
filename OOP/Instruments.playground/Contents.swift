import UIKit

/// 출처 : https://www.kodeco.com/599-object-oriented-programming-in-swift#toc-anchor-005
/// Object Oriented Programming in Swift
///

// MARK: - Class

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

class Piano: Instrument {
    let hasPedals: Bool
    static let whiteKeys = 52
    static let blackKeys = 36
    
    init(brand: String, hasPedals: Bool = false) {
        self.hasPedals = hasPedals
        super.init(brand: brand)
    }
    
    override func tune() -> String {
        return "Piano standard tuning for \(brand)."
    }
    
    override func play(_ music: Music) -> String {
        return play(music, usingPedals: hasPedals)
    }
    
    
    func play(_ music: Music, usingPedals: Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals {
            return "Play piano notes \(preparedNotes) with pedals."
        } else {
            return "Play piano notes \(preparedNotes) without pedals."
        }
    }
    
}

class Guitar: Instrument {
    let stringGauge: String
    
    init(brand: String, stringGauge: String = "medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
}

class AcousticGuitar: Guitar {
    static let numberOfStrings = 6
    static let fretCount = 20
    
    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune on frets \(preparedNotes)."
    }
}

class Amplifier {
    private var _volume: Int
    private(set) var isOn: Bool
    
    init() {
        isOn = false
        _volume = 0
    }
    
    func plugIn() {
        isOn = true
    }
    
    func unplug() {
        isOn = false
    }
    
    var volume: Int {
        get {
            return isOn ? _volume : 0
        } set {
            _volume = min(max(newValue, 0), 10)
        }
    }
}


class ElectricGuitar: Guitar {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "light", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D G B E"
    }
    
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)."
    }
}

class BassGuitar: Guitar {
  let amplifier: Amplifier

  init(brand: String, stringGauge: String = "heavy", amplifier: Amplifier) {
    self.amplifier = amplifier
    super.init(brand: brand, stringGauge: stringGauge)
  }

  override func tune() -> String {
    amplifier.plugIn()
    return "Tune \(brand) bass with E A D G"
  }

  override func play(_ music: Music) -> String {
    let preparedNotes = super.play(music)
    return "Play bass line \(preparedNotes) at volume \(amplifier.volume)."
  }
}

class Band {
  let instruments: [Instrument]
  
  init(instruments: [Instrument]) {
    self.instruments = instruments
  }
  
  func perform(_ music: Music) {
      instruments.forEach { $0.perform(music) }
  }
}


// MARK: - Instance

let piano = Piano(brand: "Yamaha", hasPedals: true)
piano.tune()

let acousticGuitar = AcousticGuitar(brand: "Rorand", stringGauge: "medium")
acousticGuitar.tune()


let amplifier = Amplifier()
let electricGuitar = ElectricGuitar(brand: "Gibson", stringGauge: "medium", amplifier: amplifier)
electricGuitar.tune()

let bassGuitar = BassGuitar(brand: "Fender", stringGauge: "heavy", amplifier: amplifier)
bassGuitar.tune()

let instruments = [piano, acousticGuitar, electricGuitar, bassGuitar]
let band = Band(instruments: instruments)
let music = Music(notes: ["C", "F", "G"])
band.perform(music)
