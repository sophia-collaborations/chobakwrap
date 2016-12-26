
cd "$(dirname "${0}")" || exit

mkdir -p build

thedestin="$(chobakwrap -sub semap build/cbin write)"
rm -rf "${thedestin}"
mkdir "${thedestin}"

cc -o "${thedestin}/dateelem.out" csrc/dateelem.c


# And then --- we flip the semaphore:
chobakwrap -sub semap build/cbin flip

