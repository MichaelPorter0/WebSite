hexo generate
cp -R public/* .deploy/MichaelPorter0.github.io
cd .deploy/MichaelPorter0.github.io
git add .
git commit -m'update'
git push origin master