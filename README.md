# ksmb

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ksmb](#setup)
    * [What ksmb affects](#what-ksmb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ksmb](#beginning-with-ksmb)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

* Installs ksmb backend to enable Kerberised Samba printing on the node.
* Installs arbitrary PPD files to arbitrary directories on the node (because the CUPS module this is designed to work with doesn't install PPD files).

TODO: split this module as it does two things.


## Setup

### What ksmb affects **OPTIONAL**

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements **OPTIONAL**

* You need puppetlabs-stdlib and leoarnold-cups Puppet modules.
* You need a [file server mount point](https://docs.puppet.com/puppet/4.9/file_serving.html) on your Puppet server that is served as puppet:///files/printer-ppds, or else override that location in Hiera.
* You need a Linux system joined to the same AD domain as the Samba printer server and a valid Kerberos ticket for the user who wishes to print.  At my site, the Linux nodes use the AD to authenticate user logins.

### Beginning with ksmb

The very basic steps needed for a user to get the module up and running. This
can include setup steps, if necessary, or it can be an example of the most
basic use of the module.

## Usage

You are using Hiera, right?

Put the following in your site.pp:
``` puppet
hiera_include('classes')
```

The following Hiera in a suitable place:

``` yaml
classes:
  - cups
  - ksmb

ksmb::ppdfiles:
  - KMbeuC554ux.ppd
ksmb::filterfiles:
  - KMbeuEmpPS.pl

cups::hiera: merge
cups::papersize: A4
cups::web_interface: true
cups::default_queue: PostRoom
cups_queue:
  PostRoom:
    ensure: printer
    uri: ksmb://printserver.example.com/PostRoomKonica
    ppd: "%{::ksmb::ppdpath}/KMbeuC554ux.ppd"
    accepting: true
    enabled: true
```

## Reference

Here, include a complete list of your module's classes, types, providers,
facts, along with the parameters for each. Users refer to this section (thus
the name "Reference") to find specific details; most users don't read it per
se.

## Limitations

This is actually a limitation of leoarnold-cups, but it might help you when deploying: if your global hiera.yaml specifies a merge_behavior other than the default "native", you won't be able to set a default queue in a common.yaml and then override it further up the hierarchy.

## Development

Since your module is awesome, other users will want to play with it. Let them
know what the ground rules for contributing are.

## Release Notes/Contributors/Etc. **Optional**

If you aren't using changelog, put your release notes here (though you should
consider using changelog). You can also add any additional sections you feel
are necessary or important to include here. Please use the `## ` header.
