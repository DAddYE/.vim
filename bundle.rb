# Verbatim copy of janus

module VIM
  Dirs    = %w[ after autoload doc compiler plugin snippets syntax syntax_checkers ftdetect ftplugin colors indent nerdtree_plugin ]
  VERSION = `vim --version`.scan(/VIM - Vi IMproved (\d)\.(\d)/).flatten.map(&:to_i)
  TmpDirs = %w[ tmp/repos tmp/backup tmp/swap ]
end

directory 'tmp'

VIM::Dirs.each    { |dir| directory dir }
VIM::TmpDirs.each { |dir| directory dir }

def bundle(name, repo=nil)
  cwd     = File.expand_path('../', __FILE__)
  dir     = File.expand_path("tmp/repos/#{name}")
  subdirs = VIM::Dirs

  namespace(name) do
    if repo
      file dir => 'tmp/repos' do

        case repo
        when /download_script/, /^\d+$/
          repo = "http://www.vim.org/scripts/download_script.php?src_id=#{repo}" if repo =~ /^\d+$/
          if filename = `curl --silent --head #{repo} | grep attachment`[/filename=(.+)/,1]
            filename.strip!
            sh "curl -sL #{repo} > tmp/repos/#{filename}"
          else
            raise ArgumentError, 'unable to determine script type'
          end
        when /(tar|gz|vba|zip)$/
          filename = File.basename(repo)
          sh "curl #{repo} > tmp/repos/#{filename}"
        else
          repo = "git://github.com/#{repo}" unless repo =~ /^(git|http(s)?)/
          repo << ".git" unless repo =~ /\.git$/
          sh "git clone #{repo} #{dir}"
        end

        case filename
        when /zip$/
          sh "unzip -o tmp/repos/#{filename} -d #{dir}"
        when /tar\.gz$/
          dirname  = File.basename(filename, '.tar.gz')
          sh "tar zxvf tmp/repos/#{filename}"
          sh "mv #{dirname} #{dir}"
        when /vba(\.gz)?$/
          if filename =~ /gz$/
            sh "gunzip -f tmp/repos/#{filename}"
            filename = File.basename(filename, '.gz')
          end

          # TODO: move this into the install task
          lines = File.readlines("tmp/repos/#{filename}")
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
        sh "cd #{dir} && git pull" if File.exist?("#{dir}/.git")
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
          yield if block_given?
        end
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
    puts "\e[32m Installing #{name} \e[0m".center(40, '*')
    puts
    Rake::Task["#{name}:install"].invoke
  end
  task :default => name
end

def skip_bundle(name)
  Rake::Task[:default].prerequisites.delete(name)
end

desc 'Update the documentation'
task :update_docs do
  puts 'Updating VIM Documentation...'
  system "vim -e -s <<-EOF\n:helptags ~/.vim/doc\n:quit\nEOF"
end

desc 'link vimrc to ~/.vimrc'
task :link_vimrc do
  %w[ vimrc gvimrc ].each do |file|
    dest = File.expand_path("~/.#{file}")
    unless File.exist?(dest)
      ln_s(File.expand_path("../#{file}", __FILE__), dest)
    end
  end
end

desc 'Cleanup vim directories and local changes'
task :clean do
  VIM::Dirs.each { |dir| sh "rm -rf #{dir}" }
  sh 'rm -rf tmp'
end

task :default => [:update_docs, :link_vimrc] + VIM::TmpDirs

desc 'Clear out all build artifacts and rebuild the latest Janus'
task :upgrade => [:clean, :default]
