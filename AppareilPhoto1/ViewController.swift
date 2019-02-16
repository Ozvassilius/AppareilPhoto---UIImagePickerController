//
//  ViewController.swift
//  AppareilPhoto1
//
//  Created by Macinstosh on 13/01/2019.
//  Copyright © 2019 ozvassilius. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageViewChoisi: UIImageView!
    @IBOutlet weak var noImageLabel: UILabel!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if imageViewChoisi.image == nil {
            noImageLabel.isHidden = false
        } else { noImageLabel.isHidden = true }
    }
    
    func presentWithSource(_ source: UIImagePickerController.SourceType){
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func prendrePhoto(_ sender: UIButton) {
        
        let alerteActionSheet = UIAlertController(title: "prendre une photo", message: "choisissez le media", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Appareil photo", style: .default) { (action) in
            // verif si on est sur un device qui n'a pas de camera ou bien le simulateur
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.presentWithSource(.camera)
            } else {
                let alert = UIAlertController(title: "Erreur", message: "Aucun appareil photo disponible", preferredStyle: .alert)
                let annuler = UIAlertAction(title: "Je comprends", style: .destructive, handler: nil)
                alert.addAction(annuler)
                self.present(alert, animated: true, completion: nil)
            
        }
        }
        let gallery = UIAlertAction(title: "Gallerie de photo", style: .default) { (action) in
            self.presentWithSource(.photoLibrary)
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alerteActionSheet.addAction(camera)
        alerteActionSheet.addAction(gallery)
        alerteActionSheet.addAction(cancel)
        
        // pour eviter les problemes sur un iPad
        if let popOver = alerteActionSheet.popoverPresentationController{
            popOver.sourceView = view
            popOver.sourceRect = CGRect(x: view.frame.midX, y: view.frame.midY, width: 0, height: 0)
            popOver.permittedArrowDirections = []
        }
        /////
        
        present(alerteActionSheet, animated: true, completion: nil)
    }
    
}

// pas de variable dans une extension
// UIImagePickerControllerDelegate dans une extension pour que ce soit plus clair
extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // verif si on a une image edité
        if let editee = info[.editedImage] as? UIImage {
            imageViewChoisi.image = editee
        } else if let originale = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewChoisi.image = originale
        }
        dismiss(animated: true, completion: nil)
    }
}



