# -*- coding: utf-8 -*-
# Generated by Django 1.9.4 on 2016-04-03 00:42
from __future__ import unicode_literals

from django.db import migrations, models
import uuid


class Migration(migrations.Migration):

    dependencies = [
        ('subscribing', '0002_auto_20160402_1921'),
    ]

    operations = [
        migrations.CreateModel(
            name='Email',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False, unique=True)),
                ('subject', models.CharField(max_length=78)),
                ('sender', models.EmailField(default='alex@reckerfamily.com', max_length=254)),
                ('body', models.TextField()),
                ('is_sent', models.BooleanField(default=False, editable=False)),
                ('created', models.DateTimeField(auto_now_add=True)),
                ('modified', models.DateTimeField(auto_now=True)),
                ('sent', models.DateTimeField(editable=False, null=True)),
            ],
        ),
    ]
