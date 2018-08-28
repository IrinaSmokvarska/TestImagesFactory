//
//  ImageViewerViewController.swift
//  TestImages
//
//  Created by Irina Smokvarska on 8/28/18.
//  Copyright © 2018 Irina Smokvarska. All rights reserved.
//

import UIKit
import Kingfisher

class ImageViewerViewController: UIViewController {
    @IBOutlet weak var mainImgView: UIImageView!
    @IBOutlet weak var btnSave: UIButton!
    var image: Image?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainImgView.kf.setImage(with: URL(string: (image?.url)!), options: [.cacheMemoryOnly])
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func saveImage(){
        if UserDefaults.standard.object(forKey: "favImages") != nil {
            let decoded = UserDefaults.standard.object(forKey: "favImages") as! Data
            var imgs = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Image]
            if let _ = imgs.filter({$0.id == image!.id}).first {
                return
            }
            imgs.append(image!)
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: imgs)
            UserDefaults.standard.set(encodedData, forKey: "favImages")
            UserDefaults.standard.synchronize()
        } else {
            
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: [image!])
            UserDefaults.standard.set(encodedData, forKey: "favImages")
            UserDefaults.standard.synchronize()
        }
        
    }
    @IBAction func onSaveImgTapped(_ sender: UIButton) {
       saveImage()
    }
    
}
