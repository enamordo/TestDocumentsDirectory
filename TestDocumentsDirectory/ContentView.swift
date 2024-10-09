//
//  ContentView.swift
//  TestDocumentsDirectory
//
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 100) {
            
            // ◻️ Documentsディレクトリ(ファイル)の削除
            // 直接Documentsディレクトリを指定すると、中身は削除できるがエラーが出る
            Button("ファイル削除") {
                let fileManager = FileManager.default
                var pathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                if !fileManager.fileExists(atPath: pathString + "/" + "sample88.text") {
                    print("指定されたファイルまたはフォルダが存在しない")
                    return
                }
                pathString = "file://" + pathString + "/" + "sample88.text"
                guard let path = URL(string: pathString) else { return }
                do {
                    try fileManager.removeItem(at: path)
                    print("成功した")
                } catch let error {
                    print("失敗した\(error)")
                }
            }
            
            // ◻️ Documentsディレクトリへの保存
            Button("ファイル保存") {
                let aString: String = "Saved!"
                let fileName: String = "sample88.text"
                if let documentDirectoryFileURL = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
                    
                    // 書き込むファイルのパス
                    let targetTextFilePath = documentDirectoryFileURL + "/" + fileName
                    
                    do {
                        try aString.write(toFile: targetTextFilePath, atomically: true, encoding: String.Encoding.utf8)
                    } catch let error as NSError {
                        print("failed to write: \(error)")
                    }
                }
                
            }
            
            // ◻️ Documentsディレクトリの読み込み
            Button("ファイル一覧取得") {
                // ① Documentsディレクトリ のファイルURLを取得
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                // ② ②Documents ディレクトリ配下のファイル一覧をURL型で取得する
                do {
                    // ファイル名一覧 取れないっぽい？
//                    let fileNames =  try FileManager.default.contentsOfDirectory(at: documentsURL)
                    
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
    ContentView()
}
