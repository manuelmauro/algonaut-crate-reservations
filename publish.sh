# add crates here (they will automatically have "algonaut_" prefixed). ex: "hello" will become the "algonaut_hello" crate
crates=(
)

rm -rf crates
mkdir crates

for crate in "${crates[@]}"
do
  cp -r template crates/algonaut_$crate
  sed -i "s/_CRATE/_$crate/g" crates/algonaut_$crate/Cargo.toml
done

cd crates
for crate in *
do
  echo "Publishing ${crate}"
  (cd $crate; cargo publish --allow-dirty)
  echo $crate >> ../reserved_crates
  sleep 15
done
cd ..
