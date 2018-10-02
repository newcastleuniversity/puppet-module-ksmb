# ksmb

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ksmb](#setup)
    * [What ksmb affects](#what-ksmb-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ksmb](#beginning-with-ksmb)
1. [Usage - Configuration options and additional functionality](#usage)

## Description

* Installs ksmb backend to enable Kerberised Samba printing on the node.
* Installs arbitrary PPD files to arbitrary directories on the node (because the CUPS module this is designed to work with doesn't install PPD files).

TODO: split this module as it does two things.
TODO: remove stated dependency on leoarnold-cups and rewrite docs to suggest use of leoarnold-cups instead of mandating it.  It doesn't actually matter to this module how CUPS is managed.


## Setup

### What ksmb affects

If it's obvious what your module touches, you can skip this section. For
example, folks can probably figure out that your mysql_instance module affects
their MySQL instances.

If there's more that they should know about, though, this is the place to mention:

* A list of files, packages, services, or operations that the module will alter,
  impact, or execute.
* Dependencies that your module automatically installs.
* Warnings or other important notices.

### Setup Requirements

* You need puppetlabs-stdlib.
* You need a means of injecting the right PPD file for your printers.  I used ghoneycutt-types to create a file resource in Hiera and made a module to serve the files.
* You need to manage your Cups queues.  We have used mosen-cups and now use leoarnold-cups.
* You need a Linux system joined to the same AD domain as the Samba printer server and a valid Kerberos ticket for the user who wishes to print.  At my site, the Linux nodes use the AD to authenticate user logins.

### Beginning with ksmb

If you aren't using Hiera:
``` puppet
include ksmb
```
in your node definition will get the backend scripts in place.

## Usage

You are using Hiera, right?

Put the following in your site.pp:
``` puppet
hiera_include('classes')
```

The following example Hiera, tweaked to meet your needs, in a suitable yaml file:

``` yaml
classes:
# leoarnold-cups
  - cups
# This module
  - ksmb
# ghoneycutt-types
  - types
# A dummy module that exists for me to put arbitrary files in.  https://gitlab.ncl.ac.uk/puppet5/fileserver
  - fileserver

types::files:
  '/usr/share/cups/model/KOC658UX.ppd':
    ensure: file
    source: puppet:///modules/fileserver/ppds/KOC658UX.ppd
    mode: '0644'
    group: lp

cups::resources:
  USB-Building-Printing:
    ensure: printer
    uri: ksmb://cs-print/USB-BUILDING-PRINTING
    ppd: /usr/share/cups/model/KOC658UX.ppd
    shared: false
    enabled: true
    accepting: true
    description: All Urban Sciences printers, swipe your campus card at any printer to collect your job.
    options:
      KMDuplex: 2Sided
      PageSize: A4
      PaperSources: PC215
      Finisher: FS533
      KOPunch: PK519-4
      SaddleUnit: None
      PrinterHDD: HDD
      SelectColor: Grayscale
      Model: C458
      TextPureBlack: On

cups::default_queue: USB-Building-Printing
cups::papersize: A4
```

## Limitations

This is actually a limitation of leoarnold-cups, but it might help you when deploying: if your global hiera.yaml specifies a merge_behavior other than the default "native", you won't be able to set a default queue in a common.yaml and then override it further up the hierarchy.
