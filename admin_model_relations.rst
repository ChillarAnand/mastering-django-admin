Managing Model Relationships
=============================


https://djangosnippets.org/snippets/2217/


Auto completion
-----------------

* `autocomplete_fields`


        autocomplete_fields = ['author']

for foreignkey fields


Hyperlink Foreignkeys To Its Change View In Admin
---------------------------------------------------

Consider Book model which has Author as foreignkey.


.. code-block:: python

    from django.db import models


    class Author(models.Model):
        name = models.CharField(max_length=100)

    class Book(models.Model):
        title = models.CharField(max_length=100)
        author = models.ForeignKey(Author)


We can register these models with admin interface as follows.


.. code-block:: python

    from django.contrib import admin

    from .models import Author, Book

    class BookAdmin(admin.ModelAdmin):
        list_display = ('name', 'author', )

    admin.site.register(Author)
    admin.site.register(Book, BookAdmin)


Once they are registered, admin page shows Book model like this.


.. image:: images/django-admin-fk-link-1.png
   :alt: hyperlink foreign key fields django
   :align: center


While browsing books, we can see book name and author name. Here, book name field is liked to book change view. But author field is shown as plain text.

If we have to modify author name, we have to go back to authors admin page, search for relevant author and then change name.

This becomes tedious if users spend lot of time in admin for tasks like this. Instead, if author field is hyperlinked to author change view, we can directly go to that page and change the name.

Django provides an option to access admin views by its URL reversing system. For example, we can get change view of author model in book app using reverse("admin:book_author_change", args=id). Now we can use this url to hyperlink author field in book admin.


.. code-block:: python

    from django.contrib import admin
    from django.utils.safestring import mark_safe


    class BookAdmin(admin.ModelAdmin):
        list_display = ('name', 'author_link', )

        def author_link(self, book):
            url = reverse("admin:book_author_change", args=[book.author.id])
            link = '<a href="%s">%s</a>' % (url, book.author.name)
            return mark_safe(link)
        author_link.short_description = 'Author'


Now in the book admin view, author field will be hyperlinked to its change view and we can visit just by clicking it.


Depending on requirements, we can link any field in django to other fields or add custom fields to improve productivity of users in admin.


Custom hyper links

https://docs.djangoproject.com/en/dev/ref/models/instances/#get-absolute-url



Allow ForeignKey Fields In Admin List Display
---------------------------------------------------

Django admin has `ModelAdmin` class which provides options and functionality for the models in admin interface. It has options like `list_display`, `list_filter`, `search_fields` to specify fields for corresponding actions.

`search_fields`, `list_filter` and other options allow to include a ForeignKey or ManyToMany field with lookup API follow notation. For example, to search by book name in Bestselleradmin, we can specify `book__name` in search fields.


.. code-block:: python

   from django.contrib import admin

   from book.models import BestSeller


   class BestSellerAdmin(RelatedFieldAdmin):
       search_fields = ('book__name', )
       list_display = ('id', 'year', 'rank', 'book')


   admin.site.register(Bestseller, BestsellerAdmin)


However Django doesn't allow the same follow notation in `list_display`. To include ForeignKey field or ManyToMany field in the list display, we have to write a custom method and add this method in list display.


.. code-block:: python

   from django.contrib import admin

   from book.models import BestSeller


   class BestSellerAdmin(RelatedFieldAdmin):
       list_display = ('id', 'rank', 'year', 'book', 'author')
       search_fields = ('book__name', )

       def author(self, obj):
           return obj.book.author
       author.description = 'Author'


   admin.site.register(Bestseller, BestsellerAdmin)


This way of adding foreignkeys in list_display becomes tedious when there are lots of models with foreignkey fields.

We can write a custom admin class to dynamically set the methods as attributes so that we can use the ForeignKey fields in list_display.


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


By sublcassing RelatedFieldAdmin, we can directly use foreignkey fields in list display.

However, this will lead to N+1 problem. We will discuss more about this and how to fix this in orm optimizations chapter.


https://github.com/theatlantic/django-nested-admin
