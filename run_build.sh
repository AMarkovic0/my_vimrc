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

mkdir ~/.vim/lua/
cp *.lua ~/.vim/lua
