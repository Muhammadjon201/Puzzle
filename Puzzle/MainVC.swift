//
//  MainVC.swift
//  Puzzle
//
//  Created by ericzero on 11/4/22.
//

import UIKit
import SnapKit

class MainVC: UIViewController {
    
    
    let containerView = UIView()
    let restartLbl = UILabel()
    
    let wd = UIScreen.main.bounds.width
    let mg: CGFloat = 15
    let dis: CGFloat = 3
    lazy var bs = (wd-2*mg-3*dis)/4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createSubviews()
    }
    
    func createSubviews() {
        initSubviews()
        addedSubviews()
        addedConstraints()
    }
    
    func initSubviews() {
       
        containerView.backgroundColor = .white
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 12
        
        restartLbl.text = "restart"
        
        var k = 1
        for i in 0...3 {
            for j in 0...3 {
                let slideButton = UIButton(type: .system)
                slideButton.frame = CGRect(x: (bs+dis)*CGFloat(j), y: (bs+dis)*CGFloat(i), width: bs, height: bs)
                let str = k < 16 ? "\(k)" : ""
                slideButton.setTitle(str, for: .normal)
                slideButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
                slideButton.setTitleColor(.black, for: .normal)
                slideButton.backgroundColor = UIColor.systemOrange
                slideButton.layer.cornerRadius = 12
                slideButton.clipsToBounds = true
                slideButton.tag = k
                containerView.addSubview(slideButton)
                slideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                k += 1
            }
        }
        
    }
    
    func addedSubviews() {
        view.addSubview(containerView)
        view.addSubview(restartLbl)
    }
    
    func addedConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(mg)
            make.right.equalTo(-mg)
            make.height.equalTo(containerView.snp.width)
        }
        
        restartLbl.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(40)
            //make.left.equalTo(mg)
            make.right.equalTo(-30)
        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let emptyBtn = (containerView.viewWithTag(16) as? UIButton) else {return}
        let tappedBtn = sender

        let emptyCenter = emptyBtn.center
        let tappedCenter = tappedBtn.center

        if abs(emptyCenter.x - tappedCenter.x) == bs+dis || abs(emptyCenter.y - tappedCenter.y) == bs+dis {
            UIView.animate(withDuration: 0.5) {
                emptyBtn.center = tappedCenter
                tappedBtn.center = emptyCenter
            }
        } else {
            UIView.animate(withDuration: 1) {
                emptyBtn.center != tappedCenter
                tappedBtn.center != emptyCenter
            }
        }
        print(sender.tag)
    }
    
}
