
# The grunt tools are low-level command-line tools

( cd extra/chobakwrap-pathfind && sh install.sh )
( cd extra/chobakwrap-shcm && sh install.sh )

cd grunt || exit
exec perl grunt-install.pl

