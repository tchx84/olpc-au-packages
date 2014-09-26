Summary: Custom bits for OLPC AU
Name:    olpc-au-configs
Version: 0.2
Release: 1
URL:     https://www.laptop.org.au/
License: LGPL
Group:   User Interface/Desktops
Source0: olpc-au-configs-0.2.tar

#GitUrl: https://github.com/OneEducation/olpc-au-configs.git
#GitCommit: 8c0d4872f31394cde7073b5b32f654f8b61e5ce6

Requires: sugar >= 0.101
Requires: olpc-powerd

BuildArch: noarch

%description
Provide configurations and custom files requied by the OLPC AU deployment

%prep
%setup -q

%install
rm -rf %{buildroot}
mkdir %{buildroot}
cp -r %{_builddir}/%{name}-%{version}/* %{buildroot}

%files
%{_sysconfdir}/*
%{_datadir}/*

%post
# re-write powerd.conf file with olpcau tweaked version
cp /etc/powerd/powerd.conf.olpcau /etc/powerd/powerd.conf

# re-compile dconf schemas
glib-compile-schemas %{_datadir}/glib-2.0/schemas

%postun
glib-compile-schemas %{_datadir}/glib-2.0/schemas

%changelog
* Fri Sep 26 2014 Martin Abente Lahaye <tch@sugarlabs.org> 0.2.1
- Initial files
