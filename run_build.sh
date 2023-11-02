USR_DIR=$(getent passwd "$USER" | cut -d: -f6)

#Dependencies
if [ $(which cargo) ];
then
  cargo install typos-cli
else
  echo "ERROR: Cargo not found."
  exit 1
fi

# Install vim compiled with lua interpreter
git clone https://github.com/vim/vim.git
cd ./vim
./configure --with-features=huge \
            --enable-cscope \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-multibyte \
            --enable-fontset \
            --disable-gui \
            --disable-netbeans \
            --enable-luainterp=yes \
            --with-lua-prefix=/usr/include/lua5.1 \
            --enable-largefile
make
sudo make install
cp $(pwd)/src/vim
cd -

DOT_VIM_DIR=${USR_DIR}/.vim

if [ ! -d $DOT_VIM_DIR ];
then
  mkdir $DOT_VIM_DIR
fi
if [ ! -d $DOT_VIM_DIR/lua ];
then
  mkdir $DOT_VIM_DIR/lua
fi

cp *.lua $DOT_VIM_DIR
cp .vimrc $USR_DIR
