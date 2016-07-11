//
//  File.swift
//  AppGRC
//
//  Created by Crisoper on 9/07/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import Foundation

public class ClassDatosMAD {
    
//    var expediente:String = ""
//    var titulo:String = ""
//    var fecha:String = ""
//    var referencia:String = ""
//    var folios:String = ""
//    var uorganica:String = ""
//    var firma:String = ""
//    var cargo:String = ""
//    var asunto:String = ""
    
    
    var datos:String = ""
    var seguimiento:String = ""
    var adjunto:String = ""
    var relacionado:String = ""
    var idMadReferencia:String = ""
    
    /*
    init(expediente:String, titulo:String, fecha:String, referencia:String, folios:String, uorganica:String, firma:String, cargo:String, asunto:String) {
        self.expediente = expediente
        self.titulo = titulo
        self.fecha = fecha
        self.referencia = referencia
        self.folios = folios
        self.uorganica = uorganica
        self.firma = firma
        self.cargo = cargo
        self.asunto = asunto
    }
    */
    
    //
    //    func basicInfo()->String {
    //        return "titulo: \(titulo), descripcion:  \(descripcion), imagen:  \(imagen)"
    //    }
    //
    //    func printInfo() {
    //        print(basicInfo())
    //    }
    
    static let sharedDatosMAD = ClassDatosMAD()
    
}