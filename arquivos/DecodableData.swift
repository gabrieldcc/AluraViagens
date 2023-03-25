//
//  DecodableData.swift
//  AluraViagens
//
//  Created by Ândriu Felipe Coelho on 28/01/21.
//

import Foundation

let sessaoDeViagens: [ViagemViewModel]? = load("server-response.json")

func load(_ filename: String) -> [ViagemViewModel]? {
    let file = getFile(fileName: filename)
    let data = getData(file: file)
    let json = getJSON(data: data)
    let listaDeViagens = getListaDeViagens(json: json)
    let jsonData = getJsonData(listaDeViagens: listaDeViagens)
    let tiposDeViagens = TiposDeViagens.decodeJson(jsonData)
    let listaDeViagensViewModel = getlistaViagemViewModel(
        tiposDeViagens: tiposDeViagens,
        listaDeViagens: listaDeViagens
    )
    return listaDeViagensViewModel
}

func getFile(fileName: String) -> URL {
    guard let file = Bundle.main.url(
        forResource: fileName,
        withExtension: nil
    ) else {
        fatalError("Couldn't find \(fileName) in main bundle.")
    }
    return file
}

func getData(file: URL) -> Data{
    let data: Data
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(file) from main bundle:\n\(error)")
    }
    return data
}

func getJSON(data: Data) -> [String: Any] {
    guard let json = try? JSONSerialization.jsonObject(
        with: data,
        options: []) as? [String: Any]
    else {
        fatalError("error to read json dictionary")
    }
    return json
}

func getListaDeViagens(json: [String: Any]) -> [String: Any] {
    guard let listaDeViagens = json["viagens"] as? [String: Any]
    else {
        fatalError("error to read travel list")
    }
    return listaDeViagens
}

func getJsonData(listaDeViagens: [String: Any]) -> Data {
    guard let jsonData = TiposDeViagens.jsonToData(listaDeViagens)
    else {
        return Data()
    }
    return jsonData
}

func getlistaViagemViewModel(tiposDeViagens: TiposDeViagens?, listaDeViagens: [String: Any]) -> [ViagemViewModel] {
    var listaViagemViewModel: [ViagemViewModel] = []
    for sessao in listaDeViagens.keys {
        switch ViagemViewModelType(rawValue: sessao)  {
        case .destaques:
            if  let destaques = tiposDeViagens?.destaques {
                let destaqueViewModel = ViagemDestaqueViewModel(destaques)
                listaViagemViewModel.insert(destaqueViewModel, at: 0)
            }
        default:
            break
        }
    }
    return listaViagemViewModel
}

