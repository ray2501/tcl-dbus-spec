#!/usr/bin/tclsh

set arch "x86_64"
set base "dbus-2.2"
set fileurl "https://chiselapp.com/user/schelte/repository/dbus/tarball/dbus-92d71c1d63.tar.gz?uuid=92d71c1d639645ab73811e7edfd946d3e449ad695510ff6abfc1c9bff9a372c3"

set var [list wget $fileurl -O dbus.tar.gz]
exec >@stdout 2>@stderr {*}$var

set var [list tar xzvf dbus.tar.gz]
exec >@stdout 2>@stderr {*}$var

file delete dbus.tar.gz

set var [list mv dbus-92d71c1d63 $base]
exec >@stdout 2>@stderr {*}$var

set var [list tar czvf $base.tar.gz $base]
exec >@stdout 2>@stderr {*}$var

if {[file exists build]} {
    file delete -force build
}

file mkdir build/BUILD build/RPMS build/SOURCES build/SPECS build/SRPMS
file copy -force $base.tar.gz build/SOURCES

set buildit [list rpmbuild --target $arch --define "_topdir [pwd]/build" -bb tcl-dbus.spec]
exec >@stdout 2>@stderr {*}$buildit

# Remove our source code
file delete -force $base
file delete $base.tar.gz

