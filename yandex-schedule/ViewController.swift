//
//  ViewController.swift
//  yandex-schedule
//
//  Created by Nikolai  on 06.12.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var FromPointKey = ""
    var ToPointKey = ""
    var FromlabelText = "From"
    var TolabelText = "To"
    private var FindButton = UIButton()
    private var Fromlabel = UILabel()
    private var Tolabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createUI()
        createButton()
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("from = \(FromlabelText)")
        print("from KEY = \(FromPointKey)")
        print("to = \(TolabelText)")
        print("to KEY = \(ToPointKey)")
        createUI()
    }
    
    func createUI(){
        Fromlabel.text = FromlabelText
        Fromlabel.backgroundColor = .lightGray
        Fromlabel.textColor = .green
        Fromlabel.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
        Fromlabel.center = view.center
        Fromlabel.isUserInteractionEnabled = true
        let guestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FromlabelPressed))
        Fromlabel.addGestureRecognizer(guestureRecognizer)
        view.addSubview(Fromlabel)
        
        Tolabel.text = TolabelText
        Tolabel.backgroundColor = .lightGray
        Tolabel.textColor = .green
        Tolabel.frame = CGRect(x: 0, y: 450, width: 300, height: 40)
        Tolabel.center.x = view.center.x
        Tolabel.isUserInteractionEnabled = true
        let guestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(TolabelPressed))
        Tolabel.addGestureRecognizer(guestureRecognizer2)
        view.addSubview(Tolabel)
    }
    
    func createButton() {
        FindButton.frame = CGRect(x: 0, y: 700, width: 300, height: 40)
        FindButton.center.x = view.center.x
        FindButton.backgroundColor = .yellow
        FindButton.setTitle("Найти", for: .normal)
        FindButton.setTitleColor(.black, for: .normal)
        FindButton.addTarget(self, action: #selector(FindButtonPressed), for: .touchUpInside)
        view.addSubview(FindButton)
    }
    
    @objc func FindButtonPressed() {
        let ScheduleVC = ScheduleViewController()
        navigationController?.pushViewController(ScheduleVC, animated: true)
    }
    
    
    @objc func FromlabelPressed() {
        let FromVC = FromViewController()
//        present(secondVC, animated: true)
        navigationController?.pushViewController(FromVC, animated: true)
    }
    
    @objc func TolabelPressed() {
        let ToVC = ToViewController()
//        present(secondVC, animated: true)
        navigationController?.pushViewController(ToVC, animated: true)
    }
}

