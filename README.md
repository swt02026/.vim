# Installation on Ubuntu

## Clone the repo

    git clone git://github.com/kwk/dotvim.git ~/.vim

## Initialize the submodules

You need to bring in the code of the plugins and their third-party dependencies by updating the plugin submodules:

    cd ~/.vim
    git submodule init
    git submodule update --init --recursive

## Install LLVM, CMake, and Python-dev to compile YouCompleteMe

These steps are tedious, I know, but it has to be done only once and only for the
[YouCompleteMe][3] plugin.

Follow the steps to install the development version of [LLVM via Apt][2]. This is needed to get the [YouCompleteMe][3] to work. Maybe you can also use the other versions but I like to have the development version.

    sudo -s

    apt-get install cmake python-dev

    wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key| apt-key add -

    apt-get update
    
    apt-get install clang-3.6 clang-3.6-doc libclang-common-3.6-dev \
    libclang-3.6-dev libclang1-3.6 libclang1-3.6-dbg libllvm-3.6-ocaml-dev \
    libllvm3.6 libllvm3.6-dbg lldb-3.6 llvm-3.6 llvm-3.6-dev llvm-3.6-doc \
    llvm-3.6-examples llvm-3.6-runtime clang-modernize-3.6 clang-format-3.6 \
    python-clang-3.6 lldb-3.6-dev

As non-root run the following commands to build [YouCompleteMe][3].

    cd ~
    
    mkdir ycm_build
    
    cd ycm_build
    
    cmake -G "Unix Makefiles" \
      -DUSE_SYSTEM_LIBCLANG=ON \
      -DCMAKE_CXX_FLAGS="$(llvm-config-3.6 --cppflags)" \
      -DCMAKE_C_FLAGS="$(llvm-config-3.6 --cflags)" \
      -DUSE_CLANG_COMPLETER=ON \
      . \
      ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp

    make -j4 ycm_support_libs

Now you should see that there are `.so` files in your [YouCompleteMe][3]
directory:

    find ~/.vim/bundle/YouCompleteMe/ -name "*.so"

The output should somewhat look like this:

    .vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so
    .vim/bundle/YouCompleteMe/third_party/ycmd/ycm_client_support.so
    .vim/bundle/YouCompleteMe/third_party/ycmd/libclang.so

## Create symlinks:

This will finally activate your vim config

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

# Upgrading a plugin bundle

At some point in the future, the fugitive plugin might be updated. To fetch the
latest changes, go into the fugitive repository, and pull the latest version:

    cd ~/.vim/bundle/fugitive
    git pull origin master

# Upgrading all bundled plugins

You can use the foreach command to execute any shell script in from the root of
all submodule directories. To update to the latest version of each plugin
bundle, run the following:

    git submodule foreach git pull origin master


# Configure your CMake-based C/C++ project to work with YouCompleteMe

Most of the time your C/C++ project uses custom compiler flags. To make
[YouCompleteMe][3] automatically find them, you have to enable the
`CMAKE_EXPORT_COMPILE_COMMANDS` when configuring your CMake build. Then a file
named [compile_commands.json][4] will be created in the build directory.

We can make use of this file by copying a script to your project's source
directory:

    cp ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py \
      /YOUR/SOURCE/ROOT/DIR/

Then open the file `/YOUR/SOURCE/ROOT/DIR/.ycm_extra_conf.py` and change the
`compilation_database` variable to point to the directory in which you build
with CMake. Remember, that is where the `compile_commands.json` file is.

    compilation_database = '/PATH/TO/YOUR/CMAKE/BUILD/DIR'

The next time you open a file from your C/C++ project, [YouCompleteMe][3] is
smart enough to figure out the include paths etc. on its own.

# About

This is inspired by the post [Synchronizing plugins with git submodules and
pathogen][1] and the part of upgrading a plugin bundle is a 1:1 copy from the page. 

[1]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
[2]: http://llvm.org/apt/
[3]: https://github.com/Valloric/YouCompleteMe 
[4]: http://clang.llvm.org/docs/JSONCompilationDatabase.html
