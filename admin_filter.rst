Filtering In Admin
====================

Django Admin provies `search_fields` options on `ModelAdmin`. Setting this will enable a search box in list page to filter items on the model. This can perform lookup on all the fields on the model as well as related model fields.


.. code-block:: python

    class BookAdmin(admin.ModelAdmin):
        search_fields = ('name', 'author__name')

When the number of items in search_fields becomes more, query becomes
