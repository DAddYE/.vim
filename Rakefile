# Verbatim copy of janus

module VIM
  Dirs = %w[ after autoload doc plugin ruby snippets syntax ftdetect ftplugin colors indent backup ]
end

directory "tmp"
VIM::Dirs.each do |dir|
  directory(dir)
end

def vim_version
  @_version ||= `vim --version`.scan(/VIM - Vi IMproved (\d)\.(\d)/).flatten.map(&:to_i)
end

def vim_plugin_task(name, repo=nil)
  cwd = File.expand_path("../", __FILE__)
  dir = File.expand_path("tmp/#{name}")
  subdirs = VIM::Dirs

  namespace(name) do
    if repo
      file dir => "tmp" do
        if repo =~ /git$/
          sh "git clone #{repo} #{dir}"

        elsif repo =~ /download_script/
          if filename = `curl --silent --head #{repo} | grep attachment`[/filename=(.+)/,1]
            filename.strip!
            sh "curl #{repo} > tmp/#{filename}"
          else
            raise ArgumentError, 'unable to determine script type'
          end

        elsif repo =~ /(tar|gz|vba|zip)$/
          filename = File.basename(repo)
          sh "curl #{repo} > tmp/#{filename}"

        else
          raise ArgumentError, 'unrecognized source url for plugin'
        end

        case filename
        when /zip$/
          sh "unzip -o tmp/#{filename} -d #{dir}"

        when /tar\.gz$/
          dirname  = File.basename(filename, '.tar.gz')

          sh "tar zxvf tmp/#{filename}"
          sh "mv #{dirname} #{dir}"

        when /vba(\.gz)?$/
          if filename =~ /gz$/
            sh "gunzip -f tmp/#{filename}"
            filename = File.basename(filename, '.gz')
          end

          # TODO: move this into the install task
          mkdir_p dir
          lines = File.readlines("tmp/#{filename}")
          current = lines.shift until current =~ /finish$/ # find finish line

          while current = lines.shift
            # first line is the filename (possibly followed by garbage)
            # some vimballs use win32 style path separators
            path = current[/^(.+?)(\t\[{3}\d)?$/, 1].gsub '\\', '/'

            # then the size of the payload in lines
            current = lines.shift
            num_lines = current[/^(\d+)$/, 1].to_i

            # the data itself
            data = lines.slice!(0, num_lines).join

            # install the data
            Dir.chdir dir do
              mkdir_p File.dirname(path)
              File.open(path, 'w'){ |f| f.write(data) }
            end
          end
        end
      end

      task :pull => dir do
        if repo =~ /git$/
          Dir.chdir dir do
            sh "git pull"
          end
        end
      end

      task :install => [:pull] + subdirs do
        Dir.chdir dir do
          if File.exists?("Rakefile") and `rake -T` =~ /^rake install/
            sh "rake install"
          elsif File.exists?("install.sh")
            sh "sh install.sh"
          else
            subdirs.each do |subdir|
              if File.exists?(subdir)
                sh "cp -RfL #{subdir}/* #{cwd}/#{subdir}/"
              end
            end
          end
        end

        yield if block_given?
      end
    else
      task :install => subdirs do
        yield if block_given?
      end
    end
  end

  desc "Install #{name} plugin"
  task name do
    puts
    puts "*" * 40
    puts "*#{"Installing #{name}".center(38)}*"
    puts "*" * 40
    puts
    Rake::Task["#{name}:install"].invoke
  end
  task :default => name
end

def skip_vim_plugin(name)
  Rake::Task[:default].prerequisites.delete(name)
end

vim_plugin_task "ack.vim",          "git://github.com/mileszs/ack.vim.git"
vim_plugin_task "haml",             "git://github.com/tpope/vim-haml.git"
vim_plugin_task "javascript",       "git://github.com/pangloss/vim-javascript.git"
vim_plugin_task "nerdtree",         "git://github.com/scrooloose/nerdtree.git"
vim_plugin_task "nerdcommenter",    "git://github.com/scrooloose/nerdcommenter.git"
vim_plugin_task "supertab",         "git://github.com/ervandew/supertab.git"
vim_plugin_task "cucumber",         "git://github.com/tpope/vim-cucumber.git"
vim_plugin_task "textile",          "git://github.com/timcharper/textile.vim.git"
vim_plugin_task "zoomwin",          "git://github.com/vim-scripts/ZoomWin.git" if vim_version[1] > 1
vim_plugin_task "snipmate",         "git://github.com/msanders/snipmate.vim.git"
vim_plugin_task "endwise",          "git://github.com/tpope/vim-endwise.git"
vim_plugin_task "coffee",           "git://github.com/kchmck/vim-coffee-script.git"
vim_plugin_task "gist",             "git://github.com/mattn/gist-vim.git"
vim_plugin_task "stylus",           "git://github.com/wavded/vim-stylus.git"
vim_plugin_task "synastic",         "git://github.com/scrooloose/syntastic.git"
vim_plugin_task "solarized",        "git://github.com/altercation/vim-colors-solarized.git"
vim_plugin_task "fugitive",         "git://github.com/tpope/vim-fugitive.git"
vim_plugin_task "tabular",          "git://github.com/godlygeek/tabular.git"
vim_plugin_task "surround",         "git://github.com/tpope/vim-surround.git"
vim_plugin_task "cmdp",             "git://github.com/kien/ctrlp.vim.git"
vim_plugin_task "less.js",          "git://github.com/lunaru/vim-less.git"

vim_plugin_task "css3" do
  sh 'curl http://www.vim.org/scripts/download_script.php?src_id=15153 > syntax/css3.vim'
end

vim_plugin_task "css.snippets" do
  sh 'curl https://raw.github.com/csexton/snipmate.vim/master/snippets/css.snippets > snippets/css.snippets'
end

vim_plugin_task "ar.snippets" do
  sh 'mkdir -p snippets/ruby'
  sh 'curl https://raw.github.com/DAddYE/snippets/master/active_model.snippets >> snippets/ruby.snippets'
end

vim_plugin_task "mustache" do
  sh "curl https://raw.github.com/defunkt/mustache/master/contrib/mustache.vim > syntax/mustache.vim"
  File.open(File.expand_path('../ftdetect/mustache.vim', __FILE__), 'w') do |file|
    file << "au BufNewFile,BufRead *.mustache        setf mustache"
  end
end

vim_plugin_task "arduino", "git://github.com/vim-scripts/Arduino-syntax-file.git" do
  File.open(File.expand_path('../ftdetect/arduino.vim', __FILE__), 'w') do |file|
    file << "au BufNewFile,BufRead *.pde             setf arduino"
  end
end

desc "Update the documentation"
task :update_docs do
  puts "Updating VIM Documentation..."
  system "vim -e -s <<-EOF\n:helptags ~/.vim/doc\n:quit\nEOF"
end

desc "link vimrc to ~/.vimrc"
task :link_vimrc do
  %w[ vimrc gvimrc ].each do |file|
  end
end

task :clean do
  VIM::Dirs.each { |dir| sh "rm -rf #{dir}" }
  sh "git clean -dfx"
end

desc "Pull the latest"
task :pull do
  sh "git pull origin master --force"
end

task :default => [
  :update_docs,
  :link_vimrc
]

desc "Clear out all build artifacts and rebuild the latest Janus"
task :upgrade => [:clean, :default]
