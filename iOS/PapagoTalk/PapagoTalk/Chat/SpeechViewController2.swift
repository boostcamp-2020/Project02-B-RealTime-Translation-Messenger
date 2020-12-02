//
//  SpeechViewController.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/02.
//

import UIKit

class SpeechViewController2: UIViewController {

    weak var delegate: SpeechViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func dismiss(_ sender: Any) {
        guard let superview = view.superview else { return }
        UIView.transition(with: superview,
                          duration: 0.4,
                          options: [.transitionCrossDissolve]) { [weak self] in
            self?.view.removeFromSuperview()
        } completion: { [weak self] _ in
            self?.delegate?.speechViewDidDismiss()
        }

        view.removeFromSuperview()
        removeFromParent()
        dismiss(animated: true)
    }
}
