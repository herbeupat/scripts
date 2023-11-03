ct_ids=$(pct list | grep -Eo '[0-9]+')
for id in $ct_ids
do
  echo "Updating vm $id"
  pct push "$id" "update_self.sh" "/root/update_self.sh"
  pct exec "$id" -- chmod "u+x" "/root/update_self.sh"
  pct exec "$id" -- bash "/root/update_self.sh"
done
