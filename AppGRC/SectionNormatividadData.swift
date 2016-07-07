//
//  SectionNormatividadData.swift
//  AppGRC
//
//  Created by Crisoper on 13/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import Foundation

class SectionsNormatividadData {
    
    func getSectionsFromData() -> [SectionNormatividad] {
        
        // you could replace the contents of this function with an HTTP GET, a database fetch request,
        // or anything you like, as long as you return an array of Sections this program will
        // function the same way.
        
        var sectionsArray = [SectionNormatividad]()
        
        let consejo = SectionNormatividad(title: "CONSEJO REGIONAL", segue: "consejo", objects: ["Acuerdos de Consejo", "Ordenanzas de Consejo", "Convocatoria a Sesión de Consejo", "Consejeros Regionales"])
        let resoluciones = SectionNormatividad(title: "RESOLUCIONES", segue: "resoluciones", objects: ["Gobernación Regional", "Gerencia General", "Infraestructura", "Planeamiento, Presupuesto y AT", "Desarrollo Social", "Desarrollo Económico", "RENAMA", "Resoluciones Administrativas"])
        let decretos = SectionNormatividad(title: "DECRETOS", segue: "resoluciones", objects: ["Listado de Decretos"])
        let convenios = SectionNormatividad(title: "CONVENIOS Y ADENDAS", segue: "", objects: ["Listado de Convenios y Adendas"])
        let addendas = SectionNormatividad(title: "DIRECTIVAS", segue: "resoluciones", objects: ["Listado de Directivas"])
        
        sectionsArray.append(consejo)
        sectionsArray.append(resoluciones)
        sectionsArray.append(decretos)
        sectionsArray.append(convenios)
        sectionsArray.append(addendas)
        
        return sectionsArray
    }
}