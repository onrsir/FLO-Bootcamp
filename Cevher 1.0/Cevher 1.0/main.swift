print("** Cevher v1.0 **")
print("* Müşteri'nin")
print("Adı : ", terminator: "")
let musteriAdi = readLine() ?? ""
print("Soyadı : ", terminator: "")
let musteriSoyadi = readLine() ?? ""

print("* Cevherin")
print("Kodu : ", terminator: "")
let cevherKodu: String

print("Cevher türü:")
print("1. Demir")
print("2. Krom")
print("3. Bakır")
print("4. Kömür")

var cevherSecim = 0

while cevherSecim < 1 || cevherSecim > 4 {
    print("Seçiminizi yapın (1-4): ", terminator: "")
    if let kullaniciSecimi = readLine(),
       let secim = Int(kullaniciSecimi),
       (1...4).contains(secim) {
        cevherSecim = secim
    }
}

switch cevherSecim {
case 1:
    cevherKodu = "DMR"
    print("Seçtiğiniz cevher: Demir")
case 2:
    cevherKodu = "KRM"
    print("Seçtiğiniz cevher: Krom")
case 3:
    cevherKodu = "BKR"
    print("Seçtiğiniz cevher: Bakır")
case 4:
    cevherKodu = "KMR"
    print("Seçtiğiniz cevher: Kömür")
default:
    fatalError("Geçersiz cevher seçimi")
}
func cevherFiyat(kod: String) -> Int {
    switch kod {
    case "DMR":
        return 1500
    case "KRM":
        return 5000
    case "BKR":
        return 3000
    case "KMR":
        return 500
    default:
        return 0
    }
}

func taneEtkisi(kod: Int) -> Int {
    switch kod {
    case 1:
        return -15
    case 2:
        return -10
    case 3:
        return 0
    default:
        return 0
    }
}

func temizlikEtkisi(temizlik: Int, birimFiyat: Int) -> Int {
    let etkisi = temizlik * birimFiyat / 100
    return birimFiyat - etkisi
}



let birimFiyat = cevherFiyat(kod: cevherKodu)
print("Normal Birim Fiyat: \(birimFiyat) TON / TL")

print("Tane : ", terminator: "")
let taneBuyuklugu = Int(readLine() ?? "") ?? 0
print("Temizlik oranı : ", terminator: "")
let temizlikOrani = Int(readLine() ?? "") ?? 0
print("Miktar (ton) : ", terminator: "")
let miktar = Int(readLine() ?? "") ?? 0

print("******** Fatura ******")
print("Alıcı : \(musteriAdi) \(musteriSoyadi)")

print("Cevher türü : ", terminator: "")
switch cevherKodu {
case "DMR":
    print("Demir")
case "KRM":
    print("Krom")
case "BKR":
    print("Bakır")
case "KMR":
    print("Kömür")
default:
    fatalError("Geçersiz cevher kodu")
}

let taneEtki = taneEtkisi(kod: taneBuyuklugu)
let taneFiyat = birimFiyat + (birimFiyat * taneEtki / 100)
print("\(cevherKodu) Fiyat : \(taneFiyat) TON / TL")

print("Temizlik : \(temizlikOrani)%")
let temizlikEtki = temizlikEtkisi(temizlik: temizlikOrani, birimFiyat: taneFiyat)
print("Temizlik Etkisi Sonrası Birim Fiyat : \(temizlikEtki) TON / TL")

let toplam = temizlikEtki * miktar
print("Toplam : \(toplam) TL")
let kdv = Double(toplam) * 0.08
print("KDV (8) : \(kdv) TL")
let genelToplam = toplam + Int(kdv)
print("Genel Toplam : \(genelToplam) TL")
print("SIR Madencilik, 2023")
