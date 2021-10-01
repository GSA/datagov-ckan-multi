[![CircleCI](https://circleci.com/gh/GSA/datagov-ckan-multi.svg?style=svg)](https://circleci.com/gh/GSA/datagov-ckan-multi)

# This project is no longer maintained.

All information left as historical record, but may be incorrect/missing/incomplete.

# datagov-ckan-multi

The Data.gov multi-tenant CKAN platform

![CKAN multi-tenant Architecture](assets/images/Architecture.png)

[CKAN multi-tenant Setup Instructions](https://github.com/ViderumGlobal/ckan-cloud-cluster/tree/master/docs)

## Repositories
* [ckan-cloud-docker](https://github.com/ViderumGlobal/ckan-cloud-docker)
* [ckan-cloud-helm](https://github.com/ViderumGlobal/ckan-cloud-helm)
* [ckan-cloud-operator](https://github.com/ViderumGlobal/ckan-cloud-operator)
* [ckan-cloud-cluster](https://github.com/ViderumGlobal/ckan-cloud-cluster)
* [datagov-ckan-cloud-provisioning-api](https://github.com/ViderumGlobal/datagov-ckan-cloud-provisioning-api)
* [ckan-cloud-provisioning-api](https://github.com/ViderumGlobal/ckan-cloud-provisioning-api)
* [ckan-cloud-provisioning-ui](https://github.com/ViderumGlobal/ckan-cloud-provisioning-ui)
* [Viderium Project Management](https://github.com/ViderumGlobal/PM-datagov)
* [ckan-ng-harvest](https://gitlab.com/datopian/ckan-ng-harvest)

## Forks of Data.gov CKAN Extensions (to be merged back)
* [ckanext-datajson](https://github.com/ViderumGlobal/ckanext-datajson)
* [USMetadata](https://github.com/ViderumGlobal/USMetadata)
* [ckanext-datagovtheme](https://github.com/ViderumGlobal/ckanext-datagovtheme)


## OpenControl and compliance-as-code

We're documenting our security controls using
[OpenControl](https://open-control.org/) in order to make the work we've done to
meet security standards transparent and reusable. We're using
[HyperGRC](https://github.com/GovReady/hyperGRC) to provide an in-browser tool
for managing our compliance-as-code repositories.

### Usage

You can use HyperGRC locally to view and edit controls. This is a work in
progress. First, follow the instructions to [install
dependencies](#installation-of-this-static-site).

Start HyperGRC for editing.

```
npm run edit-controls
```

Then open your web browser to [localhost:8000](http://localhost:8000/).


## Installation of this static site

Clone the repository.

    $ git clone https://github.com/gsa/datagov-ckan-multi
    $ cd datagov-ckan-multi

Install the Node.js dependencies.

    $ npm install

Build the site.

    $ npm run build

Run the site locally.

    $ npm start

Open your web browser to [localhost:4000](http://localhost:4000/) to view your site.

After you make changes, be sure to run the tests.

    $ npm test

Note that when built by Federalist, `npm run federalist` is used instead of the `build` script.

###  Technologies used for this static site
- [Jekyll](https://jekyllrb.com/docs/) - The primary site engine that builds your code and content.
- [Front Matter](https://jekyllrb.com/docs/frontmatter) - The top of each page/post includes keywords within `--` tags. This is meta data that helps Jekyll build the site, but you can also use it to pass custom variables.
- [U.S. Web Design System v 2.0](https://v2.designsystem.digital.gov)
- [Jekyll Search](https://github.com/18F/jekyll_pages_api_search/)

###  Team Charter
- https://docs.google.com/document/d/1yFA-Mo3eoYW7kiHq2Rn0RdMAK78eB1S4p_L4wikzqdI/edit#heading=h.dcxtuiayu45i

