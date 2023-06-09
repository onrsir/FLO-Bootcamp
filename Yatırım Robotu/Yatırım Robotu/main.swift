import Foundation

// Komut Satırı Arayüz Fonksiyonları

func printString(_ string: String) {
    print(string)
}

func printInteger(_ integer: Int) {
    print(integer)
}

func printFloat(_ floatNum: Float) {
    print(floatNum)
}

func readInteger(prompt: String) -> Int {
    print(prompt, terminator: "")
    let input = readLine()
    guard let value = Int(input ?? "") else {
        return 0
    }
    return value
}

func readFloat(prompt: String) -> Float {
    print(prompt, terminator: "")
    let input = readLine()
    guard let value = Float(input ?? "") else {
        return 0.0
    }
    return value
}

func readString(prompt: String) -> String {
    print(prompt, terminator: "")
    let input = readLine()
    return input ?? ""
}

func messageBox(_ message: String, messageType: String) {
    let stars = String(repeating: "*", count: message.count + 4)
    print(stars)
    print("* \(message) *")
    print(stars)
}

func greetings() {
    print("\nHoşgeldiniz...")
    print("Yatırım Ustası v1.0 by FLO Bootcamp ")
}

func byebye() {
    print("\nİyi günler...")
    print("Yatırım Ustası v1.0 by FLO Bootcamp")
}

func randomNumber(_ upperBound: Int) -> Int {
    let randomNum = Int.random(in: 1...upperBound)
    return randomNum
}

func gelirMi(_ value: Int) -> Bool {
    let randomNum = Int.random(in: 1...100)
    return randomNum < value
}

// Yatırım Robotu

struct YatirimRobotu {
    var ad: String
    var soyad: String
    var riskIstahi: Int
    var yas: Int
    var aylikGelirYatirimOrani: Double
    
    let yatirimYuzdeleri: [[Int]] = [
        [0, 0, 0, 0, 100, 0],
        [30, 30, 20, 0, 20, 0],
        [50, 0, 10, 30, 0, 10],
        [30, 0, 0, 10, 0, 60],
        [10, 0, 0, 20, 0, 70]
    ]
    
    let tabloKurlar: [String: Double] = [
        "Dolar": 8.3,
        "Avro": 10.1,
        "Altın": 510.0,
        "Gümüş": 7.5,
        "Faiz": 0.0,
        "Bitcoin": 1000.0
    ]
    
    let tabloArtmaIhtimalleri: [String: Int] = [
        "Dolar": 50,
        "Avro": 60,
        "Altın": 40,
        "Gümüş": 30,
        "Faiz": 100,
        "Bitcoin": 20
    ]
    
    let tabloDegisimYuzdesi: [String: Int] = [
        "Dolar": 20,
        "Avro": 10,
        "Altın": 15,
        "Gümüş": 20,
        "Faiz": 15,
        "Bitcoin": 25
    ]
    
    init(ad: String, soyad: String, riskIstahi: Int, yas: Int, aylikGelirYatirimOrani: Double) {
        self.ad = ad
        self.soyad = soyad
        self.riskIstahi = riskIstahi
        self.yas = yas
        self.aylikGelirYatirimOrani = aylikGelirYatirimOrani
    }
    
    func yatirimYuzdeleriniGetir() -> [Int] {
        guard riskIstahi >= 1 && riskIstahi <= 5 else {
            return []
        }
        
        let index = riskIstahi - 1
        return yatirimYuzdeleri[index]
    }
    
    mutating func riskGrubunuGuncelle() {
        if aylikGelirYatirimOrani > 5 {
            if riskIstahi > 1 {
                riskIstahi -= 1
            }
        } else if aylikGelirYatirimOrani >= 1 && aylikGelirYatirimOrani <= 5 {
            if yas > 60 {
                if riskIstahi > 1 {
                    riskIstahi -= 1
                }
            } else if yas < 40 {
                if riskIstahi != 3 {
                    riskIstahi = 3
                }
            } else if yas > 50 {
                if riskIstahi > 1 {
                    riskIstahi -= 1
                }
            } else if yas < 30 {
                if riskIstahi != 3 {
                    riskIstahi = 3
                }
            } else if yas > 30 {
                if riskIstahi > 1 {
                    riskIstahi -= 1
                }
            }
        } else if aylikGelirYatirimOrani < 0.1 {
            if riskIstahi == 4 {
                riskIstahi = 2
            } else if riskIstahi == 3 {
                riskIstahi = 1
            }
        }
    }
    
