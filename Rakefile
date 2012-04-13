require File.expand_path('../bundle.rb', __FILE__)

vim_plugin_task 'delimitmate',      'git://github.com/Raimondi/delimitMate.git'
vim_plugin_task 'ack',              'git://github.com/mileszs/ack.vim.git'
vim_plugin_task 'haml',             'git://github.com/tpope/vim-haml.git'
vim_plugin_task 'slim',             'git://github.com/bbommarito/vim-slim.git'
vim_plugin_task 'javascript',       'git://github.com/pangloss/vim-javascript.git'
vim_plugin_task 'nerdtree',         'git://github.com/scrooloose/nerdtree.git'
vim_plugin_task 'commentary',       'git://github.com/tpope/vim-commentary.git'
vim_plugin_task 'supertab',         'git://github.com/ervandew/supertab.git'
vim_plugin_task 'cucumber',         'git://github.com/tpope/vim-cucumber.git'
vim_plugin_task 'textile',          'git://github.com/timcharper/textile.vim.git'
vim_plugin_task 'snipmate',         'git://github.com/msanders/snipmate.vim.git'
vim_plugin_task 'endwise',          'git://github.com/tpope/vim-endwise.git'
vim_plugin_task 'coffee',           'git://github.com/kchmck/vim-coffee-script.git'
vim_plugin_task 'stylus',           'git://github.com/wavded/vim-stylus.git'
vim_plugin_task 'syntastic',        'git://github.com/scrooloose/syntastic.git'
vim_plugin_task 'solarized',        'git://github.com/altercation/vim-colors-solarized.git'
vim_plugin_task 'fugitive',         'git://github.com/tpope/vim-fugitive.git'
vim_plugin_task 'tabular',          'git://github.com/godlygeek/tabular.git'
vim_plugin_task 'surround',         'git://github.com/tpope/vim-surround.git'
vim_plugin_task 'cmdp',             'git://github.com/kien/ctrlp.vim.git'
vim_plugin_task 'less.js',          'git://github.com/lunaru/vim-less.git'
vim_plugin_task 'task_paper',       'git://github.com/davidoc/taskpaper.vim.git'
vim_plugin_task 'minitest',         'git://github.com/sunaku/vim-ruby-minitest.git'
vim_plugin_task 'zoomwin',          'git://github.com/blueyed/ZoomWin.git'
vim_plugin_task 'jade',             'git://github.com/digitaltoad/vim-jade.git'
vim_plugin_task 'powerline',        'git://github.com/Lokaltog/vim-powerline.git'
vim_plugin_task 'tagbar',           'git://github.com/majutsushi/tagbar.git'
vim_plugin_task 'vitality',         'https://github.com/sjl/vitality.vim.git'

vim_plugin_task 'nginx' do
  sh 'curl -sL http://www.vim.org/scripts/download_script.php?src_id=14376 > syntax/nginx.vim'
end

vim_plugin_task 'css3' do
  sh 'curl -sL http://www.vim.org/scripts/download_script.php?src_id=15153 > syntax/css3.vim'
end

vim_plugin_task 'tomorrow' do
  sh 'curl -sL https://raw.github.com/daddye/vim-tomorrow-theme/dev/colors/Tomorrow.vim > colors/tomorrow.vim'
end

vim_plugin_task 'pong' do
  sh 'curl -sL https://raw.github.com/gist/1617275/pong.vim > colors/pong.vim'
end

vim_plugin_task 'ar.snippets' do
  sh 'mkdir -p snippets/ruby'
  sh 'curl -sL https://raw.github.com/DAddYE/snippets/master/active_model.snippets >> snippets/ruby.snippets'
end

vim_plugin_task 'mustache' do
  sh 'curl -sL https://raw.github.com/defunkt/mustache/master/contrib/mustache.vim > syntax/mustache.vim'
  File.open(File.expand_path('../ftdetect/mustache.vim', __FILE__), 'w') do |file|
    file << 'au BufNewFile,BufRead *.mustache        setf mustache'
  end
end

vim_plugin_task 'arduino', 'git://github.com/vim-scripts/Arduino-syntax-file.git' do
  File.open(File.expand_path('../ftdetect/arduino.vim', __FILE__), 'w') do |file|
    file << 'au BufNewFile,BufRead *.pde             setf arduino'
  end
end
