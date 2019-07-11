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

## Forks of Data.gov CKAN Extensions (to be merged back)
* [ckanext-datajson](https://github.com/ViderumGlobal/ckanext-datajson)
* [USMetadata](https://github.com/ViderumGlobal/USMetadata)
* [ckanext-datagovtheme](https://github.com/ViderumGlobal/ckanext-datagovtheme)

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
