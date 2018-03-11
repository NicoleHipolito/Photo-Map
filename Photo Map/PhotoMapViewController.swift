//
//  PhotoMapViewController.swift
//  Photo Map
//
//  Created by Nicholas Aiwazian on 10/15/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI
import MessageUI

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, LocationsViewControllerDelegate {
    
    func locationsPickedLocation(controller: LocationsViewController, latitude: NSNumber, longitude: NSNumber) {
        
    }
    
//    var mapView: MKMapView!
    @IBOutlet weak var mapView: MKMapView!
    var originalImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //one degree of latitude is approximately 111 kilometers (69 miles) at all times.
        let sfRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(37.783333, -122.416667),
                                              MKCoordinateSpanMake(0.1, 0.1))
        mapView.setRegion(sfRegion, animated: false)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageButtonTappen(_ sender: Any) {
        imagePickerHelper()
    }
    func imagePickerHelper(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
            //            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //            vc.sourceType = .photoLibrary
            
        }
        self.present(vc, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController

        originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
//        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
//
//        // Do something with the images (based on your use case)
//        imageUpload.image = originalImage
//
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "tagSegue", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if(segue.identifier == "tagSegue"){
            let destinationViewController = segue.destination as! LocationsViewController
            destinationViewController.delegate = self
        }
        // Pass the selected object to the new view controller.
    }
    

}
