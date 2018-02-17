//
//  TesseractController.swift
//  APPdentify
//
//  Created by Michael Castillo on 2/14/18.
//  Copyright © 2018 Michael Castillo. All rights reserved.
//

import Foundation

class TesseractController {
    
    static let shared = TesseractController()
    
            func performTesseractImageRecognition(withTextIn image: UIImage) -> String {
                
                guard let tesseract = G8Tesseract(language: "eng") else { return "bad initialization \(#line)"}
                
                    tesseract.engineMode = .tesseractCubeCombined
                    tesseract.pageSegmentationMode = .auto
                    tesseract.image = image.g8_blackAndWhite()
                    tesseract.recognize()
                    let text = tesseract.recognizedText
                    guard let OCRtext = text else { return "\(#line)" }
                print(OCRtext)
                return OCRtext
                        // TODO: - put activity indicator here 6364393089
            }
    
    enum Language: String {
     
        case    Afrikaans = "afr"
        case    Arabic = "ara"
        case    Azerbaijani = "aze"
        case    Belarusian = "bel"
        case    Bengali = "ben"
        case    Bulgarian = "bul"
        case    CatalanValencian    = "cat"
        case    Czech = "ces"
        case    ChineseSimplified = "chi_sim"
        case    ChineseTraditional = "chi_tra"
        case    Cherokee = "chr"
        case    Danish = "dan"
        case    German = "deu"
        case    GreekModern = "ell"         /// greekModern 1453 - present
        case    English = "eng"
        case    EnglishMiddle = "enm"       /// EnglishMiddle(1100-1500)
        case    Esperanto = "epo"
        case    Estonian = "est"
        case    Basque = "eus"
        case    Finnish = "fin"
        case    French = "fra"
        case    Frankish = "frk"
        case    FrenchMiddle = "frm"        /// FrenchMiddle(1400-1600)vv
        case    Galician = "glg"
        case    GreekAncient = "grc"         /// GreekAncient( until 1453)
        case    Hebrew = "heb"
        case    Hindi = "hin"
        case    Croatian = "hrv"
        case    Hungarian = "hun"
        case    Indonesian = "ind"
        case    Icelandic = "isl"
        case    Italian = "ita"
        case    ItalianOld = "ita_old"
        case    Japanese = "jpn"
        case    Kannada = "kan"
        case    Korean = "kor"
        case    Latvian = "lav"
        case    Lithuanian = "lit"
        case    Malayalam = "mal"
        case    Macedonian = "mkd"
        case    Maltese = "mlt"
        case    Malay = "msa"
        case    DutchFlemish = "nld"
        case    Norwegian = "nor"
        case    Polish = "pol"
        case    Portuguese = "por"
        case    RomanianMoldavianMoldovan = "ron"
        case    Russian = "rus"
        case    Slovak = "slk"
        case    Slovenian = "slv"
        case    SpanishCastilianModern = "spa"
        case    SpanishCastilianOld = "spa_old"
        case    Albanian = "sqi"
        case    Serbian = "srp"
        case    Swahili = "swa"
        case    Swedish = "swe"
        case    Tamil = "tam"
        case    Telugu = "tel"
        case    Tagalog = "tgl"
        case    Thai = "tha"
        case    Turkish = "tur"
        case    Ukrainian = "ukr"
        case    Vietnamese = "vie"
    }
    
}
