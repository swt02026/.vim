#for vim 
git clone https://github.com/swt02026/.vim.git ~/.vim
cd ~/.vim
git submoudle init 
git submodule update --init --recursive
ln -s ~/.vim/vimrc ~/.vimrc
mkdir ~/ycm_build
cd ~/ycm_build
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_support_libs --config Release
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer --system-libclang
cd ~/.vim/bundle/tern_for_vim && npm install
cd
