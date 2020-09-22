//
//  ViewController.swift
//  collectionViewPjt
//
//  Created by Amal Joshy on 22/09/20.
//  Copyright © 2020 Amal Joshy. All rights reserved.
//

import UIKit
import SDWebImage
class ViewController: UIViewController {
    @IBOutlet var collectioView : UICollectionView!

    let contextMenuItems = [
           ContextMenuItem(title: "Details", image: #imageLiteral(resourceName: "hamburger"), index: 0),
//           ContextMenuItem(title: "Add To Cart", image: #imageLiteral(resourceName: "hamburger"), index: 1),
//           ContextMenuItem(title: "View Detail", image: #imageLiteral(resourceName: "hamburger"), index: 2)
       ]
    var collection = [categories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        collectioView.collectionViewLayout = layout
        collectioView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        collectioView.delegate = self
        collectioView.dataSource = self
        let urlString = "http://iroidtechnologies.in/friday/index.php?route=api/common/getCategories"
        let url = URL(string: urlString)
        guard url != nil else{
            print("URL is nil")
            return
        }
        let session = URLSession.shared
        let datatask = session.dataTask(with: url!){ (data,response,error) in
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                
                do {
                    let jsonData = try decoder.decode(JsonModel.self, from: data!)
                    print("this is the JSON --->\(jsonData)")
                    
                    for i in jsonData.categories{
                        let name = i.name
                        let image = i.image
                        let category_id = i.category_id
                        let parent_id = i.parent_id
                        let top = i.top
                        let subcategory = i.subcategory
                        let categoryObject = categories(category_id: category_id, name: name, image: image, parent_id: parent_id, top: top, subcategory: subcategory)
                        self.collection.append(categoryObject)
                        }
                    print("helloo===\(self.collection)")
                    DispatchQueue.main.async {
                        self.collectioView.reloadData()
                    }
                }
                catch {
                    print("error parsing json ")
                }
            }
        }
        datatask.resume()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    //MARK: Context Menu
    @available(iOS 13.0, *)
    func makeContextMenu(for index:Int, isCollectionView: Bool) -> UIMenu {
        var actions = [UIAction]()
        for item in self.contextMenuItems {
            let action = UIAction(title: item.title, image: item.image, identifier: nil, discoverabilityTitle: nil) { _ in
                self.didSelectContextMenu(menuIndex: item.index, cellIndex: index, isCollectionView: isCollectionView)  //Calls didselect method and passed cellindex and selected menu indx
            }
            actions.append(action)
        }
        let cancel = UIAction(title: "Cancel", attributes: .destructive) { _ in}
        actions.append(cancel)
        return UIMenu(title: "", children: actions)
    }
    
    func didSelectContextMenu(menuIndex: Int, cellIndex: Int, isCollectionView: Bool){
          
           
           switch menuIndex {
           case 0: //wishList
            tabBarController?.selectedIndex = 2

           default:
               break
           }
           
       }
       
    
}
extension ViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let uiAlert = UIAlertController(title: "\(collection[indexPath.row].name)", message: "Selected", preferredStyle: .alert)
        uiAlert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        self.present(uiAlert,animated: true)
        print("tapped")
    }
    
    @available(iOS 13.0, *)
      func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
          return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
              return self.makeContextMenu(for: indexPath.row, isCollectionView: true)
          })
      }
}
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        //        cell.configure(with: UIImage(named: images[indexPath.row])!)
        cell.configure(collection[indexPath.row].image, collection[indexPath.row].name)
        return cell
    }
    
    
}
extension ViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3.73
        return CGSize(width: width, height: width + 20 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
