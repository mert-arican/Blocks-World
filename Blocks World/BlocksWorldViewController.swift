//
//  BlocksWorldViewController.swift
//  Blocks World
//
//  Created by Mert Arıcan on 16.02.2020.
//  Copyright © 2020 Mert Arıcan. All rights reserved.
//

import UIKit
import AVFoundation

class BlocksWorldViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var k: CGFloat = { self.table.frame.width / 10.0 }()
    
    private var allBlockViews = [BlockView]()
    
    private let model = BlocksWorldModel()
    
    private var selectedBlock: BlockView? {
        didSet {
            selectedBlock?.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    func a(b: UILabel){
        b.sizeToFit()
        b.bounds.size = CGSize(width: b.bounds.size.width, height: b.bounds.size.height)
        scrollView.contentSize = CGSize(width: 0.0, height: b.bounds.size.height+(self.scrollView.bounds.height - 2*k))
        let bottomOffset = CGPoint(x: 0.0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
           scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.borderWidth = 3.0
            textField.layer.cornerRadius = 9.0
            textField.attributedPlaceholder = NSAttributedString(string: "Question", attributes: [.foregroundColor: UIColor.darkGray])
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(hear)
            hear.frame = scrollView.bounds
            hear.textColor = .white
            hear.numberOfLines = 0
            scrollView.contentSize = CGSize(width: 0.0, height: hear.bounds.size.height)
        }
    }
    
    private let audioEngine = AVAudioEngine()
    
    private let synthesizer = AVSpeechSynthesizer()
    
    @IBOutlet weak var table: UILabel!
    
    var hear = UILabel()

    var goalTree: [String] {
        get { return model.goalTree }
        set { model.goalTree = newValue }
    }
    
    func pile() {
        for block in model.allBlocks {
            if let position = Constantstinopolis.pilePositions[block.name] {
                block.origin = position
            }
        }
        drawBlocks()
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.textField.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        try? audioSession.setMode(AVAudioSession.Mode.spokenAudio)
        hear.text = ""
        a(b: hear)
        drawBlocks()
    }
    
    @IBAction func sor(_ sender: UIButton) {
        textField.resignFirstResponder()
        extractSpeech(speech: textField.text!.words)
    }
    
    @objc private func selectBlock(_ sender: UITapGestureRecognizer) {
        if let touchedBlock = sender.view as? BlockView {
            if let selected = selectedBlock {
                if selected == touchedBlock {
                } else {
                    goalTree = []
                    model.put(block: selected.block, destination: touchedBlock.block)
                    animateMovement(movements: model.movements)
                }
                drawBlock(block: selected)
                selectedBlock = nil
            } else {
                selectedBlock = touchedBlock
            }
        }
    }
    
    private func getBlockView(for block: Block) -> BlockView {
        allBlockViews.first { $0.block == block }!
    }
    
}

extension BlocksWorldViewController {
    
    private var tapRecognizer: UITapGestureRecognizer {
        return UITapGestureRecognizer(target: self, action: #selector(selectBlock(_:)))
    }

    private func drawBlocks() {
        allBlockViews.forEach { $0.removeFromSuperview() }
        allBlockViews = [] ; self.table.layer.borderWidth = 0.45
        var index = 0 ; self.table.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        for block in model.allBlocks {
            let origin = table.frame.origin.offsetby(x: CGFloat(block.origin.x) * k, y: -(CGFloat(block.origin.y) * k))
            let size = CGSize(width: CGFloat(block.width) * k, height: CGFloat(block.height) * k)
            let frame = CGRect(origin: origin, size: size)
            let blockView = BlockView(frame: frame)
            blockView.layer.borderWidth = 0.45
            blockView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            blockView.block = block
            blockView.addGestureRecognizer(tapRecognizer)
            drawBlock(block: blockView)
            allBlockViews.append(blockView)
            self.view.addSubview(blockView)
            let label = UILabel()
            label.text = "B\(index)"
            label.textAlignment = .center
            label.textColor = .white
            label.frame = blockView.bounds
            blockView.addSubview(label)
            index += 1
        }
    }
    
    private func drawBlock(block: BlockView) {
        switch block.block.color {
        case .black:
            block.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case .brown:
            block.backgroundColor = #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)
        case .blue:
            block.backgroundColor = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        case .green:
            block.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        case .orange:
            block.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        case .purple:
            block.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        case .red:
            block.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        case .yellow:
            block.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        }
    }
    
    private func consecutiveRecursiveAnimation(blocks: [BlockView], locations: [CGPoint], index: Int, endingIndex: Int) {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.35, delay: 0.0, options: [], animations: {
            let ind = (index / 3)
            blocks[ind].frame.origin = locations[index]
        }) { (finished) in
            if index != endingIndex {
                self.consecutiveRecursiveAnimation(blocks: blocks, locations: locations, index: index+1, endingIndex: endingIndex)
            } else {
                self.model.clearMovements()
            }
        }
    }
    
    private func animateMovement(movements: [(Block, Position)]) {
        guard movements.count > 0 else { return }
        var locations = [CGPoint]()
        var blocks = [BlockView]()
        for movement in movements {
            let block = getBlockView(for: movement.0)
            let destinationPoint = table.frame.origin.offsetby(x: CGFloat(movement.1.x) * k, y: -(CGFloat(movement.1.y) * k))
            let p1 = CGPoint(x: block.frame.origin.x, y: 8.0)
            let p2 = CGPoint(x: destinationPoint.x, y: p1.y)
            locations.append(contentsOf: [p1, p2, destinationPoint])
            blocks.append(block)
        }
        consecutiveRecursiveAnimation(blocks: blocks, locations: locations , index: 0, endingIndex: locations.count-1)
    }
    
    // Disgusting implementation but it works.
    private func extractSpeech(speech: [Substring]) {
        if speech.count == 1 && speech[0].lowercased() == "pile" { pile() ; return }
        guard speech.count >= 2 else { return }
        hear.text! += "\nA: " + textField.text!
        a(b: hear)
        var arguments: [String] = [] ; var index = 0
        for word in speech {
            let word = word.lowercased()
            if let name = word.contains(collection: Constantstinopolis.names) {
                arguments.append(name); index = Constantstinopolis.names.firstIndex(of: name) ?? 0
            } else if word.contains("why") {
                arguments.append("why")
            }
            if let action = word.contains(collection: ["put", "rid", "clear", "find"]) {
                arguments.append(action)
            }
        }
        let isCommand = !arguments.contains("why") && arguments != []
        //        print(arguments)
        //        guard goalTree.count == 11 || isCommand else { return } // Only spesific movement can be answered.
        let name = Constantstinopolis.names[index]
        //        print(name)
        //        goalTree.forEach { print($0) }
        var actions = [String]()
        if !isCommand {
            actions = [goalTree.first!]
            let a = goalTree.filter({ (string) -> Bool in
                string.lowercased().contains("\(name)")
            })
            if let b = a.first {
                let a = goalTree.filter { $0.lowercased().contains("\(name)") }
                if !arguments.contains("clear") && !arguments.contains("find") {
                    let i = goalTree.firstIndex(of: b)!; actions.insert(goalTree[i-1], at: 1) }
                actions.append(contentsOf: a)
            } else {
                var message = "\nB: Did I do that?"
                hear.text! += message
                message.removeFirst(3)
                speak(text: message)
                self.a(b: hear); return
            }
        }
        //        print("#########")
        //        actions.forEach { print($0) }
        if !isCommand {
            var ind = 0; print("YAAYY!")
            if arguments.contains("rid") {
                for (index, action) in actions.enumerated() {
                    if action.contains("rid") && index != 0 { ind = index; break }
                }
            } else if arguments.contains("put") {
                for (index, action) in actions.enumerated() {
                    if action.contains("put") && index != 0 { ind = index; break }
                }
            } else if arguments.contains("clear") {
                for (index, action) in actions.enumerated() {
                    if action.contains("clear") && index != 0 { ind = 1; break }
                }
            } else if arguments.contains("find") {
                for (index, action) in actions.enumerated() {
                    if action.contains("find") && index != 0 { ind = 1; break }
                }
            }
            if ind-1 >= 0 {
                print(actions[ind-1], "YYY");
                speak(text: actions[ind-1])
                hear.text! += "\nB: " + actions[ind-1]
                a(b: hear)
            }
        } else {
            print("YAYy", arguments)
            if arguments.count >= 2 {
                goalTree = []
                model.put(block: model.getBlock(with: arguments[1]), destination: model.getBlock(with: arguments[2]))
                animateMovement(movements: model.movements)
            }
        }
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "us-US")
        utterance.volume = 1.0
        synthesizer.speak(utterance)
    }
    
}

extension CGSize {
    
    func scaled(by k: CGFloat) -> CGSize {
        return CGSize(width: self.width*k, height: self.height*k)
    }
    
}
