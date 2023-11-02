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
if [ ! -d $(pwd)/vim ];
then
  git clone https://github.com/vim/vim.git
fi
cd $(pwd)/vim

sudo apt-get install liblua5.1-dev
sudo cp -r /usr/include/lua5.1/* /usr/include/lua5.1/include/
sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.1.so /usr/local/lib/liblua.so

./configure --with-features=huge \
            --enable-cscope \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
            --enable-multibyte \
            --enable-fontset \
            --disable-gui \
            --disable-netbeans \
            --enable-luainterp=yes \
            --with-lua-prefix=/usr/ \
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
