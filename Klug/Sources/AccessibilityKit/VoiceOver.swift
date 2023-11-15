import UIKit

import SwiftUI


class VoiceOverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(frame: .zero)
        button.setTitle("Hello World", for: .normal)

     //   button.accessibilityTraits would be UIAccessibilityTraitButton
     //   button.accessibilityLabel is set to "Hello World"
        
        multipleTraits()
        
    }
    
    private func accessibilityPostExample() {
        // Simply post that the layout has changed
        UIAccessibility.post(notification: .layoutChanged, argument: nil)

        // Or, post it with more context on what's specifically changed
        UIAccessibility.post(notification: .layoutChanged, argument: "Select birthday toggle now showing.")
        
        //add element to focus, use this with caution
        //let birthdayPicker = UIPickerView()
       // UIAccessibility.post(notification: .layoutChanged, argument: birthdayPicker)
    }
    
    private func multipleTraits() {
        let myTappableLabel = UILabel(frame: CGRect(x: 10, y: 100, width: 120, height: 44))
        myTappableLabel.text = "Change Folder"
        myTappableLabel.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(testFunc))
        myTappableLabel.addGestureRecognizer(tapGesture)
        
        myTappableLabel.accessibilityTraits = [.button, .header]
        
        view.addSubview(myTappableLabel)
    }
    
    @objc func testFunc() {
        let alert = UIAlertController(title: "some info", message: "message", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        present(alert, animated: true)
        
    }
    
    override class func accessibilityActivate() -> Bool {
        true
    }
}


#if DEBUG
import SwiftUI
struct VoiceOverViewControllerPreview: UIViewControllerRepresentable {
    typealias UIViewControllerType = VoiceOverViewController
    
    func makeUIViewController(context: Context) -> VoiceOverViewController {
        VoiceOverViewController()
    }
    
    func updateUIViewController(_ uiViewController: VoiceOverViewController, context: Context) {
    }
    
}

@available(iOS 13.0, *)
struct VoiceOverViewController_Preview: PreviewProvider {
    static var previews: some View {
        VoiceOverViewControllerPreview().ignoresSafeArea()
           
    }
}
#endif