    func yatirimYap(parasalDeger: Double) {
        let yatirimYuzdeleri = yatirimYuzdeleriniGetir()
        
        guard yatirimYuzdeleri.count == 6 else {
            print("Hatalı risk iştahı değeri!")
            return
        }
        
        var toplamGelirYuzdesi = 0.0
        var toplamGelirDegeri = 0.0
        
        for (index, yuzde) in yatirimYuzdeleri.enumerated() {
            let kur = Array(tabloKurlar.keys)[index]
            let artmaIhtimali = tabloArtmaIhtimalleri[kur] ?? 0
            let degisimYuzdesi = tabloDegisimYuzdesi[kur] ?? 0
            
            var miktar = parasalDeger * Double(yuzde) / 100
            var gelirYuzdesi = 0.0
            var gelirDegeri = 0.0
            
            if kur == "Bitcoin" {
                let bitcoinMiktari = miktar
                miktar = 0.0
                
                if bitcoinMiktari > 0 {
                    let bitcoinArttiMi = gelirMi(artmaIhtimali)
                    if bitcoinArttiMi {
                        let degisimMiktari = bitcoinMiktari * Double(degisimYuzdesi) / 100
                        miktar = bitcoinMiktari + degisimMiktari
                        gelirYuzdesi = (degisimMiktari / bitcoinMiktari) * 100
                        gelirDegeri = degisimMiktari
                    }
                }
            } else {
                let kurDegeri = tabloKurlar[kur] ?? 0.0
                let arttiMi = gelirMi(artmaIhtimali)
                if arttiMi {
                    let degisimMiktari = miktar * (Double(degisimYuzdesi) / 100)
                    miktar += degisimMiktari
                    gelirYuzdesi = (degisimMiktari / miktar) * 100
                    gelirDegeri = degisimMiktari
                }
                
                miktar /= kurDegeri
            }
            
            print("-------------------------")
            print("Kur: \(kur)")
            print("Orijinal Kur: \(tabloKurlar[kur] ?? 0.0)")
            print("Hesaplamaya Giren Değer: \(parasalDeger)")
            print("Değişim Oranı: \(degisimYuzdesi)%")
            print("Yatırılan Miktar: \(miktar)")
            print("Elde Edilen Gelir veya Kayıp: \(gelirDegeri)")
            print("Elde Edilen Gelir veya Kayıp Yüzdesi: \(gelirYuzdesi)%")
            
            toplamGelirYuzdesi += gelirYuzdesi
            toplamGelirDegeri += gelirDegeri
        }
        
        print("-------------------------")
        print("Toplam Gelir veya Kayıp Yüzdesi: \(toplamGelirYuzdesi)%")
        print("Toplam Gelir veya Kayıp Değeri: \(toplamGelirDegeri)")
        print("-------------------------")
        
        let toplamSonDeger = parasalDeger + toplamGelirDegeri
        print("Toplam Son Değer: \(toplamSonDeger)")
    }


}

func main() {
    greetings()
    
    let ad = readString(prompt: "Adınız: ")
    let soyad = readString(prompt: "Soyadınız: ")
    let riskIstahi = readInteger(prompt: "Risk İştahınız (1-5 arasında): ")
    let yas = readInteger(prompt: "Yaşınız: ")
    let aylikGelirYatirimOrani = readFloat(prompt: "Aylık Gelirinizi Yatırım Miktarına Oranlayın (Örneğin, 0.5): ")
    
    var robot = YatirimRobotu(ad: ad, soyad: soyad, riskIstahi: riskIstahi, yas: yas, aylikGelirYatirimOrani: Double(aylikGelirYatirimOrani))
    robot.riskGrubunuGuncelle()
    
    let parasalDeger = 10000.0 
    robot.yatirimYap(parasalDeger: parasalDeger)
    print("Sayın \(robot.ad) \(robot.soyad) bizi tercih ettiğiniz için teşekkürler.")


    byebye()
}

main()
