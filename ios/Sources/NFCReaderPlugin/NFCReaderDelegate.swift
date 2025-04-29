// NFCReaderDelegate.swift
import Foundation
import CoreNFC

@objc public protocol NFCReaderDelegate: AnyObject {
    func didDetectTag(_ tag: NFCTagInfo)
    func didEncounterError(_ error: Error)
}