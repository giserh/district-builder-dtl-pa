# -*- coding: utf-8 -*-
# Generated by Django 1.11.10 on 2018-10-18 21:16
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('redistricting', '0006_plansubmission_values_choices'),
    ]

    operations = [
        migrations.AlterField(
            model_name='plansubmission',
            name='contest_division',
            field=models.CharField(choices=[(b'ADULT', b'Adult (non-student)'), (b'YOUTH', b'Youth (Age 13 through Grade 12)'), (b'ACADM', b'Higher Ed (Undergraduate, graduate, professional')], max_length=5),
        ),
    ]
