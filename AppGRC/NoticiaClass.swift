//
//  NoticiaClass.swift
//  AppGRC
//
//  Created by Crisoper on 18/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import Foundation

public class NoticiasClass {
    
    var titulo:String
    var descripcion:String
    var imagen:String
    var subtitulo:String
    var id:String
    var miniatura:String
    var fecha:String
    var archivos:String
    var corto:String
    
    init(titulo:String, descripcion:String, imagen:String, subtitulo:String, id:String, miniatura:String, fecha:String, archivos:String, corto:String) {
        self.titulo = titulo
        self.descripcion = descripcion
        self.subtitulo = subtitulo
        self.imagen = imagen
        self.id = id
        self.miniatura = miniatura
        self.fecha = fecha
        self.archivos = archivos
        self.corto = corto
    }
    //
    //    func basicInfo()->String {
    //        return "titulo: \(titulo), descripcion:  \(descripcion), imagen:  \(imagen)"
    //    }
    //
    //    func printInfo() {
    //        print(basicInfo())
    //    }
    
}
