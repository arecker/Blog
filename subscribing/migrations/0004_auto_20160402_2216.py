# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2016-04-03 03:16
from __future__ import unicode_literals

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('subscribing', '0003_email'),
    ]

    operations = [
        migrations.RenameField(
            model_name='subscriber',
            old_name='key',
            new_name='unsubscribe_key',
        ),
        migrations.AddField(
            model_name='subscriber',
            name='verify_key',
            field=models.UUIDField(default=uuid.uuid4, editable=False),
        ),
    ]