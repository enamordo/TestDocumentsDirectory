//
//  MedcomFolderView.swift
//  TestDocumentsDirectory
//
//

import SwiftUI

struct MedcomFolderView: View {
    private let MEDCOMMEDIA = "MedcomMedia"
    private let fileManager = FileManager.default
    var body: some View {

        VStack(spacing: 100) {
            
            // ◻️ Documents/Medcomディレクトリ(ファイル)の削除
            // uploadをする時API実行とともに１件ずつ消していく。失敗した時には削除されていないファイルが残る
            Button("Medcom　ファイル削除") {
//                let fileManager = FileManager.default
                var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                if !fileManager.fileExists(atPath: pathString + "/" + MEDCOMMEDIA) {
                    print("指定されたファイルまたはフォルダが存在しない")
                    return
                }
                pathString = "file://" + pathString + "/" + MEDCOMMEDIA
                guard let path = URL(string: pathString) else { return }
                do {
                    try fileManager.removeItem(at: path)
                    print("成功した")
                } catch let error {
                    print("失敗した\(error)")
                }
            }
            
            // ◻️ Documents/Medcomディレクトリへの保存
            Button("Medcom　ファイル保存") {
                // ディレクトリ追加部
//                let fileManager = FileManager.default
                let documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let directory = documentDirectoryFileURL.appendingPathComponent(MEDCOMMEDIA, isDirectory: true)
                do {
                    try fileManager.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("失敗した")
                }
                
                let aString: String = "わお"
                let fileName: String = "sample99.text"
                if let documentDirectoryFileURL = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
                    
                    // 書き込むファイルのパス
                    let targetTextFilePath = documentDirectoryFileURL + "/" + MEDCOMMEDIA + "/" + fileName
                    
                    do {
                        try aString.write(toFile: targetTextFilePath, atomically: true, encoding: String.Encoding.utf8)
                    } catch let error as NSError {
                        print("failed to write: \(error)")
                    }
                }
                
            }
            
            // ◻️ Documents/Medcomディレクトリの読み込み
            Button("Medcom　ファイル一覧取得") {
                // ① Documentsディレクトリ のファイルURLを取得
//                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                
                var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                
                
                let documentsURL = URL(fileURLWithPath: pathString + "/" + MEDCOMMEDIA)
                // ② ②Documents ディレクトリ配下のファイル一覧をURL型で取得する
                do {
                    let contentURLs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                    print("データ：" + String(contentURLs.count) + "件")
                    print(contentURLs)
                } catch {
                    print("error")
                }
            }
            
        }
        .padding()
    }
}

#Preview {
    MedcomFolderView()
}
