Name:           linwood-flow
Version:        1.0.0
Release:        1%{?dist}
Summary:        Free, opensource time and event management software
BuildArch:      x86_64
URL:            https://github.com/LinwoodDev/Flow
License:        AGPLv3
Source0:        %{name}-%{version}.tar.gz

Requires:       bash

%description
Linwood Flow is a free, opensource time and event management software. You can choose where your data is stored and who can access it. Group your events and manage places and people. The app is available for Windows, Linux, Android and Web.

%prep
%setup -q

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_bindir}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/%{name}
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/pixmaps
cp %{name} $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R lib $RPM_BUILD_ROOT/%{_datadir}/%{name}
cp -R data $RPM_BUILD_ROOT/%{_datadir}/%{name}
ln -s %{_datadir}/%{name}/%{name} $RPM_BUILD_ROOT/%{_bindir}/%{name}
desktop-file-install %{name}.desktop

%clean
rm -rf $RPM_BUILD_ROOT

%files
%{_bindir}/%{name}
%{_datadir}/%{name}
/usr/share/applications/