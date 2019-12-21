//
//  ViewController.swift
//  Loteria
//
//  Created by Kaique Alves on 29/11/19.
//  Copyright © 2019 Kaique Alves. All rights reserved.
//

import UIKit

enum GameType: String{
    case megasena = "Mega-Sena"
    case quina = "Quina"
}

func gameMaker(total: Int, universe: Int) -> [Int]{
    var result: [Int] = []
    while result.count < total{
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber){
            result.append(randomNumber)
        }
    }
    return result.sorted()
}

class ViewController: UIViewController {

    @IBOutlet weak var lbGameType: UILabel!
    @IBOutlet weak var scGameType: UISegmentedControl!
    @IBOutlet var balls: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .megasena)
    }
    
    //esse for dentro dos parametros é um nome externo, nao eh um for
    func showNumbers(for type: GameType){
        lbGameType.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .megasena:
                game = gameMaker(total: 6, universe: 60)
                balls.last!.isHidden = false
            case .quina:
                game = gameMaker(total: 5, universe: 80)
                balls.last!.isHidden = true
        }
        for (index, game) in game.enumerated(){
            balls[index].setTitle("\(game)", for: .normal)
        }
    }

    @IBAction func generateGame() {
        switch scGameType.selectedSegmentIndex {
        case 0:
            showNumbers(for: .megasena)
        default:
            showNumbers(for: .quina)
        }
    }
    
}

