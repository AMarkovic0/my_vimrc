#Dependencies
cargo install typos-cli

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
