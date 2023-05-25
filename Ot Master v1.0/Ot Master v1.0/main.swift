//
//  main.swift
//  Ot Master v1.0
//
//  Created by Onur Sir on 25.05.2023.
//

import Foundation

struct Ot {
    let ad: String
    let kod: Int
    let tazelikKaybi: Double
    
    init(ad: String, kod: Int, tazelikKaybi: Double) {
        self.ad = ad
        self.kod = kod
        self.tazelikKaybi = tazelikKaybi
    }
}

let otListesi = [
    Ot(ad: "Kekik", kod: 1, tazelikKaybi: -0.1),
    Ot(ad: "Nane", kod: 2, tazelikKaybi: -0.2),
    Ot(ad: "Fesleğen", kod: 3, tazelikKaybi: -0.1),
    Ot(ad: "Reyhan", kod: 4, tazelikKaybi: -0.25)
]

func otBirimFiyat(ad: String, fiyatlar: [String: Double]) -> Double? {
    return fiyatlar[ad]
}

func tazelikEtkisi(taze: Bool, miktar: Double, birimFiyat: Double, tazelikKaybi: Double) -> Double {
    var fiyat = miktar * birimFiyat
    if !taze {
        fiyat += fiyat * tazelikKaybi
    }
    return fiyat
}

func hesapla() {
    print("** Ot Master v1.0 ***")
    
    var fiyatlar: [String: Double] = [:]
    
    for ot in otListesi {
        print("\(ot.ad) fiyatını giriniz:")
        if let fiyat = Double(readLine() ?? "") {
            fiyatlar[ot.ad] = fiyat
        }
    }
    
    print("Tür: ", terminator: "")
    if let tur = readLine(), let kod = Int(tur), let secilenOt = otListesi.first(where: { $0.kod == kod }) {
        print("\(secilenOt.ad) miktar (kg): ", terminator: "")
        if let miktar = Double(readLine() ?? "") {
            print("Taze mi? (1 = taze): ", terminator: "")
            if let taze = Int(readLine() ?? ""), let tazeBool = (taze == 1 ? true : false) as Bool? {
                if let birimFiyat = otBirimFiyat(ad: secilenOt.ad, fiyatlar: fiyatlar) {
                    let islemTutari = miktar * birimFiyat
                    let tazelikEtki = tazelikEtkisi(taze: tazeBool, miktar: miktar, birimFiyat: birimFiyat, tazelikKaybi: secilenOt.tazelikKaybi)
                    let tutar = islemTutari + tazelikEtki
                    let kdv = tutar * 0.18
                    let genelToplam = tutar + kdv
                    
                    print("İşlem tutarı: \(islemTutari) TL")
                    print("Tazelik etkisi: \(tazelikEtki) TL")
                    print("Tutar: \(tutar) TL")
                    print("KDV (%18): \(kdv) TL")
                    print("Fatura:")
                    print("OT A.Ş.")
                    print("* \(secilenOt.ad): \(miktar)kg x \(birimFiyat)TL = \(islemTutari)")
                    print(tazeBool ? "Taze" : "Taze değil.")
                    print("KDV (%18): \(kdv) TL")
                    print("Genel Toplam: \(genelToplam) TL")
                } else {
                    print("Geçersiz ot adı!")
                }
            } else {
                print("Geçersiz taze değeri!")
            }
        } else {
            print("Geçersiz miktar!")
        }
    } else {
        print("Geçersiz ot türü!")
    }
}

hesapla()

