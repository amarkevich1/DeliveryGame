//
//  PersonAppearance.swift
//  DeliveryGame
//
//  Created by aleksey on 9.07.21.
//

import UIKit

struct PersonAppearance {
    static var shirtColor: UIColor {
        let shirtColors = [#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)]
        return shirtColors.randomElement()!
    }

    static var skinTone: UIColor {
        let shirtColors = [#colorLiteral(red: 0.6256114841, green: 0.4084452689, blue: 0.1855236888, alpha: 1), #colorLiteral(red: 0.8221109509, green: 0.5951493382, blue: 0.3254807889, alpha: 1), #colorLiteral(red: 0.9058773518, green: 0.7278216481, blue: 0.4856755733, alpha: 1), #colorLiteral(red: 0.9594808221, green: 0.801353991, blue: 0.561588347, alpha: 1), #colorLiteral(red: 1, green: 0.8841020465, blue: 0.729377687, alpha: 1)]
        return shirtColors.randomElement()!
    }
}
