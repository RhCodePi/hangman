//
//  ViewController.swift
//  hangman
//
//  Created by Trakya9 on 31.05.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var hangmanImgLabel: UIImageView!
    var wrongGuess = 0
    var selectedWord = ""
    var hiddenWord = ""
    let alphabet = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    var counter = 0
    let lives = 10
    @IBOutlet weak var leftGuessLabel: UILabel!
    
    var isGameFinished: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let words = ["Test", "Campaing", "Match", "Love", "Mine"]
    
    var guessedLetters: [Character] = []
    
    @IBOutlet weak var hiddenWordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLayout()
        
        startGame()
    }
    
    func setLayout(){
        // CollectionView layout ve yapılandırma
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AlphabetCell.self, forCellWithReuseIdentifier: "AlphabetCell")
        collectionView.backgroundColor = UIColor.white
        
        // Auto Layout kısıtlamalarını programatik olarak ekleme
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    
    
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        startGame()
    }
    
    func startGame(){
        let randomIndex = Int.random(in: 0..<words.count)
        selectedWord = words[randomIndex]
        guessedLetters = []
        wrongGuess = 0
        isGameFinished = false
        // Gizli kelimeyi oluşturma
        hiddenWord = String(repeating: "_ ", count: selectedWord.count)
        hiddenWordLabel.text = hiddenWord
        leftGuessLabel.text = String(lives - wrongGuess)
        
        hiddenWordLabel.textAlignment = .center
        
        hangmanImgLabel.image = UIImage(named: "hangman\(wrongGuess)")
        
        for case let cell as AlphabetCell in collectionView.visibleCells
        {
            cell.button.isEnabled = true
            cell.button.backgroundColor = UIColor.lightGray
            cell.button.layer.cornerRadius = 20
        }
        
        print(hiddenWord)
        print(selectedWord)
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateItemSize()
    }
    
    // CollectionView için gerekli data source metodları
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alphabet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlphabetCell", for: indexPath) as! AlphabetCell
        
        // Harfi ekleme
        let letter = String(alphabet[indexPath.row])
        cell.button.setTitle(letter, for: .normal)
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(letterButtonTapped(_:)), for: .touchUpInside)
        
        
        // Hücreyi düzenleme
        cell.backgroundColor = UIColor.lightGray
        cell.layer.cornerRadius = 20
        
        if(isGameFinished){
            cell.button.isEnabled = false
        }
        
        
        return cell
    }
    
    private func updateItemSize() {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemsPerRow: CGFloat = 7
        let paddingSpace = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing * (itemsPerRow - 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        layout.itemSize = CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    @objc func letterButtonTapped(_ sender: UIButton) {
        
        if(!isGameFinished){
            let selectedLetter = alphabet[sender.tag]
            print("Selected letter: \(selectedLetter)")
            var isCorrect: Bool = false
            var correctLetters: [Character] = []
            
            print(hiddenWord.count)
            // Harf tahminini kontrol etme
            if !guessedLetters.contains(selectedLetter) {
                guessedLetters.append(selectedLetter)
            }
            
            if(selectedWord.uppercased().contains(selectedLetter)){
                isCorrect = true
                
            }
            // Gizli kelimeyi güncelleme
            hiddenWord = ""
            for char in selectedWord.uppercased() {
                
                if (guessedLetters.contains(char)) {
                    hiddenWord += "\(char) "
                    correctLetters.append(char)
                    
                } else {
                    hiddenWord += "_ "
                }
                print(hiddenWord)
            }
            
            if(!isCorrect && !isGameFinished){
                wrongGuess = wrongGuess + 1
            }
            
            
            
            //print(wrongGuess)
            hangmanImgLabel.image = UIImage(named: "hangman\(wrongGuess)")
            hiddenWordLabel.text = hiddenWord
            leftGuessLabel.text = String(lives-wrongGuess)
            
            
            // Harf düğmesini pasif hale getirme
            sender.isEnabled = false
            
            UIView.animate(withDuration: 0.54) {
                sender.layer.cornerRadius = 20
                sender.backgroundColor = UIColor.red
            }
        }
        
        let hiddenWordWithoutSpaces = hiddenWord.replacingOccurrences(of: " ", with: "")
        
        if selectedWord.uppercased() == hiddenWordWithoutSpaces {
            print(true)
            isGameFinished = true
        }
        
        
        
        if(wrongGuess == 10){
            isGameFinished = true
        }
        
    }
    
}
