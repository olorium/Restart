//
//  AudioPlayer.swift
//  Restart
//
//  Created by Oleksii Vasyliev on 05.04.2023.
//

import Foundation
import AVFoundation

/// Audio player for button sounds
final class AudioPlayer {
	/// Audio player.
	var audioPlayer: AVAudioPlayer?
	
	/// Plays specified sound of the specified type.
	/// - Parameters:
	///   - sound: The namae of the audio file.
	///   - type: The type of the audio file.
	func playSound(sound: String, type: String) {
		guard let path = Bundle.main.path(forResource: sound, ofType: type) else { return }
		
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
			audioPlayer?.play()
		} catch {
			print("error playing audio file")
		}
	}
}
