#
# spec file for package tcl-dbus
#

%{!?directory:%define directory /usr}

Summary:	Tcl Library for Interacting with DBus
Name:		tcl-dbus
Version:	3.0
Release:	1
License:	BSD-3-Clause
Group:		Development/Languages/Tcl
URL:		https://chiselapp.com/user/schelte/repository/dbus/home
Source0:	dbus-%{version}.tar.gz
BuildArch:      x86_64
BuildRequires:	tcl-devel >= 8.5
BuildRequires:	tcl >= 8.5
BuildRequires:	tcllib
BuildRequires:  dbus-1-devel
BuildRoot:	%{tmpdir}/%{name}-%{version}-root-%(id -u -n)

%description
DBus-Tcl is a Tcl library for interacting with the DBus, a popular
system for applications to talk to eachother. DBus can also be used to
coordinate the lifecycle of a process. For more information about
DBus, see http://www.freedesktop.org/wiki/Software/dbus

%prep
%setup -q -n dbus-%{version}

%build
%configure \
	--prefix=%{directory} \
	--exec-prefix=%{directory} \
	--libdir=%{directory}/%{_lib} \
	--htmldir=%{_datadir}/doc/packages/tcl-dbus \
	--enable-64bit \
	--enable-threads

%{__make}

%install
rm -rf $RPM_BUILD_ROOT

%{__make} DESTDIR=$RPM_BUILD_ROOT pkglibdir=%{directory}/%{_lib}/tcl/dbus%{version} install

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(644,root,root,755)
%doc ChangeLog README
%{_datadir}/doc/packages/tcl-dbus/dbus.html
%{_datadir}/doc/packages/tcl-dbus/license.terms
%dir %{_libdir}/tcl/dbus%{version}
%attr(755,root,root) %{_libdir}/tcl/dbus%{version}/libdbus%{version}.so
%{_libdir}/tcl/dbus%{version}/pkgIndex.tcl
%{directory}/share/man/mann
