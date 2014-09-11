require 'rake'
require 'rake/clean'

CLEAN.include('index.html')

task :default do
	sh 'bundle exec lissio build -f'
	sh 'wget https://github.com/meh/npapi-clipboard/releases/download/v1.0.0.2/npClipboard.dll -O npClipboard.dll'
	sh 'chmod +rx npClipboard.dll'
	sh 'zip -9r dolly.zip index.html manifest.json npClipboard.dll img/ css/'
end
