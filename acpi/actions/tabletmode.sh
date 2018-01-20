#!/bin/bash

case "$4" in
  00000001)
    logger 'Switched to tablet mode'
    /usr/local/bin/rotate-screen inverted
    ;;
  00000000)
    logger 'Switched to laptop mode'
    /usr/local/bin/rotate-screen normal
    ;;
  *)
    logger "ACPI action undefined: $1 $2 $3 $4"
    ;;
esac
