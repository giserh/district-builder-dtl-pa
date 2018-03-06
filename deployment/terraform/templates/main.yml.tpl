---
# Location of config.xml, districtbuilder_data.zip
user_data_dir: "{{ playbook_dir }}/../user-data/"
deployment_scripts_dir: "{{ playbook_dir }}/../scripts"

districtbuilder_app_home: "/opt/district-builder"

districtbuilder_image_version: "{{ image_version }}"
districtbuilder_user_config_file: true
districtbuilder_web_app_password: ${web_app_password}
districtbuilder_admin_user: ${admin_user}
districtbuilder_admin_email: ${admin_email}
districtbuilder_admin_password: ${admin_password}
districtbuilder_database_password: ${database_password}
districtbuilder_database_name: ${database_name}
districtbuilder_database_user: ${database_user}
districtbuilder_redis_password: ${redis_password}
districtbuilder_geoserver_password: ${geoserver_password}
districtbuilder_mailer_host: ${mailer_host}
districtbuilder_mailer_user: ${mailer_user}
districtbuilder_mailer_password: ${mailer_password}