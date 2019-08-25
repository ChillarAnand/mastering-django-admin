Better Defaults
=================


Set ordering for custom fields
---------------------------------

.. code-block:: python

    def number_of_orders(self, obj):
        return obj.order__count
    number_of_orders.admin_order_field = 'order__count'



Auto completion
---------------



JSON Editor
------------

Viewing and editing JSON field in admin interface will be very difficult with default text editor interface.


We can use 3rd packages like django-json-widget which provide JSON widget, with which viewing and editing JSON data becomes much intuitive.

.. code-block:: python

    from django.contrib import admin
    from django.contrib.postgres import fields
    from django_json_widget.widgets import JSONEditorWidget
    from .models import YourModel


    @admin.register(YourModel)
    class YourModelAdmin(admin.ModelAdmin):
        formfield_overrides = {
            fields.JSONField: {'widget': JSONEditorWidget},
        }




https://github.com/crucialfelix/django-ajax-selects



Sorting Models By Frequency
---------------------------


https://github.com/mishbahr/django-modeladmin-reorder


Read-only fields
-----------------

    readonly_fields=('first',)



form help text

https://docs.djangoproject.com/en/dev/ref/models/fields/#help-text
