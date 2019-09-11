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



Customize Header/Title
-----------------------


.. code-block:: python

    admin.site.site_header = 'My administration'



Plural names
--------------

.. code-block:: python


    class Category(models.Model):
        class Meta:
            verbose_name_plural = "categories"


Disable links
----------------


        self.list_display_links = (None, )



Disable full count
-------------------


.. code-block:: python

    show_full_result_count = False


Fetch only required fields
---------------------------


When a model is registered in admin, django tries to fetch all the fields of the table in the query. If there are any joins involved, it fetch fields of the joined tables also. This will slow down the query when the table size is big or number of results per page is more.

To make queries faster, we can limit the queryset to fetch only required fields.


.. code-block:: python


    class BookAdmin(admin.ModelAdmin):
        def get_queryset(self, request):
            qs = super().get_queryset(request)
            qs = qs.only('id', 'name')
            return qs


    admin.site.register(Book, BookAdmin)
