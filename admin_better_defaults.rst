Better Defaults
=================


Use list display
-----------------

When a model is registered with admin, it just shows the string representation of the model object.


.. code-block:: python

    from book.models import Book

    admin.site.register(Book)


.. image:: images/admin-defaults-list.png
   :align: center


Django provides ModelAdmin [#f1]_ class which represents a model in admin. It has `list_display` which can be used to display required fields.

.. code-block:: python

    from book.models import Book
    from django.contrib import admin

    class BookAdmin(admin.ModelAdmin):
        list_display = ('id', 'name', 'author')

    admin.site.register(Book, BookAdmin)

This will show relevant fields which are added in list_display.


.. image:: images/admin-defaults-list2.png
   :align: center


.. [#f1] https://docs.djangoproject.com/en/2.2/ref/contrib/admin/#modeladmin-objects






.. bibliography:: references.bib



Set ordering for custom fields
---------------------------------

.. code-block:: python

    def number_of_orders(self, obj):
        return obj.order__count
    number_of_orders.admin_order_field = 'order__count'



Auto completion
---------------



thumbnails

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


Allow editing in list view
----------------------------

When a model is heavily used to update the content, it makes to sense to allow bulk edits on the models.

.. code-block:: python

    class BookAdmin(admin.ModelAdmin):
        list_editable = ('author',)


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



Save as
-------


radio fields
-------------


Top/Bottom

Save on top/bottom



prepopluated fields


wsywig


date hierarchy
