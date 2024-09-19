# SuperCollider Note

おれの [SuperCollider](https://supercollider.github.io/) 練習帳

## 参考

- [プログラミング言語で音づくり！？SuperCollider超入門 - YouTube](https://www.youtube.com/watch?v=TcskIuQ4dLs)
  - 大昔にやってみようと思って挫折したけど、再チャレンジすることにしたきっかけの動画
  - 動画中に出てくるコードを写経しながら視聴するがおすすめです
- [モジュラーシンセとしてのSuperCollider｜KuRiKuRo](https://note.com/sc3/n/nb08177c4c011)
  - 上の YouTube の最後に紹介されていたブログ

## エディタ設定メモ

SuperCollider の IDE は自分にはつらいので、Neovim を使っています。

[scnvim](https://github.com/davidgranstrom/scnvim) という Neovim 用 SuperCollider プラグインを利用しています。

これによって Neovim 上で SuperCollider の操作をすることができるようになります。

### キーマップについて

キーマップ設定は README にも書いてあるデフォルトのものを利用しています

自分はキーマップをすぐ忘れるので、ChatGPT にキーマップの内容について解説させたものを貼っておきます。

この設定で定義されているキーマップは、以下のようになります。次に挙げるのは、どのキーを押せば特定のコマンドが実行されるかを説明したものです。

1. `Alt + e` (`<M-e>`)
   - **モード**: インサートモード (`i`)、ノーマルモード (`n`)
   - **動作**: 現在の行を送信する (`editor.send_line`)

2. `Ctrl + e` (`<C-e>`)
   - **モード**: インサートモード (`i`)、ノーマルモード (`n`)
   - **動作**: 現在のブロックを送信する (`editor.send_block`)
   - **モード**: ビジュアルモード (`x`)
   - **動作**: 選択範囲を送信する (`editor.send_selection`)

3. `Enter` (`<CR>`)
   - **モード**: すべてのモード
   - **動作**: ポストウィンドウを切り替える (`postwin.toggle`)

4. `Alt + Enter` (`<M-CR>`)
   - **モード**: インサートモード (`i`)
   - **動作**: ポストウィンドウを切り替える (`postwin.toggle`)

5. `Alt + L` (`<M-L>`)
   - **モード**: ノーマルモード (`n`)、インサートモード (`i`)
   - **動作**: ポストウィンドウをクリアする (`postwin.clear`)

6. `Ctrl + k` (`<C-k>`)
   - **モード**: ノーマルモード (`n`)、インサートモード (`i`)
   - **動作**: シグネチャヘルプを表示する (`signature.show`)

7. `F12` (`<F12>`)
   - **モード**: ノーマルモード (`n`)、ビジュアルモード (`x`)、インサートモード (`i`)
   - **動作**: SuperColliderをハードストップする (`sclang.hard_stop`)

8. `リーダーキー + st` (`<leader>st`)
   - **動作**: SuperColliderを開始する (`sclang.start`)

9. `リーダーキー + sk` (`<leader>sk`)
   - **動作**: SuperColliderを再コンパイルする (`sclang.recompile`)

10. `F1` (`<F1>`)
    - **動作**: SuperColliderサーバーを起動する (`s.boot`)

11. `F2` (`<F2>`)
    - **動作**: SuperColliderサーバーメーターを表示する (`s.meter`)

