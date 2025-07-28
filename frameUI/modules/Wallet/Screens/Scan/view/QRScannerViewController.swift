//
//  QRScannerViewController.swift
//  Tedr
//
//  Created by Temur on 29/05/2025.
//  
//

import UIKit
import AVFoundation

class QRScannerViewController: TemplateController {
    private let captureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private let scannerView = QRScannerView()

    // MARK: - Lifecycle Methods
    override func initialize() {
        view.backgroundColor = .black

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        scannerView.closeAction = { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
        }
        view.addSubview(scannerView)

        setupCamera()
    }

    override func updateSubviewsFrames(_ size: CGSize) {
        previewLayer.frame = view.bounds
        scannerView.frame = view.bounds
        scannerView.updateSubviewsFrame(size)
    }

    private func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }

        let output = AVCaptureMetadataOutput()

        if captureSession.canAddInput(input) && captureSession.canAddOutput(output) {
            captureSession.addInput(input)
            captureSession.addOutput(output)

            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            output.metadataObjectTypes = [.qr]
        }

        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self else { return }
            captureSession.startRunning()
        }
        
    }
    

    // MARK: - Properties
    var presenter: ViewToPresenterQRScannerProtocol?
    
}

extension QRScannerViewController: PresenterToViewQRScannerProtocol {
    // TODO: Implement View Output Methods
}

extension QRScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        guard let obj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let stringValue = obj.stringValue else { return }

        print("Scanned QR: \(stringValue)")
        captureSession.stopRunning()
    }
}
