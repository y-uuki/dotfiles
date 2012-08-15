""""" y_uuki's vimrc """""

syntax on

" augroup がセットされていない autocmd 全般用の augroup
" これをやっておかないと ReloadVimrc したときに困る．
augroup MyAutocmd
    autocmd!
augroup END

" Vi互換モードを使わない
set nocompatible

" バックスペースでいろいろ消せる
set backspace=indent,eol,start

" バックアップファイルなし
set nobackup

" read/write a .viminfo file, don't store more than
set viminfo=!,'50,<1000,s100,\"50

" 履歴を500件まで保存する
set history=500

" カーソル位置を表示する
set ruler

" スクロール時の余白確保
set scrolloff=5

" set file encoding type "
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,sjis,euc-jp
set fileformats=unix,mac,dos

" 行番号表示 "
set number

""""" タブ幅 """""
set showtabline=2
set expandtab       " タブをスペースに展開する
set tabstop=4       " 画面上のタブ幅
set shiftwidth=4    " インデント時に自動的に挿入されるタブ幅
set softtabstop=4   " キーボードで<Tab>キーを押したときに挿入される空白の量
set shiftround

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する"
set ignorecase
set smartcase

" 検索時に最後まで行ったら最初に戻る"
set wrapscan

" 検索文字列入力時に順次対象文字列にヒットさせる"
set incsearch

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)"
set wildmenu

" ビープ音をOFFにする
set vb t_vb ="

" ステータスラインを常に表示"
set laststatus=2

" 括弧入力時の対応する括弧を表示"
set showmatch

" IMを使う
set noimdisable

" コマンドラインでのIM無効化
set noimcmdline""

" 入力中のコマンドをステータスに表示する
set showcmd

" 対応する括弧の行き来する時間の設定
set matchtime=3

" vimを開いた位置ではなくファイルのディレクトリ位置を起点にする
set browsedir=buffer

" コピペにクリップボードを使用する
set clipboard+=unnamed

" 文字にアンチエイリアスをかける "
if has('mac') && has('gui_running')
    set antialias
endif

" ビジュアルモードで選択したテキストが、クリップボードに入るようにする "
set clipboard+=autoselect

" 外部のエディタで編集中のファイルが変更されたら自動で読み直す"
set autoread

" 辞書ファイルからの単語補間"
set complete+=k

" 高速ターミナル接続を行う
set ttyfast

" タブ文字を CTRL-I で表示し, 行末に $ で表示する."
"set list

" Listモードに使われる文字を設定する "
"set listchars=tab:\ \ ,trail:-,eol:\

"imsertモードから抜けるときにIMをOFFにする（GUI(MacVim)は自動的にやってくれる
"iminsert = 2にすると，insertモードに戻ったときに自動的にIMの状態が復元される
if !has("gui-running")
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif

" ファイルを開いたときに, カレントディレクトリを編集中のファイルディレクトリに変更
augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

" :vimgrepでの検索後, QuickFixウィンドウを開く
augroup greopen
  autocmd!
  autocmd QuickfixCmdPost vimgrep cw
augroup END


""""""""""""""""""""""""""""""""
" ハイライト設定               "
""""""""""""""""""""""""""""""""
" 補完色を変更
highlight Pmenu ctermbg=8
highlight PmenuSel ctermbg=1
highlight PmenuSbar ctermbg=0

" 行末のスペースをハイライト
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd MyAutocmd WinEnter * match WhitespaceEOL /\s\+$/

" 全角スペースをハイライトする設定
" scriptencoding utf-8
"augroup highlightIdegraphicSpace
"  autocmd!
"  autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
"augroup END

" 挿入モードとノーマルモードでステータスラインの色変更
autocmd MyAutocmd InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermfg=Yellow cterm=none
autocmd MyAutocmd InsertLeave * hi StatusLine guifg=DarkBlue guibg=DarkGray   gui=none ctermfg=Blue ctermbg=DarkGray cterm=none

" vimrcのリロード "
command! ReloadVimrc source $MYVIMRC

" ファイル形式毎にテンプレートのを設定
augroup templates
  autocmd!
  autocmd BufNewFile *.pl 0r $HOME/.vim/templates/template.pl
  autocmd BufNewFile *.pm 0r $HOME/.vim/templates/template.pl
  autocmd BufNewFile *.rb 0r $HOME/.vim/templates/template.rb
  autocmd BufNewFile *.py 0r $HOME/.vim/templates/template.py
augroup END

" +perl, +python, +ruby  for MacVim
let $PERL_DLL = "/System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/libperl.dylib"
let $PYTHON_DLL = "/usr/lib/libpython.dylib"
let $RUBY_DLL = "/Users/zac/.rvm/rubies/ruby-1.9.3-p194/lib/libruby.dylib"

""""" syntaxチェック """""
" Rubyのsyntaxチェック
augroup rbsyntaxcheck
  autocmd!
  autocmd BufWrite *.rb w !ruby -c
augroup END

" Perlのsyntaxチェック
augroup plsyntaxcheck
  autocmd!
  autocmd BufWrite *.pl w !perl -c
augroup END

" Vundle関連
source ~/dotfiles/.vimrc.bundle

" Indent関連
source ~/dotfiles/.vimrc.indent

" 移動関連
source ~/dotfiles/.vimrc.moving

