#!/usr/bin/tclsh

set arch "x86_64"
set base "dbus-3.0"
set fileurl "https://chiselapp.com/user/schelte/repository/dbus/tarball/061ad2decf/dbus-061ad2decf.tar.gz"

set var [list wget $fileurl -O dbus.tar.gz]
exec >@stdout 2>@stderr {*}$var

set var [list tar xzvf dbus.tar.gz]
exec >@stdout 2>@stderr {*}$var

file delete dbus.tar.gz

set var [list mv dbus-061ad2decf $base]
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

