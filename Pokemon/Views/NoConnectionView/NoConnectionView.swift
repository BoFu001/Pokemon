//
//  NoConnectionView.swift
//  Pokemon
//
//  Created by BoFu on 01/04/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import UIKit

class NoConnectionView: UIView {
    
    var retryAction: (() -> ())?
    
    
    @IBOutlet weak var retryBtn: UIButton!
    @IBAction func retryBtnTapped(_ sender: UIButton) {
        retryAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        retryBtn.layer.cornerRadius = 5.0
    }
    
    class func noConnectionView() -> NoConnectionView? {
        return Bundle.main.loadNibNamed("NoConnectionView", owner: self, options: nil)?.first as? NoConnectionView
    }
    
    func pinToSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let view = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leftAnchor.constraint(equalTo: view.leftAnchor),
            self.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
}
