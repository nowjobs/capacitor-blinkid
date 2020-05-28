import Foundation
import Capacitor
import Microblink

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */

@objc(BlinkIDPlugin)
@objcMembers
public final class BlinkIDPlugin: CAPPlugin {
    
    private var licenseKey: String? {
        didSet {
            MBMicroblinkSDK.sharedInstance().setLicenseKey(licenseKey ?? "")
        }
    }
    
    func setLicenseKey(_ call: CAPPluginCall) {
        guard let licenseKey = call.getString("key") else {
            call.reject("Please provide a license key")
            return
        }
        self.licenseKey = licenseKey
        call.success(["data": "This is the received license key \(licenseKey) 🔑"])
    }
    
    func startScanning(_ call: CAPPluginCall) {
        guard licenseKey != nil else {
            call.reject("No license key - please call `setLicenseKey` first")
            return
        }
        guard let recognizersData = call.getArray("recognizers", [String: Any].self) else {
            call.reject("Please provide a list of recognizers")
            return
        }
        let recognizers: [MBRecognizer] = .make(from: recognizersData)
        guard !recognizers.isEmpty else {
            call.reject("Please provide a valid list of recognizers")
            return
        }
        UIViewController.handler = { result in
            switch result {
            case .cancelled:
                call.success(["cancelled": true])
            case .failed:
                call.reject("Scanning failed")
            case .succeeded:
                let data: [String: Any?]
                #if targetEnvironment(simulator)
                data = MockRecognizerResult().serialized
                #else
                guard let result = recognizers.compactMap(\.baseResult).first(where: \.resultState.isValid) else {
                    call.reject("Scanning failed: no valid result")
                    return
                }
                switch result {
                case let result as MBBlinkIdRecognizerResult:
                    data = result.serialized
                case let result as MBBlinkIdCombinedRecognizerResult:
                    data = result.serialized
                default:
                    assertionFailure("Unsupported subclass")
                    data = [:]
                }
                #endif
                call.success([
                    "cancelled": false,
                    "data": data
                ])
            }
        }
        #if targetEnvironment(simulator)
        UIViewController.handler?(.succeeded)
        #else
        DispatchQueue.main.async { self.presentOverlayVC(with: recognizers) }
        #endif
    }
    
    private func presentOverlayVC(with recognizers: [MBRecognizer]) {
        let overlayVC = MBBlinkIdOverlayViewController(settings: MBBlinkIdOverlaySettings(),
                                                       recognizerCollection: .init(recognizers: recognizers),
                                                       delegate: bridge.viewController)
        let recognizerRunnerVC = MBViewControllerFactory.recognizerRunnerViewController(withOverlayViewController: overlayVC)
        
        bridge.viewController.present(recognizerRunnerVC, animated: true)
    }
    
    fileprivate enum ScanResult: String, Codable {
        case cancelled
        case succeeded
        case failed
    }
}

extension UIViewController: MBBlinkIdOverlayViewControllerDelegate {
    
    fileprivate static var handler: ((BlinkIDPlugin.ScanResult) -> Void)?
    
    public func blinkIdOverlayViewControllerDidFinishScanning(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController,
                                                              state: MBRecognizerResultState) {
        guard state.isValid else {
            return
        }
        Self.handler?(.succeeded)
        DispatchQueue.main.async { self.dismiss(animated: true) }
    }
    public func blinkIdOverlayViewControllerDidTapClose(_ blinkIdOverlayViewController: MBBlinkIdOverlayViewController) {
        Self.handler?(.cancelled)
        DispatchQueue.main.async { self.dismiss(animated: true) }
    }
}

