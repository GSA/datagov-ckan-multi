# Data.gov Multi-tenant CKAN Security Documentation

Uses [hyperGRC](https://github.com/GovReady/hyperGRC) a lightweight, in-browser tool for managing compliance-as-code repositories in OpenControl format.

The goal is supporting compliance-as-code practices beginning with managing reusable OpenControl files for information technology systems and components.

## Install using Docker

```sh
$ git clone https://github.com/GSA/datagov-ckan-multi
$ cd _data/opencontrol
$ git clone https://github.com/GovReady/hyperGRC.git hypergrc
$ cd hypergrc
$ docker image build --tag hypergrc:latest .
$ cd ..
$ export REPOSITORY=`pwd`
$ docker container run -v $REPOSITORY:/opencontrol -p 127.0.0.1:8000:8000 --rm -it hypergrc:latest
```

The visit hyperGRC at `http://127.0.0.1:8000`.

Set `REPOSITORY` to the absolute path to your OpenControl content.

## Command-line options

### OpenControl repository paths

hyperGRC accepts several command-line arguments. You've already seen one: the local path to the OpenControl repository. You may specify one or more paths to OpenControl repositories to open them all up within hyperGRC.

```sh
python -m hypergrc example/agencyapp path/to/project2 ...
```

If you do not specify any paths on the command line, hyperGRC reads a list of paths to repositories from a file named `repos.conf`, e.g.:

```text
repos.conf
---------------
example/agencyapp
path/to/project2
```

Create this file if it does not exist if you would like to start hyperGRC without any command-line options. An example of such a file is in [repos.conf.example](repos.conf.example).

Start as:

```bash
python -m hypergrc
```

You may also specify files containing lists of paths to repositories on the command-line by preceding the listing file with an `@`-sign. The command above is equivalent to:

```bash
python -m hypergrc @repos.conf
```

### Other options

To bind to a host and port other than the default `localhost:8000`, use `--bind host:port`, e.g.:

```bash
python -m hypergrc --bind 0.0.0.0:80
```

## Understanding the compliance-as-code data files

OpenControl creates readable structured standard for representing component to control mappings. hyperGRC reads and writes OpenControl data YAML files, including:

* A system `opencontrol.yaml` file which containins metadata about the information technology system and lists the system's components and compliance standards in use.
* One or more `component.yaml` files which describe components of the information technology system. Each component has a name and other metadata and list of control implementations (i.e. control narrative texts).
* Zero or more `opencontrol.yaml` files for standards, i.e. lists of compliance controls such as NIST SP 800-53, NIST SP 800-53 Appendix J Priacy Controls, HIPAA, and so on.

A typical OpenControl repository contains files in the following directory layout:

```
├── opencontrol.yaml
├── standards
│   ├── opencontrol.yaml
│   ├── NIST-SP-800-53-r4.yaml
│   └── HIPAA.yaml
└── components
    ├── Component 1
    │   └── component.yaml
    └── Component 2
        └── component.yaml
```

Although not currently conformant with the OpenControl standard, hyperGRC also allows components to be broken out into multiple files:

```
...
└── components
    ├── Component 1
    │   ├── component.yaml
    │   ├── AC-ACCESS_CONTROL.yaml
    │   ├── SI-SYSTEM_AND_INFORMATION_INTEGRITY.yaml
    │   ...
    └── Component 2
        ├── component.yaml
        ...
```

For more details, see the files in example/agencyapp.

## Generating system security plans

### From the command line

hyperGRC includes a command-line tool to generate a partial system security plan in Markdown format. The tool concatenates all of the control narratives in an OpenControl system repository, adding headings and control descriptions.

For example, to generate a system security plan for the example application stored in this repository, run:

	python3 -m hypergrc.ssp -d example/agencyapp

## Licensing

hyperGRC is copyrighted 2018 by GovReady PBC and available under the open source license indicated in [LICENSE.md](LICENSE.md).

