Retrieve foreign key fields in admin list display
---------------------------------------------------

Django admin has `ModelAdmin` class which provides admin options and functionality for the models in admin interface. It has options like `list_display`, `list_filter`, `search_fields` to specify fields for those options.

`search_fields`, `list_filter` and other options allow to include a ForeignKey or manytomanyfield with lookup API follow notation. For example, to search by book name in Bestselleradmin, we can specify `book__name` in search fields.


.. code-block:: python

   from django.contrib import admin

   from book.models import BestSeller


   class BestSellerAdmin(RelatedFieldAdmin):
       list_display = ('id', 'rank', 'year', 'book')
       search_fields = ('book__author', 'book__name')
       list_filter = ('year', 'rank')

   admin.site.register(Bestseller, BestsellerAdmin)


However Django doesn't allow the same follow notation in `list_display`. To include foreignkey field or manytomany field in the list display, we have to write a custom method and add this method in list display.

.. code-block:: python

   from django.contrib import admin

   from book.models import BestSeller


   class BestSellerAdmin(RelatedFieldAdmin):
       list_display = ('id', 'rank', 'year', 'book', 'author')

       def author(self, obj):
           return obj.book.author
       author.description = 'Author'

   admin.site.register(Bestseller, BestsellerAdmin)


This way of adding foreignkeys becomes tedious when there are lots of models with foreignkey fields.

We can write a custom admin class to dynamically set the methods as attributes whilst using the follow notation.


.. code-block:: python

    def get_related_field(name, admin_order_field=None, short_description=None):
        related_names = name.split('__')

        def dynamic_attribute(obj):
            for related_name in related_names:
                obj = getattr(obj, related_name)
                return obj

        dynamic_attribute.admin_order_field = admin_order_field or name
        dynamic_attribute.short_description = short_description or related_names[-1].title().replace('_', ' ')
        return dynamic_attribute


    class RelatedFieldAdmin(admin.ModelAdmin):
        def __getattr__(self, attr):
            if '__' in attr:
                return get_related_field(attr)

            # not dynamic lookup, default behaviour
            return self.__getattribute__(attr)


    class BestSellerAdmin(RelatedFieldAdmin):
        list_display = ('id', 'rank', 'year', 'book', 'book__author')
