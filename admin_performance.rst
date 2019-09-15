ORM Gotchas
==============


N+1 Queries


Caching
-------


Eager evaluation
------------------


Lazy evaluation
-----------------

book.author.id
book.author_id

qs.exist()


.iterator()



bulk operations

bulk update wont call save or signals
 Runpython wont call these


get only what you need


values_list()


enable query logging


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
