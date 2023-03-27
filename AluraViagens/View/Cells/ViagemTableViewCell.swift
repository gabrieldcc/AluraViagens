//
//  ViagemTableViewCell.swift
//  AluraViagens
//
//  Created by Ândriu Felipe Coelho on 30/05/21.
//

import UIKit

final class ViagemTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var backgroundViewCell: UIView!
    @IBOutlet weak var viagemImage: UIImageView!
    @IBOutlet weak var tituloViagemLabel: UILabel!
    @IBOutlet weak var subtituloViagemLabel: UILabel!
    @IBOutlet weak var diariaViagemLabel: UILabel!
    @IBOutlet weak var precoSemDescontoLabel: UILabel!
    @IBOutlet weak var precoViagemLabel: UILabel!
    @IBOutlet weak var statusCancelamentoViagemLabel: UILabel!
    
    //MARK: - Functions
    func setupCell(_ viagem: Viagem?) {
        populateCellComponents(viagem)
        setStrikeInValueWithoutDiscount(viagem)
        setDiariaViagemLabel(viagem)
        addShadow()
    }
    
    func populateCellComponents(_ viagem: Viagem?) {
        viagemImage.image = UIImage(named: viagem?.asset ?? "")
        tituloViagemLabel.text = viagem?.titulo
        subtituloViagemLabel.text = viagem?.subtitulo
        precoViagemLabel.text = "R$ \(viagem?.preco ?? 0)"
    }
    
    func setStrikeInValueWithoutDiscount(_ viagem: Viagem?) {
        let atributoString = NSMutableAttributedString(
            string: "R$ \(viagem?.precoSemDesconto ?? 0)"
        )
        atributoString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: 1,
            range: NSMakeRange(0, atributoString.length)
        )
        precoSemDescontoLabel.attributedText = atributoString
    }
    
    func setDiariaViagemLabel(_ viagem: Viagem?) {
        if  let numeroDeDias = viagem?.diaria,
            let numeroDeHospedes = viagem?.hospedes {
            let diarias = numeroDeDias == 1 ? "Diária" : "Diárias"
            let hospedes = numeroDeHospedes == 1 ? "Pessoa" : "Pessoas"
            diariaViagemLabel.text =
            "\(numeroDeDias) \(diarias) - \(numeroDeHospedes) \(hospedes)"
        }
    }
    
    func addShadow() {
        DispatchQueue.main.async {
            self.backgroundViewCell.addSombra()
        }
    }
}
