//
//  ViewController.swift
//  SkeletonView_Practice
//
//  Created by JIN on 2022/05/04.
//

import UIKit
import SkeletonView

class ViewController: UIViewController , UITableViewDelegate, SkeletonTableViewDataSource {
    
    //임의 데이터 세팅
    let color = [#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1), #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1), #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1) , #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1), #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1), #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1), #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1), #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)]
    let dataSource : [Int] = [0,12,3,24,234,4,4,234,34]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var reloadBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        fetchDataSource()
        setUI()
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        self.fetchDataSource()
    }
    
    func setUI() {
        tableView.backgroundColor = .white
        reloadBtn.layer.borderColor = UIColor.lightGray.cgColor
        reloadBtn.layer.borderWidth = 1
        reloadBtn.layer.cornerRadius = 10
    }
    
    private func fetchDataSource() {
        let gradient = SkeletonGradient(baseColor: .clouds, secondaryColor: .white)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        
        self.tableView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.5))
        
        //네트워크 통신 대신 DispatchQueue를 이용해 3초 딜레이 줘서 구현
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.tableView.stopSkeletonAnimation()
            self.tableView.hideSkeleton()
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.desc.text = "\(dataSource[indexPath.row])"
        cell.imgView.backgroundColor = color.randomElement()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(130)
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        
        return "TableViewCell"
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.desc.text = "\(dataSource[indexPath.row])"
        return cell
    }
    
    
}

