require File.expand_path('../bundle.rb', __FILE__)

bundle 'ack',         'mileszs/ack.vim'
bundle 'haml',        'tpope/vim-haml'
bundle 'slim',        'bbommarito/vim-slim'
bundle 'javascript',  'pangloss/vim-javascript'
bundle 'nerdtree',    'scrooloose/nerdtree'
bundle 'commentary',  'tpope/vim-commentary'
bundle 'supertab',    'ervandew/supertab'
bundle 'cucumber',    'tpope/vim-cucumber'
bundle 'textile',     'timcharper/textile.vim'
bundle 'snipmate',    'msanders/snipmate.vim'
bundle 'endwise',     'tpope/vim-endwise'
bundle 'coffee',      'kchmck/vim-coffee-script'
bundle 'stylus',      'wavded/vim-stylus'
bundle 'syntastic',   'scrooloose/syntastic'
bundle 'solarized',   'altercation/vim-colors-solarized'
bundle 'fugitive',    'tpope/vim-fugitive'
bundle 'tabular',     'godlygeek/tabular'
bundle 'surround',    'tpope/vim-surround'
bundle 'cmdp',        'kien/ctrlp.vim'
bundle 'less.js',     'lunaru/vim-less'
bundle 'task_paper',  'davidoc/taskpaper.vim'
bundle 'minitest',    'sunaku/vim-ruby-minitest'
bundle 'zoomwin',     'blueyed/ZoomWin'
bundle 'jade',        'digitaltoad/vim-jade'
bundle 'powerline',   'Lokaltog/vim-powerline'
bundle 'tagbar',      'majutsushi/tagbar'
bundle 'vitality',    'sjl/vitality.vim'
bundle 'tomorrow',    'DAddYE/vim-tomorrow-theme'
bundle 'smart-input', 'kana/vim-smartinput'

bundle 'nginx' do
  sh 'curl -sL http://www.vim.org/scripts/download_script.php?src_id=14376 > syntax/nginx.vim'
end

bundle 'css3' do
  sh 'curl -sL http://www.vim.org/scripts/download_script.php?src_id=15153 > syntax/css3.vim'
end

bundle 'ar.snippets' do
  sh 'mkdir -p snippets/ruby'
  sh 'curl -sL https://raw.github.com/DAddYE/snippets/master/active_model.snippets >> snippets/ruby.snippets'
end

bundle 'mustache' do
  sh 'curl -sL https://raw.github.com/defunkt/mustache/master/contrib/mustache.vim > syntax/mustache.vim'
  File.open(File.expand_path('../ftdetect/mustache.vim', __FILE__), 'w') do |file|
    file << 'au BufNewFile,BufRead *.mustache        setf mustache'
  end
end
