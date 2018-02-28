district-builder.app-server
=========

Ansible role to configure a DistrictBuilder application server.

Role Variables
--------------

**`districtbuilder_app_home`**: Directory where configuration files and data will be loaded. Default: `/opt/district-builder`

**`districtbuilder_image_version`**: Version of DistrictBuilder to run. Default: `latest`

**`districtbuilder_user_config_file`**: Use a user-provided `config.xml` file to generate settings. Default: `true`. ***Note: If this is `true`, place the config file in the `files/` folder.

**`districtbuilder_web_app_password`**: Django user password. Default: `districtbuilderdistrictbuilder`

**`districtbuilder_admin_user`**: Django admin user. Default: 'districtbuilder'

**`districtbuilder_admin_email`**: Django admin user email. Default: `admin@admin.com`.

**`districtbuilder_admin_password`**: Django admin user password. Default: `districtbuilderdistrictbuilder`.

**`districtbuilder_database_password`**: PostgreSQL database Password. Default: `districtbuilderdistrictbuilder`

**`districtbuilder_database_user`**: PosgreSQL Database user. Default: `district_builder`.

**`districtbuilder_redis_password`**: Redis password. Default: `districtbuilderdistrictbuilder`.

**`districtbuilder_geoserver_user`**: Geoserver Admin user. Default: `admin`.

**`districtbuilder_geoserver_password`** Geoserver Admin password. Default: `geoserver`.