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
    
    lazy var stepsLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.font = .systemFont(ofSize: 24, weight: .semibold)
        view.textAlignment = .center
        view.textColor = .systemOrange
        view.text = "Your steps: \(stepCount)!"
        return view
    }()
    
    let wd = UIScreen.main.bounds.width
    let mg: CGFloat = 15
    let dis: CGFloat = 3
    lazy var bs = (wd-2*mg-3*dis)/4
    
    var stepCount = 0 {
        didSet {
            stepsLabel.text = "Your steps: \(stepCount)!"
        }
    }
    
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
        
        var numArr = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", ""]
        numArr.append("15")
        
        var k = 0
        for i in 0...3 {
            for j in 0...3 {
                let slideButton = UIButton(type: .system)
                slideButton.frame = CGRect(x: (bs+dis)*CGFloat(j), y: (bs+dis)*CGFloat(i), width: bs, height: bs)
                let str = numArr[k]
                slideButton.setTitle(str, for: .normal)
                slideButton.titleLabel?.font = .systemFont(ofSize: 40, weight: .regular)
                slideButton.setTitleColor(.black, for: .normal)
                slideButton.backgroundColor = UIColor.systemOrange
                slideButton.layer.cornerRadius = 12
                slideButton.clipsToBounds = true
                if str == "" {
                    slideButton.tag = 16
                } else {
                    slideButton.tag = Int(str) ?? 0
                }
                containerView.addSubview(slideButton)
                slideButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                k += 1
            }
        }
        
    }
    
    func addedSubviews() {
        view.addSubview(containerView)
        view.addSubview(stepsLabel)
    }
    
    func addedConstraints() {
        
        stepsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.top).offset(-20)
            make.left.equalTo(mg)
            make.right.equalTo(-mg)
        }
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(mg)
            make.right.equalTo(-mg)
            make.height.equalTo(containerView.snp.width)
        }
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let emptyBtn = (containerView.viewWithTag(16) as? UIButton) else {return}
        let tappedBtn = sender
        
        let emptyCenter = emptyBtn.center
        let tappedCenter = tappedBtn.center
        
        
        if abs(emptyCenter.x-tappedCenter.x) == bs+dis && abs(emptyCenter.y-tappedCenter.y) != bs+dis || abs(emptyCenter.x-tappedCenter.x) != bs+dis && abs(emptyCenter.y-tappedCenter.y) == bs+dis {
            UIView.animate(withDuration: 0.4) {
                emptyBtn.center = tappedCenter
                tappedBtn.center = emptyCenter
            }
            stepCount += 1
            if isWinner() == true {
                youWin()
            }
        }
    }
    
    func isWinner() -> Bool {
        guard let emptyBtn = (containerView.viewWithTag(16) as? UIButton) else { return false }
        if emptyBtn.center.x == (bs+dis)*CGFloat(3)+bs/2 && emptyBtn.center.y == (bs+dis)*CGFloat(3)+bs/2 {
            var k = 1
            var n = 0
            for i in 0...3 {
                for j in 0...3{
                    guard let checkBtn = (containerView.viewWithTag(k) as? UIButton) else { return false }
                    if checkBtn.center.x == (bs+dis)*CGFloat(j)+bs/2 && checkBtn.center.y == (bs+dis)*CGFloat(i)+bs/2 {
                        n += 1
                        if n == 16 {
                            return true
                        }
                    }
                    k += 1
                }
            }
        }
        
        
        return false
    }
    
    func youWin() {
        let alert = UIAlertController(title: "You win", message: "Congratulations! You winnner! Your steps \(stepCount)!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Restart", style: .default, handler: { _ in
            self.restart()
        }))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(alert, animated: true)
        }
    }
    
    func restart() {
        print("Restart")
    }
}
