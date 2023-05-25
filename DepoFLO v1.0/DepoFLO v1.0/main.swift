//
//  main.swift
//  DepoFLO v1.0
//
//  Created by Onur Sir on 25.05.2023.
//

import Foundation

struct Depo {
    var ayakkabiStok: Int = 0
    var cantaStok: Int = 0
    var gozlukStok: Int = 0
    var sonIslem: String = ""
    var sonIslemTuru: String = ""
    var sonIslemMiktar: Int = 0
}

func malTuruMenu() -> Int {
    print("1- Ayakkabı")
    print("2- Çanta")
    print("3- Gözlük")
    print("4- Vazgeç")
    print("Seçim= ", terminator: "")
    
    if let input = readLine(), let secim = Int(input), secim >= 1 && secim <= 4 {
        return secim
    } else {
        print("Geçersiz seçim. Tekrar deneyin.")
        return malTuruMenu()
    }
}

func ara(depo: Depo) {
    print("Aranacak Ürün İsmini Giriniz: ", terminator: "")
    if let isim = readLine() {
        var urunKodu = ""
        switch isim {
        case "ayakkabı":
            urunKodu = "U01"
        case "çanta":
            urunKodu = "U02"
        case "gözlük":
            urunKodu = "U03"
        default:
            print("Ürün bulunamadı.")
            return
        }
        
        var stok = 0
        switch urunKodu {
        case "U01":
            stok = depo.ayakkabiStok
        case "U02":
            stok = depo.cantaStok
        case "U03":
            stok = depo.gozlukStok
        default:
            break
        }
        
        print("Ürün Kodu: \(urunKodu)")
        print("Stok Durumu: \(stok) adet")
    }
}

func listele(depo: Depo) {
    print("Ayakkabı Stok Durumu: \(depo.ayakkabiStok) adet")
    print("Çanta Stok Durumu: \(depo.cantaStok) adet")
    print("Gözlük Stok Durumu: \(depo.gozlukStok) adet")
}

func sonIslem(depo: Depo) {
    print("Son İşlem: \(depo.sonIslem)")
    print("Son İşlem Türü: \(depo.sonIslemTuru)")
    print("Son İşlem Miktarı: \(depo.sonIslemMiktar)")
}

func main() {
    var depo = Depo()
    
    while true {
        print("---- DepoFLO v1.0 ----")
        print("1- Mal Ekle")
        print("2- Mal Çıkart")
        print("3- Stok Ara")
        print("4- Stok Listele")
        print("5- Son İşlem")
        print("6- Çık")
        print("Seçim: ", terminator: "")
        
        if let input = readLine(), let secim = Int(input) {
            switch secim {
            case 1:
                print("1- Ayakkabı")
                print("2- Çanta")
                print("3- Gözlük")
                print("4- Vazgeç")
                print("Seçim= ", terminator: "")
                if let secilen = readLine(), let malTuru = Int(secilen), malTuru >= 1 && malTuru <= 3 {
                    print("\(secilen) Ekleme")
                    print("-------------------------------")
                    
                    var eklenecekMiktar = 0
                    repeat {
                        print("Miktarı Giriniz (çıkış için 0): ", terminator: "")
                        if let input = readLine(), let miktar = Int(input), miktar >= 0 {
                            if miktar == 0 {
                                break
                            }
                            
                            switch malTuru {
                            case 1:
                                depo.ayakkabiStok += miktar
                                eklenecekMiktar += miktar
                            case 2:
                                depo.cantaStok += miktar
                                eklenecekMiktar += miktar
                            case 3:
                                depo.gozlukStok += miktar
                                eklenecekMiktar += miktar
                            default:
                                break
                            }
                        } else {
                            print("Geçersiz miktar. Tekrar deneyin.")
                        }
                    } while true
                    
                    switch malTuru {
                    case 1:
                        print("Ayakkabı stoğuna toplam \(eklenecekMiktar) adet ayakkabı eklendi.")
                    case 2:
                        print("Çanta stoğuna toplam \(eklenecekMiktar) adet çanta eklendi.")
                    case 3:
                        print("Gözlük stoğuna toplam \(eklenecekMiktar) adet gözlük eklendi.")
                    default:
                        break
                    }
                    
                    depo.sonIslem = "Ekleme"
                    depo.sonIslemMiktar = eklenecekMiktar
                    switch malTuru {
                    case 1:
                        depo.sonIslemTuru = "Ayakkabı"
                    case 2:
                        depo.sonIslemTuru = "Çanta"
                    case 3:
                        depo.sonIslemTuru = "Gözlük"
                    default:
                        break
                    }
                } else {
                    print("Geçersiz seçim. Tekrar deneyin.")
                }
                
            case 2:
                print("1- Ayakkabı")
                print("2- Çanta")
                print("3- Gözlük")
                print("4- Vazgeç")
                print("Seçim= ", terminator: "")
                if let secilen = readLine(), let malTuru = Int(secilen), malTuru >= 1 && malTuru <= 3 {
                    print("\(secilen) Çıkartma, Stok Miktarı= ", terminator: "")
                    var stok = 0
                    switch malTuru {
                    case 1:
                        stok = depo.ayakkabiStok
                    case 2:
                        stok = depo.cantaStok
                    case 3:
                        stok = depo.gozlukStok
                    default:
                        break
                    }
                    print("\(stok) adet")
                    print("-------------------------------")
                    
                    var cikartilacakMiktar = 0
                    repeat {
                        print("Miktarı Giriniz (çıkış için 0): ", terminator: "")
                        if let input = readLine(), let miktar = Int(input), miktar >= 0 {
                            if miktar == 0 {
                                break
                            }
                            
                            if miktar > stok {
                                print("Stokta bu kadar yok, \(stok) adet kaldı...")
                            } else {
                                switch malTuru {
                                case 1:
                                    depo.ayakkabiStok -= miktar
                                    cikartilacakMiktar += miktar
                                case 2:
                                    depo.cantaStok -= miktar
                                    cikartilacakMiktar += miktar
                                case 3:
                                    depo.gozlukStok -= miktar
                                    cikartilacakMiktar += miktar
                                default:
                                    break
                                }
                            }
                        } else {
                            print("Geçersiz miktar. Tekrar deneyin.")
                        }
                    } while true
                    
                    switch malTuru {
                    case 1:
                        print("Ayakkabı stoğundan toplam \(cikartilacakMiktar) adet ayakkabı çıkarıldı.")
                    case 2:
                        print("Çanta stoğundan toplam \(cikartilacakMiktar) adet çanta çıkarıldı.")
                    case 3:
                        print("Gözlük stoğundan toplam \(cikartilacakMiktar) adet gözlük çıkarıldı.")
                    default:
                        break
                    }
                    
                    depo.sonIslem = "Çıkartma"
                    depo.sonIslemMiktar = cikartilacakMiktar
                    switch malTuru {
                    case 1:
                        depo.sonIslemTuru = "Ayakkabı"
                    case 2:
                        depo.sonIslemTuru = "Çanta"
                    case 3:
                        depo.sonIslemTuru = "Gözlük"
                    default:
                        break
                    }
                } else {
                    print("Geçersiz seçim. Tekrar deneyin.")
                }
                
            case 3:
                ara(depo: depo)
                
            case 4:
                listele(depo: depo)
                
            case 5:
                sonIslem(depo: depo)
                
            case 6:
                return
                
            default:
                print("Geçersiz seçim. Tekrar deneyin.")
            }
        } else {
            print("Geçersiz seçim. Tekrar deneyin.")
        }
        
        print("------------------------------------")
    }
}

main()
