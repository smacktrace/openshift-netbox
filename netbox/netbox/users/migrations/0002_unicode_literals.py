# -*- coding: utf-8 -*-
# Generated by Django 1.11 on 2017-05-24 15:34
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_api_tokens'),
    ]

    operations = [
        migrations.AlterField(
            model_name='token',
            name='write_enabled',
            field=models.BooleanField(default=True, help_text='Permit create/update/delete operations using this key'),
        ),
    ]
