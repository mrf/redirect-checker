#!/bin/sh


# Parse Command Line Arguments
while [ $# -gt 0 ]; do
case "$1" in
  --domain=*)
    domain="${1#*=}"
    ;;
  --help) 
    print_help
    ;;
  *)
  printf "Invalid argument, run --help for valid arguments.\n";
  exit 1
esac
shift
done

# Help menu
print_help() {
cat <<-HELP

Check a domain with curl to see if redirects are working as expected. More reliable than using a browser because of the lack of caching in curl.

Flags
--domain  the short (no protocol) domain to test

HELP
exit 0
}

command_exists () {
  type "$1" > /dev/null 2>&1;
}

if command_exists curl; then
  printf "Checking: $domain\n"
  curl -I $domain

  printf "Checking: http://$domain\n"
  curl -I http://$domain

  printf "Checking: http://www.$domain\n"
  curl -I http://www.$domain

  printf "Checking: https://$domain\n"
  curl -I https://$domain

  printf "Checking: https://www.$domain\n"
  curl -I https://www.$domain

else
  printf "curl is required for this script to function, install from your package manager first"
fi

