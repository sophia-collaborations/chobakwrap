
cd "$(dirname "${0}")" || exit

mkdir -p build

thedestin="$(chobakwrap -sub semap build/cbin write)"
rm -rf "${thedestin}"
mkdir "${thedestin}"

cc -o "${thedestin}/dateelem.out" csrc/dateelem.c
cc -o "${thedestin}/json-split.out" csrc/json-split.c
cc -o "${thedestin}/userinfo.out" csrc/userinfo.c


# And then --- we flip the semaphore:
chobakwrap -sub semap build/cbin flip

